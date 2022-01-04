---
layout: single
title: "Lima as Docker Desktop Replacement"
tags: docker podman lima
---

I've had some issues using podman as a complete Docker replacement. Especially
around exposing docker API as a socket. This is required for some libraries such
as [dockertest](https://github.com/ory/dockertest/). Library uses `DOCKER_HOST`
environment variable and communicates with Docker daemon via the socket file
pointed by the environment variable.

I found [lima](https://github.com/lima-vm/lima) as a good replacement. Lima is a
VM solution that uses qemu behind the wheels. Getting started is fairly easy.

## Delete docker for desktop

If you haven't done already, uninstall docker for desktop.

```sh
brew uninstall --cask docker
```

Keep docker CLI. It is only a wrapper to communicate with docker backend. If you
don't have it, install it by:

```sh
brew install docker
```

## Use Lima as Docker for Desktop Replacement

1. First, Install lima `brew install lima`.
1. Start lima VM `lima start`.
1. You will be prompted by a configuration selection. Choose `Open an editor to override the configuration`.
1. Copy the contents of
[examples/docker.yaml](https://github.com/lima-vm/lima/blob/master/examples/docker.yaml)
and replace it with prompted configuration.
1. Expose `DOCKER_HOST` the way it is logged.

Here is an example result of the start command:

```
INFO[0135] READY. Run `lima` to open the shell.
INFO[0135] To run `docker` on the host (assumes docker-cli is installed):
INFO[0135] $ export DOCKER_HOST=unix:///Users/halil/.lima/default/sock/docker.sock
INFO[0135] $ docker ...
```

## Test it out

`docker info` should print information about the VM lima runs.
