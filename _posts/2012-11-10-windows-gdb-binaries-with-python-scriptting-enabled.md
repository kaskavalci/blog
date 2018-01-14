---
id: 132
title: Windows GDB binaries with Python scriptting enabled
date: 2012-11-10T21:00:43+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=132
permalink: /windows-gdb-binaries-with-python-scriptting-enabled/
dsq_thread_id:
  - "5149583109"
categories:
  - C
  - C++
  - Windows
tags:
  - gdb
  - python
  - python enabled gdb
---
You may want to have GDB binaries for Windows. I use MinGW and I tried to do

`mingw-get install gdb-python`

Yay! It downloaded! But you'll need Python libraries as well. My `python27.dll` failed to work. So I found this: [QT's GDB binaries](http://origin.releases.qt-project.org/gdb/ "QT official website").  So All you have to do download and extract the package into your `MinGW\bin` directory. Then point to `gdb-i686-pc-mingw32.exe` or if you have downloaded earlier `gdb-python27.exe`
