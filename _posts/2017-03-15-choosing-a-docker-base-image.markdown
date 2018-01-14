---
layout: single
title: 'Choosing a docker base image'
date: '2017-03-15 10:32:15 +0300'
---

There are several popular base images for docker (only 10+ million pulls):

Image                                                       | Size (Compressed) | License
----------------------------------------------------------- | ----------------- | ---------------------------------------------------------------
[Busybox](https://registry.hub.docker.com/_/busybox/)       | 2 MB              | GNU GPLv2 only
[Alpine](https://registry.hub.docker.com/_/alpine/)         | 2 MB              | ??
[Debian](https://registry.hub.docker.com/u/library/debian/) | 37 MB (7)         | DFSG -> GNU GPL, BSD, Artistic, etc
[Ubuntu](https://registry.hub.docker.com/_/ubuntu/)         | 66 MB (14.04)     | Free software licenses (mainly GPL)
[Centos](https://registry.hub.docker.com/_/centos/)         | 69 MB (6.8)       | Free software (GPL and other licenses)
[Fedora](https://registry.hub.docker.com/_/fedora/)         | 76 MB (latest)    | Various free software licenses, plus proprietary firmware files

Please note that they are downloaded once. What really matters is the stable and up-to-date versions in package repository and community support.

# Image Comparison

## Busybox

> BusyBox combines tiny versions of many common UNIX utilities into a single small executable. It provides replacements for most of the utilities you usually find in GNU fileutils, shellutils, etc. The utilities in BusyBox generally have fewer options than their full-featured GNU cousins; however, the options that are included provide the expected functionality and behave very much like their GNU counterparts. BusyBox provides a fairly complete environment for any small or embedded system.

### Advantages

  * Small footprint
  * Free and independent

### Disadvantages

  * Designed for embedded systems
  * Not very large community

## Alpine

> Alpine Linux is an independent, non-commercial, general purpose Linux distribution designed for power users who appreciate security, simplicity and resource efficiency.

### Advantages

  * Alpine is popular among Docker community.
  * Founder is hired by Docker and Docker announced that they will use Alpine base image in their official images.
  * Uses more memory efficient `musl` library instead of gnu libc
  * Small footprint
  * Free and independent
  * Fewer security vulnerabilities because of minimal image

### Disadvantages

  * Based on Busybox -- has its disadvantages
  * Programs should compile with its `musl` library. Some dependencies may not work.
  * Uses its own package manager (apk) because of `musl` library.
  * `apk` has ~5000 packages.
  * `python` is not pre installed. After installation, image size is `79 MB`.
  * Debugging may be different because of unsupported software

### Overall

  Even though small size and hype around it makes it a compelling alternative, possible `musl` library problems and need for comprehensive debugging in the later stages of development makes it a cold choice. After installing python size increases to `79MB` and not very different from other alternatives. There is no need to choose `musl` library for this tradeoff.

## Debian / Ubuntu

### Advantages

  * Familiar in enterprise setting
  * Quantity and quality of supported software
  * Well maintained package manager with big community
  * Present and future security of its build infrastructure
  * `libc` more compatible than `musl`, less likely to trigger bugs
  * Official Docker recommendation

### Disadvantages

  * May require contact before distribution

## CentOS

### Advantages

  * Based on RHEL, familiar enterprise setup
  * Independent from RHEL, no need for permission
  * Uses stable versions from RHEL repositories

### Disadvantages

  * Fewer release cycles (1-5 years)
  * Slow updates on docker hub (latest update 3m ago. On contrary: Alpine: 13d, Debian: 15d)
  * New features likely to arrive late, because of stability oriented update practice

# Security

## Current base image vulnerabilities

Recent article from [Feceracy](https://www.federacy.com/docker_image_vulnerabilities). Some highlights:

  * 24% of Docker Images have significant vulnerabilities
  * Ubuntu images have significantly more vulnerabilities than Debian images
  * Debian is the most widely used distribution — RHEL, the least, by far
  * Older releases of Debian and Ubuntu have significantly more vulnerabilities

## Using Clair for vulnerability detection

[Clair](https://github.com/coreos/clair) is an open source project for the static analysis of vulnerabilities in appc and docker containers. It can be integrated into CI pipeline.

# Notes

## How to keep docker image small

There is a very informative post from [RedHat's blog](https://developers.redhat.com/blog/2016/03/09/more-about-docker-images-size/). Things to note:

  1. Always use the latest patch of the base image instead of running `apt-get upgrade` to an older image.
  2. Combine repository commands in single `RUN` statement. This will reduce the number of layers.
  3. Always clean up after installing a package.

Example query: `RUN dnf -y update && dnf clean all`

## Does larger base image effect memory consumption of the container?

Short answer: No. Docker only allocates memory for the given process. Image is located in docker's local storage area (`/var/lib/docker/`) in a layered fashion. It means when 2 different images with same base image is created, base image is NOT duplicated, but rather shared. Shared layers are read-only. Containers have a thin R/W layer.

![]({{ site.url }}/wp-content/uploads/2017/docker-image-container.jpeg)
Copyright [Docker](https://docs.docker.com)

Relevant [StackOverflow post](http://stackoverflow.com/questions/24702233/docker-container-and-memory-consumption)

## Further read

- CoreOS, Atomic, Snappy, RancherOS and Photon: [inovex.de](https://www.inovex.de/blog/docker-a-comparison-of-minimalistic-operating-systems/)
- Size comparison: Ubuntu, busybox, centos, opensuse, alpine: [brianchristner.io](https://www.brianchristner.io/docker-image-base-os-size-comparison/)
- Ubuntu's response to docker's migration to Alpine: [ubuntu.com](https://insights.ubuntu.com/2016/02/10/docker-alpine-ubuntu-and-you/)
