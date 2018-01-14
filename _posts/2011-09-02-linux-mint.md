---
id: 6
title: Linux Mint
date: 2011-09-02T02:27:24+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=6
permalink: /linux-mint/
dsq_thread_id:
  - "5160005712"
categories:
  - Linux
tags:
  - linux
  - mint
---
I'm not a linux fan. I tried my best to get along with her but every time we had bad moments and broke up. Few days ago I was complaining about Ubuntu and my problems with driver and media issues. He told me to try Mint, which is adapted for daily use. So I gave it a try.

Good thing about Mint, video and music codec comes default. So you don't have to install mp3, divx codec or flash plugin. However I had some problems as well.

### Num Lock Enabling on startup

It is always a pain. Here's what you should do. I did that but haven't tested yet.

  1. On terminal, type **sudo aptitude install numlockx**
  2. Again on terminal type, **sudo gedit /etc/X11/Xsession**
  3. At the end of the file, find exit 1 and above that line, paste the following code:

```shell
    if [ -x /usr/bin/numlockx ]; then
    /usr/bin/numlockx on
    fi
```
  4. Open Mint Menu and type `Keyboard`, then `Layout > Options > Misc compatibility options > Default numeric keypads keys`.

Hope this helps!

### Disabling Mint custom Google search on Mozilla

Ok mint developers, you want some money but changing Google's layout is way too much. No suggestions, terrible interface and no options for timeline. Here is what you should do:

  1. Open Firefox add ons and remove **Mint Search Enhancer**
  2. Go to [this page](https://addons.mozilla.org/en-US/firefox/addon/google-language-en/) and install Google English search or whichever language you prefer:
  3. Click on small arrow on search bar and click Manage Search Engines and delete Google. Move up Google EN

Apart from small EN text on Google logo, everything works fine!
