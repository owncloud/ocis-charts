# ownCloud Infinte Scale Helm Chart

* Installs [ownCloud Infinite Scale](http://owncloud.dev/ocis)

## Get Repo Info

This chart is still in an experimental phase, and it has not yet been published.

[//]: # (```console)
[//]: # (helm repo add ocis https://owncloud.dev/ocis/helm-charts)
[//]: # (helm repo update)
[//]: # (```)

## Installing the Chart

[//]: # (To install the chart with the release name `my-release`:)

[//]: # (```console)
[//]: # (helm install my-release ocis/ocis)
[//]: # (```)

To install the chart with the release name `my-release`:
- clone this git repository
- run `helm install my-release ./charts/ocis` from the root of this git repository

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Upgrading an existing Release to a new major version

A major chart version change (like v1.2.3 -> v2.0.0) indicates that there is an
incompatible breaking change needing manual actions.

### 1.x.x Tech Preview Versions

All release can be breaking during Tech Preview, see [oCIS Tech Preview](https://owncloud.dev/ocis/release_roadmap/)



## Configuration

| Parameter                                                  | Description                                                      | Default                                                            |
| ---------------------------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------ |
| `deploymentStrategy`                                       | Deployment strategy                                              | `{ "type": "RollingUpdate" }`                                      |
| `externalDomain`                                           | Domain where oCIS is reachable for the outside world             | `ocis.owncloud.test`                                               |
| `extraLabels`                                              | Custom labels for all manifests                                  | `{}`                                                               |
| `extraResources`                                           | Extra resources to be included                                   | `[]`                                                               |
| `image.pullPolicy`                                         | Image pull policy                                                | `IfNotPresent`                                                     |
| `image.repository`                                         | Image repository                                                 | `owncloud/ocis`                                                    |
| `image.sha`                                                | Image sha (optional)                                             | `a49a106802ebe44e1cfdc04ca71661be104d87224f0e6fd8e2477bc3bb078b92` |
| `image.tag`                                                | Image tag                                                        | `latest`                                                                 |
| `ingress.annotations`                                      | Ingress annotations (values are templated)                       | `{}`                                                               |
| `ingress.enabled`                                          | Enables Ingress                                                  | `false`                                                            |
| `ingress.labels`                                           | Custom labels                                                    | `{}`                                                               |
| `ingress.tls`                                              | Ingress TLS configuration                                        | `[]`                                                               |
| `logging.color`                                            | Log in color                                                     | `false`                                                            |
| `logging.level`                                            | Log level                                                        | `error`                                                            |
| `logging.pretty`                                           | Log json or human friendly                                       | `false`                                                            |
| `replicas`                                                 | Number of nodes                                                  | `1`                                                                |
| `resources`                                                | CPU/Memory resource requests/limits                              | `{}`                                                               |
| `secrets.jwt`                                              | JWT secret                                                       | `replace-me-with-a-real-secret-123`                                |
| `secrets.machineAuth`                                      | machine auth secret for internal service communication           | `replace-me-with-a-real-secret-456`                                |
| `secrets.transfer`                                         | JWT secret for up- and downloads                                 | `replace-me-with-a-real-secret-789`                                |
| `storageMetadata.persistence.accessModes`                  | metadata storage service: Persistence access modes               | `[ReadWritMany]`                                                   |
| `storageMetadata.persistence.annotations`                  | metadata storage service: PersistentVolumeClaim annotations      | `{}`                                                               |
| `storageMetadata.persistence.enabled`                      | metadata storage service: Use persistent volume to store data    | `false`                                                            |
| `storageMetadata.persistence.existingClaim`                | metadata storage service: Use an existing PVC to persist data    | `nil`                                                              |
| `storageMetadata.persistence.finalizers`                   | metadata storage service: PersistentVolumeClaim finalizers       | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageMetadata.persistence.size`                         | metadata storage service: Size of persistent volume claim        | `5Gi`                                                              |
| `storageMetadata.persistence.storageClassName`             | metadata storage service: Type of persistent volume claim        | `nil`                                                              |
| `storageSharing.persistence.accessModes`                   | sharing service: Persistence access modes                        | `[ReadWritMany]`                                                   |
| `storageSharing.persistence.annotations`                   | sharing service: PersistentVolumeClaim annotations               | `{}`                                                               |
| `storageSharing.persistence.enabled`                       | sharing service: Use persistent volume to store data             | `false`                                                            |
| `storageSharing.persistence.existingClaim`                 | sharing service: Use an existing PVC to persist data             | `nil`                                                              |
| `storageSharing.persistence.finalizers`                    | sharing service: PersistentVolumeClaim finalizers                | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageSharing.persistence.size`                          | sharing service: Size of persistent volume claim                 | `5Gi`                                                              |
| `storageSharing.persistence.storageClassName`              | sharing service: Type of persistent volume claim                 | `nil`                                                              |
| `storageUsers.persistence.accessModes`                     | users storage service: Persistence access modes                  | `[ReadWritMany]`                                                   |
| `storageUsers.persistence.annotations`                     | users storage service: PersistentVolumeClaim annotations         | `{}`                                                               |
| `storageUsers.persistence.enabled`                         | users storage service: Use persistent volume to store data       | `false`                                                            |
| `storageUsers.persistence.existingClaim`                   | users storage service: Use an existing PVC to persist data       | `nil`                                                              |
| `storageUsers.persistence.finalizers`                      | users storage service: PersistentVolumeClaim finalizers          | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageUsers.persistence.size`                            | users storage service: Size of persistent volume claim           | `50Gi`                                                             |
| `storageUsers.persistence.storageClassName`                | users storage service: Type of persistent volume claim           | `nil`                                                              |
| `storageUsers.storageBackend.driver:`                      | users storage: Storage backend driver                            | `ocis`                                                             |
| `storageUsers.storageBackend.driverConfig.s3ng.accessKey:` | users storage: S3ng Storage backend driver S3 access key         | `lorem-ipsum`                                                      |
| `storageUsers.storageBackend.driverConfig.s3ng.bucket:`    | users storage: S3ng Storage backend driver S3 bucket             | `example-bucket`                                                   |
| `storageUsers.storageBackend.driverConfig.s3ng.endpoint:`  | users storage: S3ng Storage backend driver S3 endpoint           | `https://localhost:1234`                                           |
| `storageUsers.storageBackend.driverConfig.s3ng.region:`    | users storage: S3ng Storage backend driver S3 region             | `default`                                                          | ` |
| `storageUsers.storageBackend.driverConfig.s3ng.secretKey:` | users storage: S3ng Storage backend driver S3 secret key         | `lorem-ipsum`                                                      |
| `store.persistence.accessModes`                            | store service: Persistence access modes                          | `[ReadWritMany]`                                                   |
| `store.persistence.annotations`                            | store service: PersistentVolumeClaim annotations                 | `{}`                                                               |
| `store.persistence.enabled`                                | store service: Use persistent volume to store data               | `false`                                                            |
| `store.persistence.existingClaim`                          | store service: Use an existing PVC to persist data               | `nil`                                                              |
| `store.persistence.finalizers`                             | store service: PersistentVolumeClaim finalizers                  | `[ "kubernetes.io/pvc-protection" ]`                               |
| `store.persistence.size`                                   | store service: Size of persistent volume claim                   | `5Gi`                                                              |
| `store.persistence.storageClassName`                       | store service: Type of persistent volume claim                   | `nil`                                                              |
| `thumbnails.persistence.accessModes`                       | thumbnails service: Persistence access modes                     | `[ReadWritMany]`                                                   |
| `thumbnails.persistence.annotations`                       | thumbnails service: PersistentVolumeClaim annotations            | `{}`                                                               |
| `thumbnails.persistence.enabled`                           | thumbnails service: Use persistent volume to store data          | `false`                                                            |
| `thumbnails.persistence.existingClaim`                     | thumbnails service: Use an existing PVC to persist data          | `nil`                                                              |
| `thumbnails.persistence.finalizers`                        | thumbnails service: PersistentVolumeClaim finalizers             | `[ "kubernetes.io/pvc-protection" ]`                               |
| `thumbnails.persistence.size`                              | thumbnails service: Size of persistent volume claim              | `10Gi`                                                             |
| `thumbnails.persistence.storageClassName`                  | thumbnails service: Type of persistent volume claim              | `nil`                                                              |
| -----------------------------------                        | ---------------------------------------------------------------- | ------------------------------------                               |



### Example with NGINX ingress and certificate issued by cert-manager

To make this work you need to have NGINX ingress and cert-manager installed in your cluster.

```yaml
  externalDomain: ocis.owncloud.test

  ingress:
    enabled: true
    ingressClassName: nginx
    annotations:
      cert-manager.io/issuer: "ocis-certificate-issuer"
    tls:
      - hosts:
        - ocis.owncloud.test
        secretName: ocis-tls-certificate

  extraResources:
    - |
      apiVersion: cert-manager.io/v1
      kind: Issuer
      metadata:
        name: ocis-certificate-issuer
        namespace: ocis-namespace
      spec:
        acme:
          server: https://acme-v02.api.letsencrypt.org/directory
          email: test@example.test
          privateKeySecretRef:
            name: ocis-certificate-issuer
          solvers:
          - http01:
              ingress:
                class: nginx
```
