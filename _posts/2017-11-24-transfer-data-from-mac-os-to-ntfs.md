---
layout: single
title: "Transfer data from MacOS NTFS"
date: "2017-11-24 02:21:06 +0300"
---

Mac does not support write operation to NTFS (thanks Apple). You need a third party driver for this. There is paid and open source alternatives. You can compare them [here](http://macdrug.com/paragon-ntfs-14-vs-tuxera-2015-vs-ntfs-3g/). I chose ntfs-3g.

# Installing ntfs-3g

Always consult the product page: [https://github.com/osxfuse/osxfuse](https://github.com/osxfuse/osxfuse/wiki/NTFS-3G). Basically:

1. Install [brew.sh](https://brew.sh/)
2. Install ntfs-3g. `brew install ntfs-3g`

# Mount NTFS Drives with write permission

Now you can mount your drivers. You need to know the device name. 

1. Open Disk Utility from Spotlight Search.
2. Click on your device
3. Note `Device` field from the table. It should be something like `disk2s1`.
4. Unmount the device.
5. Go to terminal
6. Create any folder. `sudo mkdir /Volumes/NTFS`
7. Mount it. `sudo ntfs-3g /dev/disk2s1 /Volumes/NTFS`
8. Test if you can write it. `touch /Volumes/NTFS/test`

# Change energy options

Your mac will go to sleep after a while and you do not want that. Copying large files can take hours and distrupted copying will result in partial and corrupt files.

1. Go to System Preferences
2. Energy Saver
3. Enable `Prevent computer from sleeping automatically when the display is off`.

# Determine your backup

This is crucial. Backing up is not as easy as drag and drop. You may end up with partial and corrupt files. Nobody wants that. First rule of thumb:

> When you have many files, it is better to create tarballs to reduce number of files and create md5 sums.

This advice however duplicates file size. If you have thight space on your Mac, then consider dividing the data.

1. Create a tarball `tar cf backup.tar ~/backup`
2. Create md5sum `md5 ~/backup.tar > ~/backup.md5sum`

# Copy your files

You can either use drag and drop or comman line.

1. `cp backup.tar /Volumes/NTFS/`

# Verify integrity

You should verify data integrity of your backup on the HDD.

1. Create md5sum of the copied data. `md5 /Volumes/NTFS/backup.tar > /Volumes/NTFS/backup.md5sum`
2. Compare it with existing md5. `diff ~/backup.md5sum /Volumes/NTFS/backup.md5sum`

# Conclusion

This process takes hours. Make sure to give it enough time.
