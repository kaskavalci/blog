---
id: 281
title: 'git: error: insufficient permission for adding an object to repository database ./objects'
date: 2015-02-20T17:15:42+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=281
permalink: /git-error-insufficient-permission-for-adding-an-object-to-repository-database-objects/
dsq_thread_id:
  - "5155115899"
categories:
  - 'Tricks &amp; Tips'
  - Windows
tags:
  - git
---
While this error may be caused by your permissions on the remote git repository, it may have other causes as well. Here what you should try:

### Fix Permissions

On Linux, execute this:

```shell
cd /path/to/repo.git
chgrp -R groupname .
chmod -R g+rwX .
find . -type d -exec chmod g+s '{}' +
```

On windows, make sure you can access the remote folder and it is shared. Right click to folder > Properties > Sharing > Advanced > Permissions and make sure the user is there. If you don't mind security and work in local network, you can have Everybody for Full Control.

### Fix Git Repo

Your git repository may not be shared at all. You can do it by executing:

```shell
git config core.sharedRepository true
```

Another problem would be that your git repo is corrupted. To fix this, execute the following commands on both your local and remote repositories.

```shell
git fsck
git prune
git repack
git fsck
```

### None of them worked?

None worked for my case. I copied the remote, bare repository into another folder, shared this folder and added it in my remote repositories in my local. When I pushed to upstream, voila! It worked! Then I renamed it to original name.

I have no idea what went wrong there and how copying helped, but it may help your cause as well.
