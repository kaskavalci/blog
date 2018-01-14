---
id: 285
title: Eclipse build disregards Makefile, creates folder Default
date: 2015-03-02T18:14:00+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=285
permalink: /eclipse-build-disregards-makefile-creates-folder-default/
dsq_thread_id:
  - "5261972903"
categories:
  - Uncategorized
---
If you change your toolchains and save, then you will realize your makefile changes will make no effect and Eclipse will create a mysterious folder named Default, based on PWD environmental variable. This is due to a bug in Eclipse that enabled automatic makefile creation when you change toolchains.

To disable it, Go to project properties > C/C++ Build and disable "Generate Makefiles automatically"

![Eclipse - Project Properties - C/C++ Build]({{ site.url }}/wp-content/uploads/2015/03/2015-03-02-11_11_09-Properties-for-oco.png)
