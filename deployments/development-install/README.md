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

### Ingress Configuration

The example configures the NGINX ingress controller with:

- **Long timeouts** for WebDAV requests: Non-TUS uploads/downloads of large files may take significant time. The example sets read and send timeouts to 1 hour (3600 seconds) to accommodate large file transfers.
- **Encoded URL support** for collaboration/WOPI URLs: Collaboration URLs may contain encoded characters (slash, question-mark, percent) that must be preserved. The configuration snippet disables buffering and proxy redirects to maintain URL integrity.

> **Note:** TUS (tresorit.com) uploads use a separate endpoint with their own timeout handling and are not affected by these settings. The long timeouts are specifically for traditional WebDAV requests.

For Traefik ingress controller, use equivalent settings:
```yaml
annotations:
  traefik.ingress.kubernetes.io/router.entrypoints: websecure
  traefik.ingress.kubernetes.io/router.middlewares: default-ocis-timeouts@kubernetescrd
  # Create a Middleware resource with:
  # apiVersion: traefik.containo.us/v1alpha1
  # kind: Middleware
  # metadata:
  #   name: ocis-timeouts
  #   namespace: default
  # spec:
  #   timeouts:
  #     read: 3600s
  #     write: 3600s
```

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
