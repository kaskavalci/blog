---
id: 114
title: Inherited static variables gives linkage error
date: 2012-10-28T21:48:47+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=114
permalink: /inherited-static-variables-gives-linkage-error/
categories:
  - C++
tags:
  - inheritance
  - linkage error
  - static variables
---
If you try to access inherited static variables from upper class, you will end up with errors like

`Population.cpp:38: undefined reference to 'std::Common::crrate'`

This is because static variables needs to be declared in source code of the using class as well. However, they have to outside of the class definition. Here is an example:

```cpp
// MyClass.h
class MyClass {
public:
	static int GetVar() {
		return shared_variable;
	}
private:
	static int shared_variable;
};

// MyClass.cpp
#include "MyClass.h"
int MyClass::shared_variable; // Also do any initialization if needed.
```

Yep, C++ is a strict language.
