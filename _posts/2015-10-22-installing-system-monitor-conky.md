---
id: 405
title: Installing system monitor conky on Ubuntu
date: 2015-10-22T12:30:33+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=405
permalink: /installing-system-monitor-conky-on-ubuntu/
dsq_thread_id:
  - "5149282792"
image: /wp-content/uploads/2015/10/conky_colors_by_helmuthdu-d41qrmk.png
categories:
  - HowTo
  - Linux
tags:
  - conky
  - linux
  - ubuntu
---
# What is a System Monitor?

System monitors show various system indicators like HDD, Network, and CPU usage. If you want to learn more about your computer, it's a must have tool.

I guide you to install `conky`, which is extremely powerful and customizable system monitor tool.

# Installing Conky

To install bare `conky` on Debian/Ubuntu/Linux Mint;

```
sudo apt-get install conky-all
```

In the same fashion, you may want to install the following packages which will extend conky's abilities.

```
sudo apt-get install **conky curl lm-sensors hddtemp
```

Congratulations, you have just installed conky. You can start it by typing `conky` on your favorite console. Check out your desktop and you will see something like this.

!(Conky bare)[http://kaskavalci.com/wp-content/uploads/2015/10/Screenshot-from-2015-10-22-112318.png]

Pretty ugly, isn't it? Let's make it prettier. Kill the current conky with

```
  killall -SIGUSR1 conky
```

# Installing Conky Themes

There are tons of conky themes on Internet. You can check them out on [devianart](http://www.deviantart.com/browse/all/?section=&global=1&q=conky). I will install [Conky-Colors](http://helmuthdu.deviantart.com/art/CONKY-COLORS-244793180) by `helmuthdu`. His theme requires `python-statgrab` package but it is not available on Ubuntu repositories. Therefore, we need to manually install it.

  * Install its dependancy [libstatgrab](https://launchpad.net/ubuntu/trusty/amd64/libstatgrab6/0.17-1ubuntu1) or download the package [directly from here](http://launchpadlibrarian.net/145662970/libstatgrab6_0.17-1ubuntu1_amd64.deb).
  * Install the packages:
```
sudo apt-get install aptitude python-keyring python-statgrab ttf-ubuntu-font-family hddtemp curl lm-sensors conky-all
```

  * Make hddtemp executable.

```
sudo chmod u+s /usr/sbin/hddtemp
```

  * Now answer all yes.
```
sudo sensors-detect
```

  * Restart your session.
  * Download the theme from [devianart](http://helmuthdu.deviantart.com/art/CONKY-COLORS-244793180). Unzip the package.
  * Enter the directory.
  * Compile the package

```
make
```

  * Install the package

```
sudo make install
```

Now you have installed the conky-colors package. You can type conky-colors in terminal and choose from endless options. Here is a jump-start for you. If you have more than 2 CPU, increase it to your number. If you don't know how many CPUs you have, this will tell you: `cat /proc/cpuinfo | grep cores`

```
conky-colors --cpu=2 --calendar --photord --clementine=cd --hd=default --network --theme=wise
```

It will output how to run conky with the selected theme.

```
conky -c **~**/.conkycolors/conkyrc
```

Now, you will see something like this.

![conky-all]({{ site.url }}/wp-content/uploads/2015/10/conky-all.png)

If you recieve errors like this:

`convert: command not found`

`Conky: Unable to load image '/tmp/conkycolors/conkyCover.png'`

`/home/halil/.conkycolors/bin/conkyCover: identify: not found`

Install `imagemagick`.
```
sudo apt-get install imagemagick
```

# Run Conky on Startup

If you are using Ubuntu Unity, which is the one that you download by default then open unity start menu and run Startup Applications.

![Startup Applications]({{ site.url }}/wp-content/uploads/2015/10/Screenshot-from-2015-10-22-112640.png)

Add a new entry and give command that the theme has produced. Change the username.

```
conky -c /home/**USERNAME**/.conkycolors/conkyrc
```

![conky-start]({{ site.url }}/wp-content/uploads/2015/10/conky-start.png)

Now, conky will start on boot, automatically.
