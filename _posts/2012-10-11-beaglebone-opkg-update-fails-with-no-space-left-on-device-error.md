---
id: 92
title: 'BeagleBone opkg update fails with &#8220;no space left on device&#8221; error'
date: 2012-10-11T22:07:59+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=92
permalink: /beaglebone-opkg-update-fails-with-no-space-left-on-device-error/
dsq_thread_id:
  - "5148639404"
categories:
  - BeagleBone
  - Linux
---
Hours spent on nothing! Doing it twice will not solve the problem. Don't worry you don't have to upgrade your SD card. The reason you have this error because **opkg** has a forgotten bug which makes it use the memory instead of sd card. So, basically BeagleBoard runs out of memory. Solution? Let's use the SD card. Use this commands instead. This will chance temporary directory to your home directory.

```shell
opkg -t ~ update
opkg -t ~ upgrade
opkg -t ~ install package_name
```

Enjoy the development!
