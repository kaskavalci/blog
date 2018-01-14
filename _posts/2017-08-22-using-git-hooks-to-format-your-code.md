---
layout: single
title: "Using git hooks to format code before commit"
date: "2017-08-22 15:52:08 +0300"
---

This tutorial will help you format your code before you commit them. You can either use your company or project's custom `.clang-format` file or use a predefined (ie: Google, Mozilla, LLVM, etc.) style.


## Install clang-format
Sorry, I don't use Windows currently so you are on your own. Post a comment on how to do it!

### Ubuntu 14.04
Search for latest clang-format version

```shell
sudo apt-cache search clang-format
clang-format-3.3 - Tool to format C/C++/Obj-C code
clang-format-3.4 - Tool to format C/C++/Obj-C code
clang-format-3.5 - Tool to format C/C++/Obj-C code
clang-format-3.9 - Tool to format C/C++/Obj-C code
clang-format-3.6 - Tool to format C/C++/Obj-C code
clang-format-3.8 - Tool to format C/C++/Obj-C code
```

Install

```shell
sudo apt-get install clang-format-3.9
```

Ubuntu will install binary with version suffix: `clang-format-3.9`. You need to tell git where to find clang-format

```shell
git config --global clangFormat.binary clang-format-3.9
```

### MacOS
Install clang-format (with [homebrew]((https://brew.sh/)))

```shell
brew install clang-format
```

## Update your git hooks

Go to your repository

```
cd /path/to/your/repo
cd .git/hooks
touch pre-commit
chmod +x pre-commit
```

Put the following script into `pre-commit`.

* If you will use a predefined style, check the comment in the code.
* If you already have a `.clang-format` file, place it to the root of the repository.

```shell
#!/bin/bash

export PATH=`git rev-parse --git-dir`/../tools/:$PATH

git clang-format --extensions cpp,hpp --style file -v
# Possible predefined styles:
# LLVM
# Google
# Chromium
# Mozilla
# WebKit

# Change the code with:
# git clang-format --extensions cpp,hpp -style=llvm -v


rc=$?
if [[ $rc == 33 ]]
then
 echo "Nothing needs to be reformatted!"
 exit 0
fi

echo -e "Would you like to continue to commit (y/n): \c"

# Make sure under any mode, we can read user input.
exec < /dev/tty
read cont

if [ "$cont" == "y" ]
then
 exit 0
fi

exit 1
```
## Commit your code

When you try to commit your code, given script will run and ask you if you want to continue to commit with changes files. You can check the difference and if you think it is OK, continue commiting. Your code will be _fabulous_.
