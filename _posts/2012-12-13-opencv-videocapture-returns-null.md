---
id: 151
title: OpenCV VideoCapture returns null
date: 2012-12-13T20:13:38+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=151
permalink: /opencv-videocapture-returns-null/
dsq_thread_id:
  - "5167470322"
categories:
  - Linux
tags:
  - linux
  - opencv
  - video
---
It is possible that your camera is not mounted to system. You can check /dev/video* or `dmesg | tail` and check if your USB device is successfully recognized and mounted.

Another possibility is that your camera is not supported by OpenCV yet. Please check <a href="http://opencv.willowgarage.com/wiki/Welcome/OS">list of cameras</a> supportd by OpenCV.

If your camera is mounted and listed as compatible with OpenCV then your V4L drivers may be corrupted. If you run under Desktop, install Cheese and check if it can connect to your webcam. If so, I'm sorry I don't know that answer either. If you run OpenCV in embedded systems, fresh kernel may help you with that. Download your favorite OS from web and make a fresh installation.
