---
id: 116
title: Array of objects with no default constructor
date: 2012-10-29T02:16:43+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=116
permalink: /array-of-objects-with-no-default-constructor/
categories:
  - C++
tags:
  - initialization
  - no default constructor
  - object
  - vector
---
If you want to have an array of objects which have no default constructor, it's really hard to do with arrays. Best way is to use vectors. Because unlike arrays, vectors let us choose which constructor to be used when creating objects. Here is the example:

Let ClassA takes ClassC as arguement.

ClassA.h
```cpp
class ClassA {
public:
	ClassA(ClassC *pointer_to_ClassC);
};
```

In ClassB, declare the vector.

ClassB.h

```shell
class ClassB {
private:
	std::vector<ClassA> myVector;
};
```

In source code, I first initializing the vector with n instances directly by calling the constructor of vector, however it didn't help to create n instances of **ClassA**. It works if you push items one by one to the vector.

ClassB.cpp

```cpp
ClassC *ClassCInstance = new ClassC();
for (i = 0; i < 10; ++i) {
     myVector.push_back(ClassA(ClassCInstance));
}
```
