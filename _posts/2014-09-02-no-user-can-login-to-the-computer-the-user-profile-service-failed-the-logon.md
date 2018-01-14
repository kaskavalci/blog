---
id: 250
title: 'No user can login to the computer &#8211; The User Profile Service failed the logon'
date: 2014-09-02T21:57:58+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=250
permalink: /no-user-can-login-to-the-computer-the-user-profile-service-failed-the-logon/
categories:
  - 'Tricks &amp; Tips'
  - Windows
---
You probably read Microsoft's [The User Profile Service failed the logon](http://support.microsoft.com/kb/947215 "You receive a 'The User Profile Service failed the logon' error message") knowledge base entry. It helps for users who has corrupt user profiles. However, none of your network users cannot log into that particular PC, you need to more than that.

Answer is simple, go to `C:\Users\Default` folder and search for `*.sqm` files. Beware! They will not show up on Windows Explorer, for some reason. I managed to do it with Total Commander and moved all `.sqm` files found in Default. Worked like a charm. Hope it will help you as well.
