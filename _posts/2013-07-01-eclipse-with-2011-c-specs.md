---
id: 161
title: Eclipse with 2011 C++ specs
date: 2013-07-01T14:53:36+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=161
permalink: /eclipse-with-2011-c-specs/
categories:
  - C++
  - Eclipse
  - 'Tricks &amp; Tips'
---
In order to compile C++11 code and make eclipse indexer see the included header files, several configurations need to be updated.

Common problems associated with this feature is

  * Eclipse cannot found included reference
  * Eclipse Indexer does not work
  * C++11 STL containers cannot be found.
  * etc.

First, in order to compile C++11 code a compile flag should be added to C++ compiler settings. Furthermore, Eclipse discovery options should be changed to see new header files.

  * Right click on project > Properties > C/C++ Build > Settings > GCC C++ Compiler > Miscellaneous > Other Flags. Add `-std=c++11` to compiler flags.

  ![](http://kaskavalci.com/wp-content/uploads/2013/07/2013-07-01-14_44_28-Properties-for-UCT.png)

  * In the same project properties window under C/C++ Build > Discovery Options > Click on `Automate discovery options of paths and symbols` to enable it > under `Compiler invocation arguments` add `-std=c++11`.

  ![](http://kaskavalci.com/wp-content/uploads/2013/07/2013-07-01-14_43_59-Properties-for-UCT.png)

  * In order to update index file, in the same properties window > C/C++ General > Indexer > If you don't have a project specific configuration click on `Configure Workspace Settings` > `Index source and header files opened in editor.`

  ![](http://kaskavalci.com/wp-content/uploads/2013/07/2013-07-01-14_48_10-Preferences.png)
