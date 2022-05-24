---
layout: single
title: "How to fix faded text in books sent to Kindle by Calibre"
tags:
 - calibre
 - ebooks
---

The book I have in calibre has some sections in faded text. It's impossible to
read. It seems I'm not the only one, as I've seen some posts on the internet.

- [Faded text in one specific
book](https://www.reddit.com/r/kindle/comments/3mnih9/faded_text_in_one_specific_book/)
- [How can I fix this "faded text"](https://www.mobileread.com/forums/showthread.php?t=291780)
- [Kindle Quality Notices from Amazon-Unreadable Text When Viewing eBooks with a Black Background](https://www.authorimprints.com/kindle-quality-notices-amazon-unreadable-text-when-viewing-ebooks-black-background/)

There are two solutions for this problem.

## Just use AZW3

Simplest thing to do. AZW3 is a e-book format by Amazon. Send a specific version
of the book to the device. Steps to do that:

1. Right click on the book you want to send
2. Send to Device -> Send specific format to -> Main memory
3. Choose AZW3
4. Check if the faded text issue still persists

## Disable color conversion

You can convert books with more options with Calibre. There, you can disable
color conversion. Steps:

1. Right click on the book you want to send
2. Convert Books -> Convert individually
3. Look & Feel
4. Styling
5. Select what style information you want completely removed
6. Click Colors

![calibre look and feel screnshot](../assets/2022-05-24-calibre-look-feel.jpg)
