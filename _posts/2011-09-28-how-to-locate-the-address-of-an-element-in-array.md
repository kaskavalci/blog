---
id: 28
title: How to locate the address of an element in array
date: 2011-09-28T19:46:30+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=28
permalink: /how-to-locate-the-address-of-an-element-in-array/
categories:
  - C
  - Eclipse
---
Eclipse and gdb does not show the address of the element in the array. You might want to know the address to make sure boundaries of the array are correct. You should use address-of operand to get the address. Easy huh?

On gdb,

`p &array[element]`

On eclipse, open expressions tab and add `&array[element]` to Name field.

Sometimes you miss the easiest things.
