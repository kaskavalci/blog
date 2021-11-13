---
layout: single
title: "Docker Desktop Alternatives"
tags: docker podman
---

Docker recently updated [its
license](https://www.docker.com/blog/updating-product-subscriptions/). This made
Docker for Desktop a paid product for enterprises. In this post, you will learn
about your alternatives.

## What does Docker Desktop do?

Docker is for Linux systems. In order to run containers, you need a Linux
operating system. If you use MacOS or Windows, then you will need a Linux VM in
order to run Docker commands. This is where Docker Desktop comes in.

Docker desktop is an end to end solution that includes a VM, Linux distribution
and docker daemon that runs inside it. Your host machine communicates with the
VM to run docker commands in it.

## What are the Docker Desktop alternatives?

There are couple of alternatives if you want to get rid of Docker Desktop for
any reason. Some are mature, some are still in early stages.

### Podman

[Podman](https://podman.io/) is a daemonless container engine for developing,
managing, and running OCI Containers on your Linux System. It is open source. It
is a docker replacement. Podman is compatible with Docker API and CLI. You can
switch as easy as `alias docker=podman`.

However, podman still lacks some features such as supporting Docker socket by
default or compose features. Community is actively working to fill the gaps.

Installation guide (Mac only)

```sh
# Install podman
$ brew install podman
# Download VM
$ podman machine init
# Start the VM
$ podman machine start
# Start using podman. (save this to your shell profile)
$ alias docker=podman
```

Support for applications that need to use docker socket (DOCKER_HOST). See
podman [issue #11397](https://github.com/containers/podman/issues/11397).

```sh
# Create a SSH tunnel to the guest OS
$ ssh -nNT -L/tmp/podman.sock:/run/user/1000/podman/podman.sock -i ~/.ssh/podman-machine-default ssh://core@localhost:55591
# Use podman as DOCKER_HOST
$ export DOCKER_HOST='unix:///tmp/podman.sock'
```

### Minikube

[minikube](https://minikube.sigs.k8s.io/docs/start/) is a managed VM to run
Kubernetes on your local machine. It is possible to configure it to spit out
environment configuration for Docker and Podman.

You will need minikube to be running in order to use Docker commands.

```sh
# Install minikube
$ brew install minikube
# Start local cluster
$ minikube start
# Consume docker env
$ eval $(minikube docker-env)
```

Note that you will run a complete kubernetes cluster to run Docker commands.
This may or may not be an issue for your setup.

## Rancher Desktop

[Rancher Desktop](https://rancherdesktop.io/) is
another alternative to Docker Desktop. It is maintained by
[Rancher](https://rancher.com/). In my experience I wasn't able to fully
integrate it. It is under active development. It is definitely an
alternative.

## Conclusion

I have been using podman actively for a week now. In my experience, podman is
the slimmest and stable alternative to Docker Desktop.

## Further reading / watching

- [Docker Desktop Licensing Changes: DevOps and Docker Live
Show](https://www.youtube.com/watch?v=1Al9lzpFzn0&t=3475s) 🎬
- [An Overview of Docker Desktop
  Alternatives](https://matt-rickard.com/docker-desktop-alternatives/)
- [Goodbye Docker Desktop, Hello
  Minikube!](https://itnext.io/goodbye-docker-desktop-hello-minikube-3649f2a1c469)
- [The Magic Behind the Scenes of Docker Desktop](https://www.docker.com/blog/the-magic-behind-the-scenes-of-docker-desktop/)
