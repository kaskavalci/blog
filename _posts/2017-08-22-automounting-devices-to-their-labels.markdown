---
layout: single
title: "Automounting devices to their labels"
date: "2017-08-22 20:39:42 +0300"
---
I had this problem with my raspberry pi: I have several hard drives and watch some videos with Kodi. However, whenever Pi is restarted or I have to plug off some USB drivers, their mount point changes! Here is the structure:

```
tree -L 1 /media
.
├── usb -> usb0
├── usb0
├── usb1
├── usb2
├── usb3
├── usb4
├── usb5
├── usb6
└── usb7
```

`/media/usb` always symlinks to first mounted USB, which is OK. However, rest of them is scattered from 0 to 7. No way to know which is where. Only if I can mount them by their **DISK LABEL**.

# Auto mounting with disk label
Raspbian comes with pretty neat tool called usbmount and you can modify mount and unmount procedure! I got this code from [Oliver's blog](https://esite.ch/2014/04/mounting-external-usb-drives-automatically-to-its-label/) but didn't quite worked right for me and had to modify a bit. Modifications:

* Some of my HDDs have spaces and nobody likes spaces in shell. I call `tr` to leave only alphanumeric characters
* Original script creates symlink in `/var/run/usbmount/` but raspberry uses `/media` folder. Thus, removal of the symlinks upon umount does not work.

Create the following file: /etc/usbmount/mount.d/01_create_label_symlink

```shell
sudo touch /etc/usbmount/mount.d/01_create_label_symlink
sudo chmod +x /etc/usbmount/mount.d/01_create_label_symlink
```

Now paste the following code into the file you created:

```shell
#!/bin/sh
# This script creates the volume label symlink in /var/run/usbmount.
# Copyright (C) 2014 Oliver Sauder
#
# This file is free software; the copyright holder gives unlimited
# permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.
#
set -e

# Exit if device or mountpoint is empty.
test -z "$UM_DEVICE" && test -z "$UM_MOUNTPOINT" && exit 0

# get volume label name
label=`blkid -s LABEL -o value $UM_DEVICE | tr -cd '[[:alnum:]]._-'`

# If the symlink does not yet exist, create it.
test -z $label || test -e "/media/$label" || ln -sf "$UM_MOUNTPOINT" "/media/$label"

exit 0
```

# Remove symlink when drive plugged out

In this case we do not need to add another script, but just modify existing removal procedure.

* Open `/etc/usbmount/umount.d/00_remove_model_symlink`
* Remove `break` statement at L19
* Save file

In the end, it should look like this:

```shell
#!/bin/sh
# This script removes the model name symlink in /var/run/usbmount.
# Copyright (C) 2005 Martin Dickopp
#
# This file is free software; the copyright holder gives unlimited
# permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.
#
set -e

ls /var/run/usbmount | while read name; do
    if test "`readlink \"/var/run/usbmount/$name\" || :`" = "$UM_MOUNTPOINT"; then
        rm -f "/var/run/usbmount/$name"
    fi
done

exit 0
```

That's it! When you plug a USB drive, you should see your drive with its label under `/media`:

```shell
tree -L 1 /media/
.
├── Depo-Seagate -> /media/usb0
├── usb -> usb0
├── usb0
├── usb1
├── usb2
├── usb3
├── usb4
├── usb5
├── usb6
└── usb7
```
