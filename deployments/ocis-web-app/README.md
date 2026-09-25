# oCIS Web app deployment example

## Introduction

This example will deploy a mostly default oCIS setup to Kubernetes. It demonstrates you how to install Web apps, via the oCIS Helm Chart. The intent is that this will
work "out of the box" after a `helmfile sync`.


***Note***: This example is not intended for production use. It is intended to get a working oCIS
development running in Kubernetes as quickly as possible. It is not hardened in any way.

## Getting started

### Prerequisites

This example requires the following things to be installed:

- [Kubernetes](https://kubernetes.io/) cluster, with an ingress controller installed.
- [Helm](https://helm.sh/) v3
- [Helmfile](https://github.com/helmfile/helmfile)
- DNS that resolves the oCIS and Companion hostnames to the ingress controller from both clients and
  cluster workloads.

### End result

After following the steps in this guide, you should be able to access the following endpoint, you
may want to add these to your `/etc/hosts` file pointing to your ingress controller IP:

- https://ocis.kube.owncloud.test
- https://companion.kube.owncloud.test

Note that if you want to use your own hostname and domain, you will have to change the `externalDomain`
value and the corresponding Companion domain, origin allowlist, upload allowlist, Importer app configuration,
Companion Ingress and TLS hosts, and Companion HTTPS/WSS sources in the oCIS CSP configuration.

An `/etc/hosts` entry affects only that client. Companion sends imported files to the external oCIS URL, so
`ocis.kube.owncloud.test` must also resolve to the ingress controller from inside the Companion pod.

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

### Importing public links

The Importer Web app uses [Uppy Companion](https://uppy.io/docs/companion/) to import files from other
clouds. This example enables only `WebdavPublicLink`, configured for public links from oCIS and ownCloud 10.
Companion runs as a single replica, stores its temporary transfer data on a 10 GiB persistent volume, and
receives a stable session secret generated and retained by Helm.

OneDrive is disabled by default. To enable it, add `OneDrive` to the Importer `supportedClouds` list, register
`https://companion.kube.owncloud.test/onedrive/redirect` with the provider, and create the credentials Secret:

```bash
$ kubectl -n ocis create secret generic companion-provider-credentials \
    --from-literal=onedrive-key='<client-id>' \
    --from-literal=onedrive-secret='<client-secret>'
$ helmfile sync
$ kubectl -n ocis rollout restart deployment/companion
```

Companion reads provider credentials only when the pod starts, so restart it after creating or updating the
Secret. Keep provider credentials in a Secret or external secret manager; do not add them directly to the
Helmfile.

### Limitations

As this is deployed with a `ReadWriteOnce` storage access mode, the deployments persistence will be limited to
a single pod. If you want to scale the pods, you will need to change the storage access mode to `ReadWriteMany`.
If you do this, please check if your storage provider supports this access mode.

Companion cannot be made highly available by changing the volume access mode alone. More than one replica
requires shared Redis state and the same stable Companion secret on every replica. Active transfers do not
survive a pod restart, and temporary imported data remains on the Companion volume until its cleanup runs.

### Development

Note this chart is made for development, therefore `demoUsers` is set to true. Using this chart in
production is not recommended.
The example also sets `NODE_TLS_REJECT_UNAUTHORIZED=0` so Companion can reach the self-signed oCIS endpoint;
this disables certificate verification for all of Companion's outbound HTTPS requests. A production setup
must use trusted TLS and remove that setting. It should also use externally managed secrets, encrypted and
appropriately sized temporary storage, strict upload and client-origin allowlists, constrained network egress,
rate and file-size limits, and resource limits sized for the expected imports.
