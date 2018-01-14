---
id: 199
title: IRSTLM installation
date: 2013-07-16T20:03:44+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=199
permalink: /irstlm-installation/
dsq_thread_id:
  - "5262941956"
categories:
  - Linux
  - 'Tricks &amp; Tips'
tags:
  - irstlm
  - machine translation
  - ubuntu
---
If you get error

`aclocal: couldn't open directory 'm4': No such file or directory`

Create a directory called m4.

`mkdir m4`

If you get error

`libtool library used but 'LIBTOOL' is undefined`

Install libtool.

`sudo apt-get install libtool`

Just in case, install them too

```shell
sudo apt-get install csh
sudo apt-get install tcsh
```
