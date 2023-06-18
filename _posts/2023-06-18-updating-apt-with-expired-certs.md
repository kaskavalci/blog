---
layout: single
title: "Updating apt packages when root certificates are expired"
tags:
 - linux
---

When you left a computer unplugged for too long, some things start to break.
Certificates are one of them. Since all certificates come with an expiration
date, leaving a computer off of internet for too long makes them obsolote. You
may get errors like

```sh
$ sudo apt install --reinstall ca-certificates
Err:1 https://mirror.serverius.net/raspbian/raspbian buster/main armhf ca-certificates all 20200601~deb10u2
  Certificate verification failed: The certificate is NOT trusted. The certificate chain uses expired certificate.  Could not handshake: Error in the certificate verification. [IP: 91.221.69.39 443]
E: Failed to fetch https://mirror.serverius.net/raspbian/raspbian/pool/main/c/ca-certificates/ca-certificates_20200601~deb10u2_all.deb  Certificate verification failed: The certificate is NOT trusted. The certifica
te chain uses expired certificate.  Could not handshake: Error in the certificate verification. [IP: 91.221.69.39 443]
E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
```

Luckily, there is a very simple way to resolve this.

```sh
sudo apt -o "Acquire::https::Verify-Peer=false" update
sudo apt -o "Acquire::https::Verify-Peer=false" upgrade
```

Source:
[forums.raspberrypi.com](https://forums.raspberrypi.com/viewtopic.php?p=2113519&sid=8468d0f617e1b90040acc846ab4f9b98#p2113519)
