---
id: 45
title: Declaring array with an initial value in C++
date: 2011-10-12T14:37:40+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=45
permalink: /declaring-array-with-an-initial-value-in-c/
categories:
  - C++
  - 'Tricks &amp; Tips'
tags:
  - array
  - c++
---
If you declare an array like

```cpp
int myArr[10] = {};
```

It will initiate your array with all values

```cpp
int myArr[10] = {-1};
```

This will initiate your array with first element **-1** and the rest.

If you want to fill your array with specific length and number, you should use native std::fill or std::fill_n functions. For more information about those functions and use please visit [C++ Reference](http://www.cplusplus.com/reference/algorithm/fill/).
