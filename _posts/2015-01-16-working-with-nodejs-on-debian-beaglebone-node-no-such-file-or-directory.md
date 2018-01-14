---
id: 273
title: 'Working with nodejs on Debian / Beaglebone. Node: no such file or directory'
date: 2015-01-16T22:17:56+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=273
permalink: /working-with-nodejs-on-debian-beaglebone-node-no-such-file-or-directory/
categories:
  - BeagleBone
  - Linux
tags:
  - nodejs
---
This is due to package manager naming issue. Node should be installed as node, not nodejs. All you need to do is link nodejs to node:

```shell
sudo ln -s /usr/bin/nodejs /usr/bin/node
```

You're good to go!
