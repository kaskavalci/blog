---
id: 276
title: MinGW shell cannot find gcc, g++ and others
date: 2015-02-09T16:50:29+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=276
permalink: /mingw-shell-cannot-find-gcc-g-and-others/
dsq_thread_id:
  - "5148639411"
categories:
  - 'Tricks &amp; Tips'
  - Windows
tags:
  - mingw
---
Tired of fixing PATH every time you run the MinGW shell? Solution is easy. Navigate to `%YOUR\_MINGW\_DIR%\msys\1.0\etc` and rename `fstab.sample` to `fstab`. Restart your MinGW shell. Your `/mingw/` path now will be bind to `C:\MinGW`.

In case you are wondering where is MinGW shell, it is `%YOUR\_MINGW\_DIR%\msys\1.0\msys.bat`

MinGW is usually installed on `C:\MinGW`.

You are welcome.
