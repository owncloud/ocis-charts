# oCIS with external usermanagement deployment example

## Introduction

This example shows how to deploy oCIS with external usermanagement.
It will deploy an oCIS instance, a Keycloak instance, a PostgreSQL instance, and an 
OpenLDAP instance, preconfigured to work together.

***Note:*** This example is not intended for production use. It is intended to show how to
deploy these parts and how to configure them to work together. It is not hardened in any way,
and has example passwords and certificates.


## Getting started

### Prerequisites

This example requires the following things to be installed:

- [Kubernetes](https://kubernetes.io/) cluster, with an ingress controller installed.
- [Helm](https://helm.sh/) v3
- [Helm diff](https://github.com/databus23/helm-diff)
- [Helmfile](https://github.com/roboll/helmfile)

### End result

After following the steps in this guide, you should be able to access the following endpoints, you 
may want to add these to your `/etc/hosts` file pointing to your ingress controller IP:

- https://ocis.kube.owncloud.test
- https://keycloak.kube.owncloud.test

Note that keycloak has its own self-signed certificate, so you will need to accept that in your browser.

### Deploying

In this directory, run the following commands:

```bash
$ helmfile sync
```

This will deploy all the needed steps.

Once keycloak is up and running, you should be able to login to oCIS. Do note, that if you are still
using the default self-signed certificate for keycloak, you will need to accept the certificate in your
browser before you can login to oCIS.
