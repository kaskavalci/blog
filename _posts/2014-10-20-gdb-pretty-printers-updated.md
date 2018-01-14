---
id: 254
title: 'GDB Pretty Printers &#8211; Updated'
date: 2014-10-20T21:13:37+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=254
permalink: /gdb-pretty-printers-updated/
categories:
  - C++
  - Eclipse
  - 'Tricks &amp; Tips'
  - Uncategorized
  - Windows
---
Ever wondered why gdb doesn't show vectors or other STLs? Wonder no more, that's because GDB is unable to follow all the pointers that vector has internally. In order to see them properly, you should enable pretty printers by the help of Python. In my [previous post]({% post_url 2013-07-02-pretty-printing-for-c-stl-containers %} "Pretty printing for C++ STL containers"). I explained how to enable them. However when I try them again for newer versions, I had problems which I didn't expect. So, here is the updated walk-through of enabling pretty printers.

Current version when this post is written is gdb 7.6. If you fail to operate, just drop in in the comments.

  1. Install Python 2.7.x from [here](https://www.python.org/downloads). Be sure to download 2.7 and 32 bit.
  2. Add environmental variable `PYTHONPATH` with `C:\Python27\Lib;C:\Python27\DLLs;C:\Python27\Lib\lib-tk;C:\Python27;`
  3. Download MinGW w64. You may have regular MinGW but it does not come with python enabled gdb. This one has. It will install both 32 and 64 bit MinGW. If you don't need 64, just forget about it. Rename your current MinGW and use this one instead.
  4. Create a `.gdbinit` file with contents of the following. Remember to change your MinGW and gcc path. Just check for share directory under MinGW and change the gcc-x.x.x version. It will most probably work.

```python
python
import sys
sys.path.insert(0, 'c:\MinGW\share\gcc-4.8.1\python')  #Change this
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
```

In Eclipse, point gdb init file that you've just created. Also, for gdb, choose the one which comes with MinGW-w64. Here is my configuration:

![](/wp-content/uploads/gdb-pretty.jpg)
