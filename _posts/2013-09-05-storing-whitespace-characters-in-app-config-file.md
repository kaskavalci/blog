---
id: 206
title: Storing whitespace characters in App.config file
date: 2013-09-05T14:21:02.000Z
author: Halil Can Kaşkavalcı
layout: single
guid: 'http://kaskavalci.com/?p=206'
permalink: /storing-whitespace-characters-in-app-config-file/
dsq_thread_id:
  - '5156247820'
categories:
  - 'C#'
  - Visual Studio
  - Windows
tags:
  - visual studio
  - vs2012
  - whitespace
---

# Problem

I want to store a deliminator in String form. It can be tab, newline, carriage return or anything like `;\r\n`. User should be able to change in via UI and application should store this value into User.config or App.config file.

Problem is simple, let's say you have a Settings variable which is `String` and you want to save `\t` tab character. It will result in storing a tab and `newline` character. When you try to read it again, you will have `\t\r\n`.

# Diagnosis

VS2012 XML handler do not preserve whitespace characters when you try to save the existing configuration. And also you cannot specify Save() function to preserve whitespaces like you do in XMLDocument.PreserveWhitespace property. Apparently this is a bug in VS and do not expect this to be solved quickly.

# Solution

Since whitespace characters cannot be saved, let's create a alias mapping for them. It is not a solution but a workaround. Create an alias table like this

Name            | Mapping
--------------- | -------
Tab             | 0
Newline         | 1
Carriage Return | 2
Others          | 3

Then overwrite your variable depending on this selection here. If user specifies Other then write this value to Settings. If you want 100% accuracy you can check for whitespaces here and use more options in alias table.

This seemed to be only option to me.

[Here](http://stackoverflow.com/questions/18629807/store-a-single-character-tab-new-line-any-character-in-user-config-file) is the question that I asked on StackOverflow but there isn't any better answer than that.
