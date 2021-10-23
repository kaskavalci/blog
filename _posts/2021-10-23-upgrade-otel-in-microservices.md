---
layout: single
title: "Upgrade Open Telemetry Go Instrumentation Libraries in Microservices"
tags: golang opentelemetry microservices
---

[OpenTelemetry](https://opentelemetry.io/) is the work-in-progress merge of
OpenCensus and OpenTracing. It is still in early stages as of 2021. We are using
its instrumentation libraries
[opentelemetry-go](https://github.com/open-telemetry/opentelemetry-go) and
[opentelemetry-go-contrib](https://github.com/open-telemetry/opentelemetry-go-contrib/)
for our Go services. This post is about how to upgrade your instrumentation
libraries in a micro service environment. You guessed it, it's not
straightforward.

## Upgrade is easy, just run go get

Yes and no. Opentelemtry-go is still actively being developed and is not General
Release yet. So, expect breaking changes. Some packages may be renamed or
disappear completely. When you upgrade, you need to be aware of breaking changes
and stop using the deprecated packages or methods.

You can either review
[Changelog](https://github.com/open-telemetry/opentelemetry-go/blob/main/CHANGELOG.md)
which offers a great history of features, bug fixes and breaking changes. PR
numbers for every breaking change are given next to the line. For instance:

> Metric SDK/API implementation type InstrumentKind moves into sdkapi sub-package. (#2091)

Just search for PR #2091 in the repository and find out what has changed. Within
that PR maintainers should also fix all references for this breaking change in
the codebase so you know what to change to adopt the breaking change.

Sometimes though, there are too many breaking change you can follow. Then, I
recommend checking their examples. In
[example](https://github.com/open-telemetry/opentelemetry-go/tree/main/example)
folder there are small examples how you can use certain functionalities. Such as,
exporting to Prometheus. Verify if what you are doing in your code matches with
the steps there.

## Upgrade is done, what's with microservices?

If you have a single service that does not depend on others, you can skip that
part. Imagine the following scenario.

![Service Dependency](/assets/2021-10-23-service-dependency.jpg)

In this dependency graph, Service A and Service B both use otel v0.20.0.
Service B depends on Service A. Now, Service B wants to upgrade to otel v0.25.0.
That may not work. Even though every dependency in Service B is now compatible
with otel v0.25.0, since Service B depends on Service A, go mod will still
download otel v0.20.0 artifacts. When there are breaking changes, you will see
an error of `ambiguous import` like this:

```sh
$ go mod tidy
github.com/your-service imports
        go.opentelemetry.io/contrib/instrumentation/github.com/gin-gonic/gin/otelgin tested by
        go.opentelemetry.io/contrib/instrumentation/github.com/gin-gonic/gin/otelgin.test imports
        go.opentelemetry.io/contrib/propagators/b3: ambiguous import: found package go.opentelemetry.io/contrib/propagators/b3 in multiple modules:
        go.opentelemetry.io/contrib/propagators v0.20.0 (~/workspace/gow/pkg/mod/go.opentelemetry.io/contrib/propagators@v0.20.0/b3)
        go.opentelemetry.io/contrib/propagators/b3 v1.0.0 (~/workspace/gow/pkg/mod/go.opentelemetry.io/contrib/propagators/b3@v1.0.0)
```

There will be no references to `v0.20.0` in your go.mod file since you are not
using it. However, in go.sum you can find the hashes of the previous version.

## Just tell me how to solve it already

Upgrade with respect to your dependency graph. In our scenario, you will need to
upgrade otel in Service A first. Then, upgrade Service A dependency in Service
B. That will likely give otel dependency errors to you. Upgrade otel
dependencies and resolve breaking changes.

Congratulations, you have upgraded your instrumentation libraries.
