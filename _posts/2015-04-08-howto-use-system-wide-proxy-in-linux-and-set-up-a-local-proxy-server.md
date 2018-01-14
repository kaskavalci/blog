---
id: 309
title: 'HowTo : Use system-wide proxy in linux and set up a local proxy server'
date: 2015-04-08T18:43:39+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=309
permalink: /howto-use-system-wide-proxy-in-linux-and-set-up-a-local-proxy-server/
dsq_thread_id:
  - "5151249764"
categories:
  - BeagleBone
  - Linux
  - 'Tricks &amp; Tips'
tags:
  - cntlm
  - linux
  - proxy
---
Let's say you have a board (beaglebone, raspberry pi, etc) and you want to connect internet by using a proxy server. Your work network may not allow this little guy or you may be in a closed-network with one gateway -- proxy.

# Use system-wide proxy

First, let's see how to configure system-wide proxy in linux. Most programs honor http_proxy environmental variable. Let's add them permanently in the system.

Open the file `/etc/environment`

Add the following lines, update as necessary.

```shell
http_proxy=http://proxy.com:8080/
HTTP_PROXY=http://proxy.com:8080/
https_proxy=http://proxy.com:8080/
HTTPS_PROXY=http://proxy.com:8080/
ftp_proxy=http://proxy.com:8080/
FTP_PROXY=http://proxy.com:8080/
```

Great! However, you will notice, `apt-get`  will not work. You need to change one more file for that.

Open the file `/etc/apt/apt.conf`. Add following lines, update as necessary.

```
Acquire::http::Proxy "http://proxy.com:8080";
Acquire::https::Proxy "http://proxy.com:8080";
Acquire::ftp::Proxy "http://proxy.com:8080";
```

#  Set up local proxy server

[cntlm](http://cntlm.sourceforge.net) is a great proxy server written in C. Install it to your machine.

  * Configure cntlm.ini file that fits to your network configuration (`Domain`, `Username`, `Password` tag).
  * Specify any proxy that you have in your nework. (`Proxy` tag).
  * Give a proxy port (`Listen` tag).
  * Give permission to a certain address range (`Allow` tag). You can use CIDR notation. (i.e. 192.168.0.0/16).

Cntlm should register itself as a service. You can run it explicitly by calling **Start Cntlm Authentication Proxy**.

Voila, your proxy server should be running now.
