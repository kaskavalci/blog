---
id: 61
title: Sprintf overwrites argument!
date: 2011-12-22T10:56:30+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=61
permalink: /sprintf-overwrites-argument/
dsq_thread_id:
  - "5204298795"
categories:
  - C
---
A relatively easy one line of code, but doesn't work properly.

`sprintf(target\_str, "write %s", copied\_str);`

Somehow, copied_str is changing. I tried making it **const** but no luck, still changing. Then I realized `target\_str` is not big enough for overall string. That's why it was overwriting because `target\_str` and `copied\_str` are defined in a row! So which means their addresses are sequential. I increased the size of `target\_str`, and problem solved.

Moral of the story, never be mean about string lengths.
