---
id: 311
title: 'HowTo: Attach VHD files upon startup &#8211; Windows 7'
date: 2015-04-12T18:50:21+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=311
permalink: /howto-attach-vhd-files-upon-startup-windows-7/
categories:
  - 'Tricks &amp; Tips'
  - Windows
---
Unfortunately there is no build-in easy way to do that. Fear not, with some scripting we can handle this.

  * Create a batch file and modify the path to VHD.

```shell
@echo off
SET TEMPFILE="%TEMP%\%RANDOM%.TXT"
echo SELECT VDISK FILE="C:\full\path\to\license.vhd">%TEMPFILE%
echo ATTACH VDISK>>%TEMPFILE%
DISKPART /s %TEMPFILE%
del %TEMPFILE%
```

  * Save the script to your path of preference.
  * Open Task Scheduler

  ![]({{ site.url }}/wp-content/uploads/2015/04/2015-04-10-16_53_38-Start-menu.png)

  * Open Task Scheduler.
  * Click on **Create Task** on the right tab.
  * Give a name to the task. Click on **Change User or Group** and choose **Administrators** for the group.

  ![]({{ site.url }}uploads/2015/04/2015-04-10-16_57_21-Create-Task1.png)

  * Click on **Triggers**. Choose **At Startup**

  ![]({{ site.url }}uploads/2015/04/2015-04-10-16_58_07-.png)

  * Click on Actions. Create **New** Action**.** Point to batch file you created earlier.

  ![]({{ site.url }}uploads/2015/04/2015-04-10-16_58_41-.png)

  * Save the task. When you restart your computer, VHD will automatically mounted.
