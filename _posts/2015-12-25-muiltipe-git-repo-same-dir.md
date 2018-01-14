---
id: 424
title: 'HowTo: Using multiple git repositories under the same directory'
date: 2015-12-25T11:27:56+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=424
permalink: /howto-using-multiple-different-git-repositories-under-the-same-directory/
dsq_thread_id:
  - "5148639444"
image: /wp-content/uploads/2015/12/687474703a2f2f692e696d6775722e636f6d2f6337476d414a662e706e67.png
categories:
  - HowTo
  - 'Tricks &amp; Tips'
tags:
  - git
---
If you are to work under two different repositories with different commit history, you may either,

  1. Copy the changes between multiple git repo folders, back and forth.
  2. Use the same directory separately for different repositories.

First one easy enough but it gets frustrating as the project evolves. Today I'll tell you how to use any number of repositories under the same directory.

.git directory under the project root is the git repository information. It consists everything regarding to the repository. Good news is, its name can be changed.

  1. Clone your repositories to different directories first.
  2. Rename your .git to something you like, .gitRepo1, .gitRepo2 maybe? I'm bad at naming things. Figure this out.
  3. Copy all your .git dirs under the same directory where you like to work.
  4. Now comes the tricky part. Whenever you want to use one, go like this: "git --git-dir=.gitRepo1"

Well, sure that works but it's a hassle to write `--git-dir=[reponame]` at all times. Fear not, we can create an alias for that.

## Setting Alias for easier use

### Windows

I'm using [ConEmu](http://conemu.github.io/en/index.html) these days. It's a great command line wrapper for Windows. I recommend you to use it as well. If you're on Linux,

  1. Download ConEmu
  2. Go to Settings (`Win + Alt + P`)
  3. Go to `Startup\Environment`
  4. Add your alias in this form:

`alias mygit=git --git-dir=.gitRepo1 $*`

Trailing `$*` ensures that your arguments after `mygit` will be passed to git.

### Linux

Thanks Murat for his comment how to use alias in Linux. Add this alias command to your profile and you can just type `mygit` to use your `gitRepo1`.

`echo "alias mygit='git –git-dir=.gitRepo1'" >> ~/.profile`

### Mac

It should be same as Linux since it's a UNIX OS.

To use it, just type your alias and your usual git commands, like this:

`mygit status -s`

That's it. Enjoy your multiple repositories.
