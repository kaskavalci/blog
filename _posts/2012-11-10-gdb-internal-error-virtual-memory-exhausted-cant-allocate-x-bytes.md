---
id: 129
title: 'gdb internal-error: virtual memory exhausted: can&#8217;t allocate x bytes.'
date: 2012-11-10T20:57:38+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=129
permalink: /gdb-internal-error-virtual-memory-exhausted-cant-allocate-x-bytes/
dsq_thread_id:
  - "5157017734"
categories:
  - C
  - C++
  - Eclipse
  - Windows
tags:
  - eclipse
  - gdb
---
This error made me work for hours. It happens when you have Python enabled GDB and gdbinit ready on Eclipse. So default debugger on Eclipse makes debugger to stop at main. Apparently GDB with Python have some problems with that. Problem occurs when you try to stop at Main! So if you go into Debugging options and disable stopping at main, you'll have no errors. Argh!

![]({{ site.url }}/wp-content/uploads/2012/11/gdberror.jpg "Disabling GDB to stop at main on Eclipse")
