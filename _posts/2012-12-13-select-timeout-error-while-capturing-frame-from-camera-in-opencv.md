---
id: 153
title: Select timeout error while capturing frame from camera in OpenCV
date: 2012-12-13T20:18:46+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=153
permalink: /select-timeout-error-while-capturing-frame-from-camera-in-opencv/
dsq_thread_id:
  - "5148639393"
categories:
  - BeagleBone
  - Linux
tags:
  - beaglebone
  - opencv
---
While working on video processing project on BeagleBone, I couldn't get frames from camera. I had **select timeout** error and frame that I captured was just black. The reason might be either your v4l drivers are faulty, so you have to update it somehow. I re-installed the operating system Angstrom. Then, I set resolution to 1024x768. Finally I am able to get frames. Beware that resolution is important since BeagleBone have limited memory and CPU. I was able to get 2048x1536 frames as well but it takes a long time to process each frame. Stick with low resolution if you can, or use a board that have more processing power.