---
id: 244
title: Configuring multiple git difftool and mergetool based on file extension
date: 2014-08-01T18:37:10+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=244
permalink: /configuring-multiple-git-difftool-and-mergetool-based-on-file-extension/
dsq_thread_id:
  - "5150081613"
categories:
  - 'Tricks &amp; Tips'
tags:
  - difftool
  - git
  - mergetool
  - shell
---
If you have custom files in your repository and they have their own diff/merge tool, you won't like the output of textual difftools of git. In order to handle multiple diff/merge tools and trigger them based on the file itself, it gets bit tricky.

You need to have a middleman difftool and mergetool. This script will call appropriate tool based on file extension. Here is the complete changes you need to do.

## `.gitconfig`
```
[difftool]
    prompt = false
[mergetool]
    prompt = false
[difftool "selectiveDiff"]
    cmd = difftool.sh $LOCAL $REMOTE $BASE $MERGED
    keepBackup = false
[mergetool "selectiveMerge"]
    cmd = mergetool.sh $LOCAL $REMOTE $BASE $MERGED
    keepBackup = false
```

Please note that scripts should be in your PATH. Create a directory for them and add it to your PATH.

## `common.sh`

This file has the common functions and variables for mergetool and difftool. Update the paths and file extension accordingly.

```shell
#Functions in this file are called from difftool.sh and mergetool.sh to determine file extension.
#They should return true (0) if given two files both have desired extension and return false (1) otherwise.

RHAPSODY_PATH="C:/Program Files (x86)/IBM/Rational/Rhapsody/8.0.5/DiffMerge.exe"
KDIFF3_PATH="C:/Program Files/KDiff3/kdiff3.exe"
FILE_EXTENSION="sbs"

is_myfile() {
		#extract filename
		filename1=$(basename $1)
		#get the extension
		ext1="${filename1##*.}"
		#do the same for the other file, if any
		if [ "$#" -eq 2 ]; then
			filename2=$(basename $2)
			ext2="${filename2##*.}"
		else
			#if there is only 1 argument (negletting the case of any other
			#argument combination), directly assign it to sbs.
			ext2=$FILE_EXTENSION;
		fi
		#disable case sensitive matching
		shopt -s nocasematch
		if [[ $ext1 = $FILE_EXTENSION && $ext2 = $FILE_EXTENSION ]] ; then
			shopt -u nocasematch
			return 0
		else
			shopt -u nocasematch
			return 1
		fi
}
```

## `mergetool.sh`

```shell
source common.sh

if is_myfile $1 $2 ; then
	#DiffMerge.exe -base BASE FILE1 FILE2 -out OUTPUT -xmerge
	"$RHAPSODY_PATH" -base $3 $1 $2 -out $4 -xmerge
else
	#kdiff3 BASE FILE1 FILE2 -o OUTPUT
	"$KDIFF3_PATH" $3 $1 $2 -o $4
fi
```

## `difftool.sh`

```shell
source common.sh

echo $@

if is_myfile $1 $2 ; then
	"$RHAPSODY_PATH" -base $3 $1 $2 -xcompare
else
	"$KDIFF3_PATH" $1 $2
fi
```
