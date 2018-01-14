---
id: 32
title: Reading Excel Documents in C++ (xls, xlsx)
date: 2011-10-11T19:31:36+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=32
permalink: /reading-excel-documents-in-c-xls-xlsx/
dsq_thread_id:
  - "5151856869"
categories:
  - C++
tags:
  - c++
  - excel
  - OLEDB
  - xls
  - xlsx
---
Actually this can be done in C# as well. Only thing is, we should use MSVC compiler. I haven't checked but I think G++ has some problems with that. Feel free to search about it.

Here is the original article that I found my solution[here](http://www.codeproject.com/KB/office/excel-ado-c.aspx "Excel-ado-c at codeproject"). It also has sample code that you can read and write to xls, xlsx files. However it is not complete.

Problem arises when you have different types of data in a particular column. By default OLEDB uses an algorithm that checks first 8 rows and majority type becomes the type of that column. If you have text and numbers, you are screwed. You will end up with partial outputs.

Workaround of this problem is to change this algorithm. This is done by modifying connection string. Take a look at the connection string (for xls) from codeproject:

`"Provider='Microsoft.JET.OLEDB.4.0';Data Source=" << filename << ";Extended Properties=\"Excel 8.0;HDR=" << hdr << "\""`

Extended properties field is used to change this algorithm. All you have to do is to change extended properties to following:

`"Provider='Microsoft.JET.OLEDB.4.0';Data Source=" << filename << ";Extended Properties=\"Excel 8.0;MAXSCANROWS=0;ImportMixedTypes=Text;IMEX=1;HDR=" << hdr << "\""`

It changes rows to scan to determine the type to ****, determines type as **Text** and enables Import Mode of mixed variables.

Now you can enjoy you excel spreadsheet in your C++ program.

One more thing, if you don't want to write the number of your spreadsheet but the name of it, change the **Open** variables of **pRec** to following:

`TESTHR(pRec->Open("SELECT * FROM [**Sheet1**$]", connStr, adOpenStatic, adLockOptimistic, adCmdText));`

Yes you should put dollar  sign there.

For more information please visit [KB257819](http://support.microsoft.com/kb/257819).

Enjoy!
