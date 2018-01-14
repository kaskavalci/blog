---
id: 447
title: 'HowTo: Set default username for ssh remote hosts'
date: 2016-01-06T10:09:47+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=447
permalink: /howto-set-default-username-for-ssh-remote-hosts/
dsq_thread_id:
  - "5175597089"
categories:
  - Linux
  - 'Tricks & Tips'
---
If your local username is different than your remote host it may be frustrating to type that username at each connection. Luckily, ssh comes with a config file that we can adjust.

Create the config file under`~/.ssh` directory.

`touch ~/.ssh/config`

Edit the file as such:
```
    Host myDomain.com
        User foo
    Host *.myAnotherDomain
        User bar
    Host *
        User foobar
```

You can use asterisk to match all hosts or subdomains. The configuration above will use

1. User `foo` for `myDomain.com`

2. User `bar` for all subdomains under `myAnotherDomain.com`

3. User `foobar` for any host that doesn't match with above.

### Note for Windows Users

If you are using PuTTY, maybe it's time for you to switch to GNU tools. [MinGW](http://www.mingw.org/) or [Cygwin](https://www.cygwin.com/) is a great start for that.

However, that GNU tools come with their own home directory. So, if you are using MinGW Shell, then your home directory is may not be your Windows home directory. Type `printenv | grep HOME` and it will show your POSIX home directory. So, if you are using MinGW shell for ssh, you should create that config under that directory. Otherwise, your good old Windows Home `%USERPROFILE%`

Enjoy hacking 🙂
