---
id: 267
title: Cygwin sshd, connection closed by .
date: 2015-01-15T22:14:08+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=267
permalink: /cygwin-sshd-connection-closed-by/
dsq_thread_id:
  - "5149602092"
categories:
  - Linux
  - 'Tricks &amp; Tips'
  - Windows
tags:
  - cygwin
  - ssh
---
Configured `openssh` server from Cygwin, but you have `"Connection closed by ."` error. Reason is most probably you have an public key on your client and ssh is using that to access server. Server is somehow closing connection.

For my case it is due to changed password on server machine. Even though password has been changed, somehow ssh doesn't recognize it and closes connection. Too bad that even level 3 debugging doesn't help to recover.

You should do a  `passwd` in your server machine. Type in your password and it will save it to registry.

Make sure you did this (for generating the rsa-key)

```shell
$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/jurn/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/jurn/.ssh/id_rsa
Your public key has been saved in /home/jurn/.ssh/id_rsa.pub
$ cd ~/.ssh
$ cat id_rsa.pub >> authorized_keys
$ chmod 600 authorized_keys
```

Copy id_rsa to your server, and try again. It should work!
