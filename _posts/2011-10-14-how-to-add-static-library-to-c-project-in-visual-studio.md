---
id: 55
title: How to add static library to C++ project in Visual Studio
date: 2011-10-14T20:41:30+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=55
permalink: /how-to-add-static-library-to-c-project-in-visual-studio/
categories:
  - C++
  - 'Tricks &amp; Tips'
  - Windows
tags:
  - msvc
  - static library
---
The version doesn't matter. I haven't tried this with Visual Studio 2005 though but the process is the same for 2008 and 2010. Here's it is:

  1. Create your library project by choosing static library in project wizard.
  2. Create your project that will use the library.
  3. Important step is, those two projects need to be in same solution. So don't forget to choose **Add to solution** in Solution tab under new project wizard. Otherwise, your project won't be able to see library.
  4. Choose your project on projects manager and click on **Project > References**. Then under **Common Properties** choose **Framework and** **References** section. Then click on **Add New Reference**. You will be able to see your library on this list. If not, you either couldn't create your library project or they are in different solutions.
  5. Enjoy!

For a complete guide please visit [MSDN](http://msdn.microsoft.com/en-us/library/ms235627%28v=VS.100%29.aspx) website.
