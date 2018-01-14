---
id: 81
title: Blue Screen of Death on AHCI mode
date: 2012-08-21T09:49:21+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=81
permalink: /blue-screen-of-death-on-ahci-mode/
categories:
  - Windows
tags:
  - ahci
  - bsod
  - driver
  - windows 7
---
You might have read that changing your hard drive to AHCI mode will boost your speed or somehow reset your BIOS and get AHCI enabled by default. And your windows will be like

![Blue Screen of Death](http://kaskavalci.com/wp-content/uploads/2012/08/2012-08-21-01.18.04-300x225.jpg "BSOD on AHCI mode").

Don't worry your computer is not bricked. The problem is Windows does not enable AHCI drivers by default. You can simply tell Windows to do so by changing registry value. Go to Start > Run and type **regedit**. Then locate the key `HKEY\_LOCAL\_MACHINE\System\CurrentControlSet\Services\Msahci`. Change it to 0 (zero). Or, you could simply download the tool from Microsoft to fix it. In order to download tool, [click here](http://go.microsoft.com/?linkid=9741862 "Microsoft FixIt").

For my case interestingly I haven't changed the mode nor reset my BIOS. Somehow Windows stopped working with AHCI. Of course I wouldn't know it. So I disassembled my laptop and checked all the connections etc. However problem was simply changing a registry entry. Well, those things happen I guess 🙂
