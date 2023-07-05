---
layout: single
title: "Connecting back home with OpenVPN"
tags:
 - linux
 - homeautomation
---

I use OpenVPN server from my router to connect back home. I imported my OpenVPN
config to Pritunl and tried to connect. It fails with

```
Options error: --nobind doesn't make sense unless used with --remote/n
```

It doesn't say much from the error message, unfortunately. Quick search yielded
[this](https://forum.pritunl.com/t/options-error-nobind-doesnt-make-sense-unless-used-with-remote/556)
post from pritunl forum. Pritunl expects a certain format for `remote` and
silently ignores if it is not formatted as it expects. This is unfortunate
because as per [OpenVPN 2.5 reference
manual](https://openvpn.net/community-resources/reference-manual-for-openvpn-2-5/).

```
Valid syntaxes:

remote host
remote host port
remote host port proto

The port and proto arguments are optional.
```

So, in order to fix this error, add your proto to your remote. Search for proto
in your config (either tcp or udp) and append it to your remote configuration.

## OpenVPN 2.6 and Ciphers

When I tried to connect with OpenVPN 2.6 via command line, then a new error
emerged with deprecated options.

```
2023-07-05 12:18:12 OPTIONS ERROR: failed to negotiate cipher with server. Configure --data-ciphers-fallback if you want to connect to this server.
2023-07-05 12:18:12 ERROR: Failed to apply push options
```

To resolve that problem, replace `cipher` with `data-ciphers-fallback` in your
config.

```sh
# Linux
$ sed -i 's/cipher/data-ciphers-fallback/g' vpn-config.ovpn

# Mac
$ brew install gsed
$ gsed -i 's/cipher/data-ciphers-fallback/g' vpn-config.ovpn
```

And you're good to go!
