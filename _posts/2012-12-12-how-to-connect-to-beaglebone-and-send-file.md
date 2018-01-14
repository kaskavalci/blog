---
id: 147
title: How to connect to BeagleBone and send file
date: 2012-12-12T22:13:31+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=147
permalink: /how-to-connect-to-beaglebone-and-send-file/
categories:
  - BeagleBone
  - Linux
---
Make sure you connected your BeagleBone with ETH cable to your network. Host computer and BeagleBone should either be in same switch/router or you can directly connect it to your computer via "cross ethernet cable". Rest is easy, figure out board's ip address by `ifconfig eth0` and from your host machine,

ssh root@**IPADDR**

That's it! Beaglebone have a hostname called, beaglebone.local. So you can type that as IP address too.

If you want to send file back from your beaglebone, then you need to install SSH server to your host machine.

```shell
sudo apt-get install openssh-server
```

Or you can go to your home folder, then click **Browse Network.** You can see the Beagle there. However, sometimes it doesn't work. For example right now, I cannot see it there but I can connect it with command line. Well, I guess command line is your friend 🙂

Also, you can use FileZilla for SSH connection. just choose SSH as connection type and write IP and user information.
