---
id: 323
title: 'How To: Specialize template functions using IBM Rational Rhapsody'
date: 2015-06-03T19:41:12+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=323
permalink: /how-to-specialize-template-functions-using-ibm-rational-rhapsody/
dsq_thread_id:
  - "5148616265"
categories:
  - C++
tags:
  - c++
  - ibm rational rhapsody
  - rhapsody
---
In this How To, I will guide you to create specialized template functions within IBM Rational Rhapsody.

If you follow the guide to specialize member functions within classes, you will get a code like this:

```cpp
//## class MyConvert
class MyConvert {
////    Constructors and destructors    ////

public :

    MyConvert();

    ~MyConvert();

    ////    Operations    ////

    //## operation strtox(char*,char*)
    template <typename T> inline static T strtox(char* in, char** end);

    //## operation strtox(char*,char**)
    template <> inline double strtox<double>(char* in, char** end) {
        //#[ operation strtox(char*,char**)
        return strtod(in, end);
        //#]
    }
};
```

In other words, function will be defined in class deceleration. However this is not allowed in C++. Compiler will complain:

```
error: explicit specialization in non-namespace scope 'class MyConvert'
```

We need to declare and implement those template specializations outside of the class. One workaround to this problem is not to define your functions inside the class, but in the package itself. Therefore, there will be nothing to implement within a class.

Here are the steps for that:


  * Right click the Package and click Add New -> Function.

  ![IBM Rational Rhapsody Architect for Software]({{ site.url }}/wp-content/uploads/2015/06/2015-06-03-12_13_19-IBM-Rational-Rhapsody-Architect-for-Software-TemplateTest.rpy-Object-Model-.png)

  * Go into Features of the new function. Change its name, mark it as **Template**.

  ![]({{ site.url }}/wp-content/uploads/2015/06/2015-06-03-12_15_18-Features.png)

  * Go into Template Parameters and add a new class / typename.

  ![]({{ site.url }}/wp-content/uploads/2015/06/2015-06-03-12_18_09-IBM-Rational-Rhapsody-Architect-for-Software-TemplateTest.rpy-Object-Model-.png)

  * Now, this is our base function. You may want to add arguments, change return type now.  If you are done, copy the function using right click or good old `Control + C`. Then paste it to `Functions` in the current package. **Optional**: If you won't want a default function for all types which are not specialized, go into Properties. Change `View Common` to all. CG::Generate::Specification will only create the prototype for the function. Thus, any typename/class which is not specialized will fail to link.

  ![]({{ site.url }}/wp-content/uploads/2015/06/2015-06-03-12_18_21-.png)

  * Go into Features of the new function, namely `strtox_copy` . Click Template Parameters on the tab and point `Primary Template` to original function we created before. This will change function name, arguments, etc. Further, template types will be copied too.

  ![]({{ site.url }}/wp-content/uploads/2015/06/2015-06-03-12_19_11-IBM-Rational-Rhapsody-Architect-for-Software-TemplateTest.rpy-Object-Model-.png)

  * Delete the Template which appeared on the upper area. This will allow us to specialize this typename.

  ![]({{ site.url }}/wp-content/uploads/2015/06/2015-06-03-12_19_20-IBM-Rational-Rhapsody-Architect-for-Software-TemplateTest.rpy-Object-Model-.png)

  * Now we can choose a type for the deleted template.

  ![]({{ site.url }}/wp-content/uploads/2015/06/2015-06-03-12_19_33-IBM-Rational-Rhapsody-Architect-for-Software-TemplateTest.rpy-Object-Model-.png)

  * Currently the function is not `inlined` and this will cause compilation error. Go to `Properties` tab, `CPP_CG::Operation::Inline` and choose `in_header`

  ![]({{ site.url }}/wp-content/uploads/2015/06/2015-06-04-10_09_51-Features.png)

When we generate the code now, it will appear like this in the header:

```cpp
#ifndef TemplateTest_TemplateTest_H
#define TemplateTest_TemplateTest_H

template <typename T> void strtox();

template <> void strtox<double>();

template <typename T> void strtox() {
}

template <> void strtox<double>() {
}

#endif
```

And now it's compilable.
