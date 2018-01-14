---
layout: single
title: "Backing up photos from an Android phone on MacOS"
date: "2017-09-09 21:02:06 +0300"
---

My beloved mother's phone was full of photos eventually and she did not enable cloud syncing. 50GB of photos left no space for system functions and backing up thousands of photos with Android File Transfer turns out to be little success. Android cannot list all photos thus even though I copy the folder, not all pictures are included. Very dangerous.

So, how did I solve the issue?

# ADB

This little monster is very effective at communicating with your android phone. First, download brew if you hadn't already.

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install ADB

```
brew cask install android-platform-tools
```

Copy photos to your desired location

```
adb pull sdcard/DCIM/Camera ~
```

That's all!
