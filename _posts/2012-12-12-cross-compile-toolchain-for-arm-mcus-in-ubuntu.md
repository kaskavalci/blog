---
id: 144
title: Cross-compile toolchain for ARM MCUs in Ubuntu
date: 2012-12-12T21:35:01+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=144
permalink: /cross-compile-toolchain-for-arm-mcus-in-ubuntu/
categories:
  - BeagleBone
  - C
  - C++
  - Linux
---
Today I'll tell you how to get cross-compile toolchain for Ubuntu. There are other MCU toolchains as well but I will focus on ARM version. Toolchains are required because compilers and toolchains in our PCs are designed to produce x86 or 64bit processor machine code. However, ARM is not compatible with that. That is why we need compilers that can produce ARM machine code. Toolchains are used to do that.

First of all, if you have 64 bit Ubuntu, you should install 32 bit libraries.

```shell
sudo apt-get install ia32-libs
```

Download the toolchain [Sourcery CodeBench Lite Edition](http://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/request?id=478dff82-62bc-44b2-afe2-4684d83b19b9&downloadlite=scblite2012&fmpath=/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/form). I know it's annoying but you should register to download. Then follow its guide to install it. If everything succeeds, you will have your toolchain installed and you can compile programs like **arm-linux-gnueabi-gcc** or **arm-linux-gnueabi-g++**. Actually all toolchain, including binutils are available. This is enough if you want to compile simple programs that does not depend on any library. Things get messy if you use huge libraries like OpenCV. Next chapter will focus on that. Happy embedding!
