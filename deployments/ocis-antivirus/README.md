# oCIS development deployment example

## Introduction

This example will deploy a mostly default oCIS setup to Kubernetes. The intent is that this will
work "out of the box" after a `helmfile sync`.

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
