---
id: 73
title: LPCWSTR thing on MSVC
date: 2012-01-04T11:34:04+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=73
permalink: /lpcwstr-thing-on-msvc/
categories:
  - C++
tags:
  - msvc
---
**Aim**: I want to retrieve a string from user and create a directory accordingly.

**Problem**: Compiler says

> _error C2664: 'CreateDirectoryW' : cannot convert parameter 1 from 'char *' to 'LPCWSTR'_

**Solution**:

Quick fix: change `CreateDirectory` function call to `CreateDirectoryA` You're good to go!

But what was it?

It seems Windows wants to support his forefathers Windows 98 and ME. They support ASCII and newer versions of Windows supports Unicode. That is why in compilation step, your function call `CreateDirectory` will be converted to `CreateDirectoryW` which is a Unicode function or `CreateDirectoryA`, ASCII function. If you use wide characters everywhere in your code, it's better to use Unicode of course. However if you depend on libraries which gives you ASCII string, you should either convert your ASCII to Unicode or just use ASCII functions.
