---
id: 278
title: 'TFTP &#8211; Path cannot be null'
date: 2015-02-19T01:12:00+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=278
permalink: /tftp-path-cannot-be-null/
categories:
  - 'Tricks &amp; Tips'
  - Windows
tags:
  - tftp
---
If TFTP gives an error message as

```
Path cannot be null. Parameter name: path
Illegal characters in path.
```

It means that you are giving the root directory in the argument. TFTP has a root directory and everything that is being fed to it should be **relative** to it.

If your root is `C:\tftp_root`

And your request is `C:\tftp_root\my\folder` then you should change it to `my\folder` only.

In case you need to go out of your scope, like `C:\Users\foo`, then you should do `..\Users\foo`
