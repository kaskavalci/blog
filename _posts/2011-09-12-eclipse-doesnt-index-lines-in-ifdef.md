---
id: 23
title: 'Eclipse doesn&#8217;t index lines in ifdef'
date: 2011-09-12T14:30:08+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=23
permalink: /eclipse-doesnt-index-lines-in-ifdef/
dsq_thread_id:
  - "5206221630"
categories:
  - C
  - Eclipse
tags:
  - builder
  - eclipse
  - index
---
Yes Eclipse has an internal parser and that parser builds and indexes your code so that you can work on it easily. If a definition is not in build, eclipse automatically skips that part from indexing and reduces the amount of built code accordingly. However for big projects sometimes we don't use eclipse's internal builder but some makefiles or ant build files. In that case, if you want your code to be open, you should add those definitions to eclipse's internal parser. In order to do that:

  1. Right click to project and select **Properties**.
  2. Under **C/C++ General** tab go to **Paths and Symbols**.
  3. Add your definition in **Symbols** tab.
  4. Apply your changes. Eclipse will rebuild the index.

Enjoy coding!