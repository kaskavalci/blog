---
id: 263
title: 'liburl.connect cannot connect to given address &#8211; error no address associated to host name [python]'
date: 2014-12-11T20:04:40+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=263
permalink: /liburl-connect-cannot-connect-to-given-address-error-no-address-associated-to-host-name-python/
categories:
  - Python
  - 'Tricks &amp; Tips'
tags:
  - python
---
You are trying to connect to a web server / your server and get a URL but python is being grumpy. Host is available to your machine but python cannot view it!

You probably have two or more network interfaces. The reason that python cannot connect to given address, even though it's reachable from your machine is that liburl does not have any option to choose which adapter to use. Unfortunately,I couldn't find any way to use liburl or liburl2 with an option to choose network interface.

Fear not. There is a way to connect to your favorite host. Sockets! They are not as fancy and easy as liburl, but they work for good. Here is the code snippet for the impatient.

```python
httpRequest = """
GET /index.html HTTP/1.1
Accept-Encoding: identity
Host: #Your IP Address
Connection: close
User-Agent: Python
"""
try:
  #Create the socket
  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  #Set timeout to some seconds, 2 in this case. Don't wait forever if server doesn't respond.
  s.settimeout(2)
  #Connect to your host
  s.connect(("google.com",80))
  #Send HTTP request
  s.send(httpRequest)
  #Get the response
  data = (s.recv(4096))
  #Enjoy your response!
  print data
  #Close the socket when done
  s.close()
except Exception, e:
  print "Error communicating with host.", sys.exc_info()[0]
  sys.exit(2)
```

Basically, you need to generate an HTTP request by yourself. It's fairly easy and all strings. This is a basic GET request. If you already have a liburl request and working for your machine at least, you can capture the packets via Wireshark and copy the HTTP request from it, change it in code (That's what I did actually).

Hope that helps!
