---
id: 231
title: Passing objects / classes with Guice
date: 2014-02-16T23:26:57+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=231
permalink: /passing-objects-classes-with-guice/
categories:
  - Java
tags:
  - Guice
  - Opt4J
---
`@BindConstant` will only let you to bind primitive data types such as int, char or String. If you want to pass a custom object, instance or class you need to use `@Provides` keyword. Let's say your class which extends `AbstractModule` has a setter,

```java
public class GAModule extends AbstractModule{
	//@Constant(value = "elements")
	protected List<Foo> elements;

	@Provides List<Foo> getElements() {
		return elements;
	}

	public void setElements(List<Foo> elements) {
		this.elements = elements;
	}
//...
```

Call setElements from outer class. When you need it within Guice, use `@Provider`

```java
public class FooUser {
	Provider<List<Foo>> elementsProvided;

	@Inject
	public FooUser( Provider<List<Foo>> elementsProvided) {
		this.elementsProvided= elementsProvided;
		List<Foo> elements = elementsProvided.get();
		//Now you can access the elements!
	}
}
```

That's it! It took me a long time to find this. In my case, I want to use Opt4J (a multi objective genetic algorithms library for Java) and I want to pass a List of objects to Creator class. I implemented setter class in Module class and used `@Provider` keyword in Creator class. Works like a charm now.

I hope it helps you and saves the time that cost me!
