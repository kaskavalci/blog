---
id: 142
title: 'Graphical installers are not supported by the VM. The console mode will be used instead&#8230;'
date: 2012-12-11T20:29:39+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=142
permalink: /graphical-installers-are-not-supported-by-the-vm-the-console-mode-will-be-used-instead/
dsq_thread_id:
  - "5150079477"
categories:
  - Linux
  - 'Tricks &amp; Tips'
---
It is because you have 64 bit libraries and the program requires 32 bit libraries. Answer is simple! install `ia32-libs` libraries. On Ubuntu,

`sudo apt-get install ia32-libs`

That will be all!
