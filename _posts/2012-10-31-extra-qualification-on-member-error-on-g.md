---
id: 126
title: Extra qualification on member error on g++
date: 2012-10-31T22:36:54+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=126
permalink: /extra-qualification-on-member-error-on-g/
dsq_thread_id:
  - "5148769186"
categories:
  - C++
---
In C++ you declared a method and tried to compile it and boom you get an error like this: extra qualification x on member y. You get this error because you try to declare a method in class definition like this:

```cpp
class Individual {
public:
	Individual& Individual::operator= (Individual &target);
}```

You cannot declare a method inside a class like this. Instead, remove :: part.

```cpp
class Individual {
public:
	Individual& operator= (Individual &target);
}
```

Now you are good to go!
