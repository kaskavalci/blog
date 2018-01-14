---
layout: single
title: Analysis of available Storage Drivers
date: '2017-04-06 11:37:13 +0300'
---

Storage driver is implementation of a union file system in docker. Currently, 7 storage drivers are supported by Docker, all have their advantage and disadvantages. Union file system enables Docker to save storage space by caching container layers in images and let all containers which run the same image to use the same layer. For more information, please read [Understand images, containers, and storage drivers](https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/) by Docker.

It is possible to change storage driver of Docker, but they are not compatible with each other. All data written on disk will not be recovered by the other storage driver. However, switching back to original driver will read its contents.

Storage driver is not a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/). Storage driver manages what is written *inside* the container.

# Choosing a storage driver

All storage drivers comes with a cost. Copy-on-write policy creates an overhead and additional layers. Thus, volume drivers should be used when applications have heavy write workloads.

[Current Open Bugs](https://github.com/docker/docker/issues?q=is%3Aopen+is%3Aissue+label%3Akind%2Fbug+label%3Aarea%2Fstorage)

Brief list of docker storage drivers:

## [aufs](https://docs.docker.com/engine/userguide/storagedriver/aufs-driver/)

[Current Open Bugs](https://github.com/docker/docker/issues?q=is%3Aopen+is%3Aissue+label%3Aarea%2Fstorage%2Faufs+label%3Akind%2Fbug)

Good:

- First storage driver
- Tested for a long time
- Stable
- Default FS for Debian and Ubuntu hosts

Bad:

- **Not** in mainstream kernel (refused for being too complicated)
- High memory consumption
- High write activity
- No quota support

## [devicemapper](https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/)

[Current Open Bugs](https://github.com/docker/docker/issues?q=is%3Aopen+is%3Aissue+label%3Akind%2Fbug+label%3Aarea%2Fstorage%2Fdevicemapper)

History:

- After `aufs` failed, Red Hat developers started to build another UnionFS
- Docker gave support to Red Hat

Good:

- Mainstream kernel since 2.6.9
- `direct-lvm` is recommended and stable
- Block based (minimum 32KB) -> supports quota
- High memory consumption
- Default FS for Fedora, RHEL, Project Atomic-variants of the same

Bad:

- `loop-lvm` mode is **NOT** production ready and avoided
- Doesn't work well out-of-box. [Complex configuration](https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/#/configure-direct-lvm-mode-for-production).

## [Overlay](https://docs.docker.com/engine/userguide/storagedriver/overlayfs-driver/)

[Current Open Bugs](https://github.com/docker/docker/issues?q=is%3Aopen+is%3Aissue+label%3Akind%2Fbug+label%3Aarea%2Fstorage%2Foverlay)

History:

- Since `aufs` did not accepted, Docker released another UnionFS: `Overlay`
- Complete rewrite and provides simpler implementation

Good:

- Accepted in upstream kernel as of 3.18
- Provides same functionality as `aufs`

Bad:

- Due to its implementation of lower layers, creates serious bugs.
- Docker **DOES NOT** recommends using `Overlay` due to inode exhaustion.

## [Overlay2](https://docs.docker.com/engine/userguide/storagedriver/overlayfs-driver/)

[Current Open Bugs](https://github.com/docker/docker/issues?q=is%3Aopen+is%3Aissue+label%3Akind%2Fbug+label%3Aarea%2Fstorage%2Foverlay)

History:

- After `Overlay` filesystem created serious bugs that withhold its wide usage, Docker created `Overlay2`
- It uses new functionalities of Linux Kernel and requires at least kernel version `4.0`.

Good:

- Accepted in upstream kernel as of `4.0`.
- Solves lower layer link problem introduced in `Overlay`
- Default on CoreOS
- Testing

Bad:

- According to Docker, it is not production ready yet

  > Many people consider OverlayFS as the future of the Docker storage driver. However, it is less mature, and potentially less stable than some of the more mature drivers such as aufs and devicemapper. For this reason, you should use the OverlayFS driver with caution and expect to encounter more bugs and nuances than if you were using a more mature driver.

# Summary

History of storage drivers of Docker did not go smoothly. There is no one storage driver that is recommended for everybody. Each Host OS have their recommendations:

Host OS | Recommended File System
------- | -----------------------
CoreOS  | `OverlayFS`
Ubuntu  | `aufs`
RHEL    | `device mapper`

OverlayFS is still young and not production ready. Device mapper is reported to be stable but has the best experience with RHEL systems. For Debian based hosts, `aufs` is the best option, even though it is not supported by kernel.

# More read

## [Storage Drivers in Docker: A Deep Dive](https://integratedcode.us/2016/08/30/storage-drivers-in-docker-a-deep-dive/)
