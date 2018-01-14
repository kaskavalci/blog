---
id: 385
title: 'Note to self: Git aliases for faster use'
date: 2015-09-26T22:11:34+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=385
permalink: /note-to-self-git-aliases-for-faster-use/
dsq_thread_id:
  - "5160975564"
categories:
  - 'Tricks & Tips'
tags:
  - git
---
# What is this?

This is a list of git aliases (shortcuts) to use git more efficiently. I get this valuable git config from my lovely manager Mike Veldink from Siemens AG, a special thanks to him. You can just paste this into git shell.


```sh
##
##You better change these:
##
git config --global user.name "Username"
git config --global user.email "mail@domain.com"
##
##Paste as it is
##
git config --global alias.s "status -suno"
git config --global alias.ss "status -s"
git config --global alias.l "log --oneline --decorate"
git config --global alias.d "diff"
git config --global alias.ds "diff --stat"
git config --global alias.di "diff --stat --cached"
git config --global alias.dc "diff --name-status -M --ignore-submodules"
git config --global alias.dt "difftool"
git config --global alias.b "branch"
git config --global alias.ls "ls-files"
git config --global alias.c "commit -m"
git config --global alias.co "checkout"
git config --global alias.a "add -u"
git config --global alias.f "fetch --all"
git config --global alias.p "push"
git config --global alias.m "merge"
git config --global alias.mt "mergetool"
git config --global merge.conflictstyle diff3
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
##
## Choose your diff and merge tools
##
git config --global diff.tool kdiff3
git config --global difftool.kdiff3.path "/c/Program Files/KDiff3/kdiff3.exe"
git config --global difftool.kdiff3.keepBackup false
git config --global difftool.kdiff3.trustExitCode false

git config --global merge.tool kdiff3
git config --global mergetool.kdiff3.path "/c/Program Files/KDiff3/kdiff3.exe"
git config --global mergetool.kdiff3.keepBackup false
git config --global mergetool.kdiff3.trustExitCode false
```

# OK, what now?

Well, if you've never used git, this won't make sense to you. It's time to hit the gym and work out git [git-scm.com/doc](http://www.git-scm.com/doc). Otherwise, experiment with the aliases you see there. For example,

changed files -> `git s`

commit history -> `git l`

commit with message -> `git c 'Hello World!'`

diff tool -> `git dt`

and many more.
