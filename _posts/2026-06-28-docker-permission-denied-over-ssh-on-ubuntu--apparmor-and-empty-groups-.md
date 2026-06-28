---
title: "Docker permission denied over SSH on Ubuntu (AppArmor and empty groups)"
date: 2026-06-28
tags:
  - ubuntu
  - docker
  - apparmor
  - ssh
  - openssh
---

I run Docker on a hardened Ubuntu 24.04 VPS. `halil` is in the `docker` group, and everything works fine on the console. Over SSH, though, `docker ps` failed with permission denied — unless I ran `newgrp docker` first.

That was annoying enough to dig into. It turned out not to be a Docker problem at all.

## The Problem

On a fresh SSH login, `id` looked wrong:

```
uid=1000(halil) gid=0(root) groups=0(root)
```

No supplementary groups. No `986(docker)`. Docker correctly refused the socket.

On disk, membership was fine:

```
$ getent group docker
docker:x:986:halil
```

So NSS knew about the group; the **session** did not.

Auth logs showed the real failure during login:

```
pam_systemd(sshd:session): Access denied
pam_limits(sshd:session): Operation not permitted
Attempt to write login records by non-root user
```

## The Investigation

AppArmor audit logs pointed at `sshd`:

```
apparmor="DENIED" operation="dbus_method_call"
  interface="org.freedesktop.home1.Manager"
  member="GetUserRecordByName"
  label="/usr/sbin/sshd"
```

And:

```
apparmor="DENIED" operation="exec"
  profile="/usr/sbin/sshd"
  name="/usr/sbin/pam-tmpdir-helper"
```

The stock Ubuntu AppArmor profile for `/usr/sbin/sshd` was **enforcing**, but it did not allow everything `pam_systemd` and `pam_systemd_home` need to set up a proper login session. PAM partially succeeded, the user shell started, but supplementary groups never landed.

A bisect confirmed it: with the sshd profile disabled, groups worked. With stock enforce mode, they broke again. `pam_cap.so` was a red herring — enabling it alongside a fixed profile is fine.

Switching the profile to **complain** mode also worked (AppArmor logs `ALLOWED` instead of blocking), which was useful to see exactly which rules were missing.

## The Solution

The fix belongs in AppArmor’s local override — not by editing the main profile. Ubuntu merges `/etc/apparmor.d/local/usr.sbin.sshd` into the package profile, so apt upgrades won’t wipe your changes.

Create or edit the file:

```bash
sudo tee /etc/apparmor.d/local/usr.sbin.sshd << 'EOF'
# Allow PAM session setup over SSH (pam_systemd_home + pam_tmpdir)
dbus (send)
    bus=system
    path=/org/freedesktop/home1
    interface=org.freedesktop.home1.Manager
    member=GetUserRecordByName
    peer=(label=unconfined),

/usr/sbin/pam-tmpdir-helper rix,
EOF
```

Reload the profile (no need to restart SSH — open a **new** login afterward):

```bash
sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.sshd
```

Verify on a fresh SSH session:

```
uid=1000(halil) gid=1000(halil) groups=1000(halil),27(sudo),100(users),986(docker)
```

`docker ps` should work without `newgrp`.

## Why This Happens

Two things collided on this host:

1. **Security hardening** left AppArmor enforcing on `sshd`.
2. **`pam_systemd_home`** landed in the PAM stack (Ubuntu/systemd update around mid-2025), which talks to `org.freedesktop.home1` during session setup.

The stock `usr.sbin.sshd` AppArmor profile predates that combination. Under enforce mode, blocked D-Bus and exec calls mean PAM cannot finish session setup — so you get a shell with the wrong credentials, even though `/etc/group` is correct.

If you hit the same symptom, check audit logs:

```bash
sudo grep apparmor /var/log/audit/audit.log | grep sshd | tail -20
```

Or temporarily use complain mode to collect candidates:

```bash
sudo aa-complain /usr/sbin/sshd
# fresh login, then inspect ALLOWED lines in audit.log
```

## Workarounds I Tried First

For the record, these also “fixed” Docker but were not where I wanted to stay:

- Disabling the sshd AppArmor profile entirely (`/etc/apparmor.d/disable/usr.sbin.sshd`)
- Leaving the profile in complain mode forever
- `setfacl` on `/var/run/docker.sock` (masks the symptom, not the session bug)

The local override keeps AppArmor **enforcing** and restores correct PAM sessions. On my box, re-enabling `pam_cap.so` afterward still works — full hardening, working groups, no `newgrp` ritual.
