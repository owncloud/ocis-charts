# oCIS with Office integration deployment example

## Introduction

This example shows how to deploy oCIS with Collabora and OnlyOffice as Office. It also brings Tika for fulltext search extraction.
It will deploy an oCIS instance, Collabora and OnlyOffice and Tika, preconfigured to work together.

***Note***: This example is not intended for production use. It is intended to get a working oCIS
with Collabora, OnlyOffice and Tika running in Kubernetes as quickly as possible. It is not hardened in any way.

## Getting started

### Prerequisites

This example requires the following things to be installed:

- [Kubernetes](https://kubernetes.io/) cluster, with an ingress controller installed.
- [Helm](https://helm.sh/) v3
- [Helmfile](https://github.com/helmfile/helmfile)
- [Kustomize](https://kustomize.io)

### End result

After following the steps in this guide, you should be able to access the following endpoint, you
may want to add these to your `/etc/hosts` file pointing to your ingress controller IP:

- https://ocis.kube.owncloud.test
- https://collabora.kube.owncloud.test
- https://onlyoffice.kube.owncloud.test

Note that if you want to use your own hostname and domain, you will have to change the `externalDomain` value.

### Deploying

In this directory, run the following commands:

```bash
$ helmfile sync
```

This will deploy oCIS, Tika, the WOPI server, Collabora and OnlyOffice.

### Logging in

You can get the admin password with the following command:

```bash
$ kubectl -n ocis get secret admin-user -o go-template --template="{{.data.password | base64decode }}"
```

You can use this password to login with the user `admin`.
