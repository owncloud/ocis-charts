# oCIS Web app and full-text search deployment example

## Introduction

This example is the source-aligned Web integration profile with full-text search. It deploys a
mostly default oCIS setup and Apache Tika to Kubernetes, configures the Search service to use the
Tika extractor, and enables full-text search in Web. It also demonstrates how to install Web apps
through the oCIS Helm Chart. The intent is that this will work "out of the box" after a
`helmfile sync`.

Tika is always part of this profile because the Photo add-on and Advanced Search Web extensions
require its extracted content and metadata. Keep the Tika release and Search extractor settings
enabled when adding either extension to this profile.


***Note***: This example is not intended for production use. It is intended to get a working oCIS
development running in Kubernetes as quickly as possible. It is not hardened in any way.

## Getting started

### Prerequisites

This example requires the following things to be installed:

- [Kubernetes](https://kubernetes.io/) cluster, with an ingress controller installed.
- [Helm](https://helm.sh/) v3
- [Helmfile](https://github.com/helmfile/helmfile)

### End result

After following the steps in this guide, you should be able to access the following endpoint, you
may want to add these to your `/etc/hosts` file pointing to your ingress controller IP:

- https://ocis.kube.owncloud.test

Note that if you want to use your own hostname and domain, you will have to change the `externalDomain` value.

### Deploying

In this directory, run the following commands:

```bash
$ helmfile sync
```

This will deploy all the needed steps.

The profile installs `apache/tika:latest-full` in the `tika` namespace and configures oCIS to use its
in-cluster service. The full Tika image includes OCR support and is currently available for AMD64
only.

### Logging in

You can get the admin password with the following command:

```bash
$ kubectl -n ocis get secrets/admin-user --template='{{.data.password | base64decode | printf "%s\n" }}'
```

You can use this password to login with the user `admin`.

### Limitations

As this is deployed with a `ReadWriteOnce` storage access mode, the deployments persistence will be limited to
a single pod. If you want to scale the pods, you will need to change the storage access mode to `ReadWriteMany`.
If you do this, please check if your storage provider supports this access mode.

### Development

Note this chart is made for development, therefore both `demoUsers` is set to true. Using this chart in production is not recommended.
