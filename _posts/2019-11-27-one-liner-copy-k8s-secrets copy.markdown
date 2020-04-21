---
layout: single
title: "One liner to copy all secrets from one namespace to another in Kubernetes"
date: "2019-11-27 16:46:04 +0100"
---

If you ever need to copy all secrets from one namespace to another, execute the following one liner:

```bash
$ for i in `kubectl get secrets | awk '{print $1}'`; do  kubectl get secret $1 -n <source-namespace> -o yaml | sed s/"namespace: <source-namespace>"/"namespace: <target-namespace>"/ | kubectl apply -n <target-namespace> -f -  ; done
```
