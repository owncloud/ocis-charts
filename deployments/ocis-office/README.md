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

### Collabora WOPI proof key

The Collabora chart generates a unique WOPI proof key during the first `helmfile sync` and reuses it
on later upgrades by looking up the existing Secret in the cluster. The generated Secret is named
`collabora-collabora-online-wopi-proof` by default. Helm owns this Secret, so uninstalling the
Collabora release deletes it.

This live lookup is not available to tools that render charts offline, such as Argo CD and Flux. For
a GitOps deployment, create and manage a Secret containing `proof_key` and `proof_key.pub`, set
`collabora.proofKeyGeneration.enabled` to `false`, and set `collabora.proofKeysSecretRef` to that
Secret's name instead.

When upgrading an existing installation, the old `proofkey` Secret may remain in the namespace, but
it is no longer mounted. The new Secret name intentionally prevents the old example key from being
reused.

### Logging in

You can get the admin password with the following command:

```bash
$ kubectl -n ocis get secret admin-user -o go-template --template="{{.data.password | base64decode }}"
```

You can use this password to login with the user `admin`.
