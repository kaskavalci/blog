---
id: 169
title: Pretty printing for C++ STL containers
date: 2013-07-02T12:35:23+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=169
permalink: /pretty-printing-for-c-stl-containers/
dsq_thread_id:
  - "5217502729"
categories:
  - C++
  - Eclipse
  - Python
  - 'Tricks &amp; Tips'
  - Windows
tags:
  - c++ stl
  - mingw
  - pretty printers
  - python
---
Ever wondered why you cannot see inside vector while debugging? It is because gdb does not support STL types and thus only thing you will see is the pointers in vector container. In order to get full support from gdb, you need to do some work.

Requirements for this task are:

  1. `MinGW`. I'm sure you can do it by Cygwin as well but I don't use it so I don't know.
  2. `Python 2.7`. You can download it from [here](https://www.python.org/downloads). **Remember**: you should download Python 2.7.x. **Important: Install 32 bit python if you have basic MinGW.**
  3. I will tell you how to do it in Eclipse but if you are using gdb only, I'm sure you know how to trigger gdb with `.gdbinit` file.

Now, to install Python 2.7 properly, add the following line to your PATH. Of course, if you installed Python to another location, update accordingly. If Eclipse instance is running as you change the PATH, you should restart Eclipse!

`C:\Python27\Lib;C:\Python27\DLLs;C:\Python27\Lib\lib-tk;C:\Python27;`

Open your MinGW shell and type

`mingw-get install gdb-python`

This will install python enabled gdb binaries. If you receive errors like `probable package conflict; existing file not overwritten` ignore them and continue. Now try to launch `gdb-python27.exe`.

If you receive `The application was unable to start correctly (0xc000007b)` error, your path didn't really work. It needs python libraries to run. Or you installed 64 bit python and have 32 bit gdb. Easiest way is to have 32 bit python!

If you receive `libintl-8.dll not found` error, then your problem is with package conflict.


  1. Remove gdb by typing `mingw-get remove gdb`
  2. `mingw-get install --reinstall --recursive gdb-python`
  3. Now install gdb back, `mingw-get install gdb`

Hopefully, your problem should have been solved.

Then create a new document called `.gdbinit` and add this to your file. Don't forget to change your directory if your MinGW is installed to another location. Furthermore, double check the gcc version. Mine is located at `gcc-4.7.2`. Yours could be a newer or older version!

```python
python
import sys
sys.path.insert(0, 'c:\MinGW\share\gcc-4.8.1\python')  #Change this
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
```

After that, open Eclipse. Click to debugging symbol and select **debug configuration** and do the following changes:

![]({{ site.url }}/wp-content/uploads/2013/07/2013-07-02-12_34_57-.png "GDB python config")

Change your GDB debugger to `gdb-python27.exe` which is located in **MinGW/bin** directory. And choose command file to your **gdbinit** file that you created earlier. I experienced some problems with stopping at **main**. If this configuration doesn't work for your, uncheck **Stop on startup at main**.

Enjoy debugging!
