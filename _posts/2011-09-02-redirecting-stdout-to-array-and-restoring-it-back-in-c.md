---
id: 10
title: Redirecting stdout to array and restoring it back in C
date: 2011-09-02T02:51:36+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=10
permalink: /redirecting-stdout-to-array-and-restoring-it-back-in-c/
dsq_thread_id:
  - "5148753900"
categories:
  - C
tags:
  - c
  - stdout
---
### How can I capture stdout in array or file then restore it back in C?

That is a hard question. You can redirect stdout very easily, problem arises when you try to restore it back. Here is the code snippet to redirect and save the stdout status:

```c
int stdout_save;
char buffer[BIG_ENOUGH];
fflush(stdout); //clean everything first
stdout_save = dup(STDOUT_FILENO); //save the stdout state
freopen("NUL", "a", stdout); //redirect stdout to null pointer
setvbuf(stdout, buffer, _IOFBF, 1024); //set buffer to stdout
```

The reason we redirect stdout to NULL is to see no output on screen. This is handy if you want to modify the data before printing on screen. setvbuf sets a buffer to stdout and it will fill the buffer when it reaches 1024 bytes.

In order to restore stdout and be able to print to screen again:

```c
freopen("NUL", "a", stdout); //redirect stdout to null again
dup2(stdout_save, STDOUT_FILENO); //restore the previous state of stdout
setvbuf(stdout, NULL, _IONBF, MDT_BUFSIZE); //disable buffer to print to screen instantly
```

Enjoy!
