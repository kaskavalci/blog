---
id: 183
title: Deploying Qt applications in Windows
date: 2013-07-10T12:37:50+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=183
permalink: /deploying-qt-applications-in-windows/
dsq_thread_id:
  - "5148639418"
categories:
  - 'Tricks &amp; Tips'
  - Windows
tags:
  - deploy
  - qt
---
If you double click your application you will receive this error:

![]({{ site.url }}/wp-content/uploads/2013/07/2013-07-10-12_22_59-UCT.exe-System-Error.png "The Program can't start because Qt5Cored.dll is missing from your computer. Try reinstalling the program to fix this problem.")

This is due to your qt dll's are missing from system path. Open your system environment variables page and add Qt path which is something like `C:\Qt\Qt5.1.0\5.1.0\mingw48_32\bin` to your path.

However, if you add this path to end of the Path variable, you will encounter this Entry Point Not Found error:

![]({{ site.url }}/wp-content/uploads/2013/07/2013-07-10-12_28_05-UCT.exe-Entry-Point-Not-Found.png "Entry Point Not Found" alt="The procedure entry point InterlockedCompareExchange@12 could not be located in the dynamic link library ...")

In order to solve this, please add your path to beginning of your Path variable. If it is the first item, your application will run smoothly.

If you want to deploy your application, you should use [Dependency Walker](http://www.dependencywalker.com) to find which dlls you use and copy them into program directory.

For further information please refer to Qt official website about [deploying Qt applications](http://qt-project.org/doc/qt-5.0/qtdoc/deployment-windows.html "Deploying an Application on Windows").
