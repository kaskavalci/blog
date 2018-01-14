---
id: 66
title: 'Eclipse Browser widget doesn&#8217;t set URL'
date: 2011-12-22T12:17:04+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://halilcan.x10.bz/?p=66
permalink: /eclipse-browser-widget-doesnt-set-url/
categories:
  - Eclipse
  - Java
---
You can see a sample code of this problem over [here](http://www.java2s.com/Code/Java/SWT-JFace-Eclipse/SWTBrowser.htm "Eclipse browser plugin"). Here is the code I used:

```java
Runnable runner = new Runnable() {
  @Override
  public void run() {
    File index = new File(getMyURL());
      if (index.exists()) {
        browser.setUrl(getMyURL());
      }
    browser.refresh();
  }
}
Display.getDefault().syncExec(runner)
```

Long story short, I just want to refresh the page with new URL. However even though getMyURL() gives correct string, browser gets never updated. Only after second try, it gets updated (sometimes). Apparently the problem was **refreshing** the browser. setUrl works just fine, no need to refresh it afterwards. So if you remove the refresh line, it works like charm.
