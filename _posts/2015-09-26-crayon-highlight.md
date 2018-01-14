---
id: 382
title: 'Crayon Syntax Highlighter&#8217;s Performance Issues &#8211; What is the alternative?'
date: 2015-09-26T20:43:21+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=382
permalink: /crayon-syntax-highlighters-performance-issues-what-is-the-alternative/
dsq_thread_id:
  - "5161683153"
categories:
  - 'Tricks &amp; Tips'
tags:
  - wordpress
---
# What is a Syntax Highlighter

Syntax highlighter helps you embed some code into your blog post and highlight it so that user will see it as if he/she is reading your code from an editor.

Here is a highlighted code:

```sh
@echo off
SET TEMPFILE="%TEMP%\%RANDOM%.TXT"
echo SELECT VDISK FILE="C:\full\path\to\license.vhd">%TEMPFILE%
echo ATTACH VDISK>>%TEMPFILE%
DISKPART /s %TEMPFILE%
del %TEMPFILE%
```

Here is raw:

@echo off

SET TEMPFILE="%TEMP%\%RANDOM%.TXT"

echo SELECT VDISK FILE="C:\full\path\to\license.vhd">%TEMPFILE%

echo ATTACH VDISK>>%TEMPFILE%

DISKPART /s %TEMPFILE%

del %TEMPFILE%

See the difference?

<!--more-->

# Crayon Syntax Highlighter

Crayon is a cool syntax highlighter for WordPress blogs, powered by user side JavaScripts [link](https://wordpress.org/plugins/crayon-syntax-highlighter/). It supports _'more than you need'_ languages and it is quite easy to use.

So, what's its problem? _The Performance._

When I tested my site with Google's [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/). I was shocked. It slows down my server to respond as much as 500 milliseconds. Plus, highlighting is done at user's browser, interfering with user's experience with the site. Not good.

# What is the alternative?

Our most favorite service supports us here too, Github's Gist. Gist is basically for sharing code snippets with people, with highlighting. Good thing about gist is that code is formatted on server layer, which means it comes formatted to user. Github decides the language by the extension of the file and highlights it appropriately.

And yes, you can embed it to your wordpress blogs. You can do it by using HTML frames or you can install the plugin [oEmbed Gist](https://wordpress.org/plugins/oembed-gist). It allows you to embed your gist snippet by just pasting gist URL. The snippet you saw above was from Github Gist. Tests returned fairly fast loading times, almost no contribution to overall load.

It's time for your to abandon Crayon or just choose Gist if you haven't use Syntax Highlighting before.

Thanks GitHub!
