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

| Parameter                                                  | Description                                                              | Default                                                            |
| ---------------------------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------ |
| `autoscaling.enabled`                                      | Enables autoscaling. Mutual exclusive with `replicas`                    | `false`                                                            |
| `autoscaling.maxReplicas`                                  | Sets maximum replicas for autoscaling                                    | `10`                                                               |
| `autoscaling.metrics`                                      | Metrics to use for autoscaling                                           | `[]`                                                               |
| `autoscaling.minReplicas`                                  | Sets minimum replicas for autoscaling                                    | `1`                                                                |
| `deploymentStrategy`                                       | Deployment strategy                                                      | `{ "type": "RollingUpdate" }`                                      |
| `externalDomain`                                           | Domain where oCIS is reachable for the outside world                     | `ocis.owncloud.test`                                               |
| `extraLabels`                                              | Custom labels for all manifests                                          | `{}`                                                               |
| `extraResources`                                           | Extra resources to be included                                           | `[]`                                                               |
| `features.basicAuthentication`                             | Enable basic authentication. Not recommended for production instances    | `false`                                                            |
| `features.demoUsers`                                       | Create demo users on the first startup                                   | `false`                                                            |
| `idm.persistence.accessModes`                              | idm service: Persistence access modes                                    | `[ReadWriteMany]`                                                   |
| `idm.persistence.annotations`                              | idm service: PersistentVolumeClaim annotations                           | `{}`                                                               |
| `idm.persistence.enabled`                                  | idm service: Use persistent volume to store data                         | `false`                                                            |
| `idm.persistence.existingClaim`                            | idm service: Use an existing PVC to persist data                         | `nil`                                                              |
| `idm.persistence.finalizers`                               | idm service: PersistentVolumeClaim finalizers                            | `[ "kubernetes.io/pvc-protection" ]`                               |
| `idm.persistence.size`                                     | idm service: Size of persistent volume claim                             | `10Gi`                                                             |
| `idm.persistence.storageClassName`                         | idm service: Type of persistent volume claim                             | `nil`                                                              |
| `image.pullPolicy`                                         | Image pull policy                                                        | `IfNotPresent`                                                     |
| `image.repository`                                         | Image repository                                                         | `owncloud/ocis`                                                    |
| `image.sha`                                                | Image sha (optional)                                                     | `6cc24c065d2832c26fa628daa917e1a1543b63a24fab48daf56c0521a688ffe9` |
| `image.tag`                                                | Image tag                                                                | `latest`                                                           |
| `ingress.annotations`                                      | Ingress annotations (values are templated)                               | `{}`                                                               |
| `ingress.enabled`                                          | Enables Ingress                                                          | `false`                                                            |
| `ingress.ingressClassName`                                 | Name of the ingress class                                                | empty (default ingress)                                            |
| `ingress.labels`                                           | Custom labels                                                            | `{}`                                                               |
| `ingress.tls`                                              | Ingress TLS configuration                                                | `[]`                                                               |
| `logging.color`                                            | Log in color                                                             | `false`                                                            |
| `logging.level`                                            | Log level                                                                | `error`                                                            |
| `logging.pretty`                                           | Log json or human friendly                                               | `false`                                                            |
| `namespaceOverride`                                        | Override the namespace of all resources in this Helm chart               | ``                                                                 |
| `nats.persistence.accessModes`                             | nats service: Persistence access modes                                   | `[ReadWriteMany]`                                                   |
| `nats.persistence.annotations`                             | nats service: PersistentVolumeClaim annotations                          | `{}`                                                               |
| `nats.persistence.enabled`                                 | nats service: Use persistent volume to store data                        | `false`                                                            |
| `nats.persistence.existingClaim`                           | nats service: Use an existing PVC to persist data                        | `nil`                                                              |
| `nats.persistence.finalizers`                              | nats service: PersistentVolumeClaim finalizers                           | `[ "kubernetes.io/pvc-protection" ]`                               |
| `nats.persistence.size`                                    | nats service: Size of persistent volume claim                            | `10Gi`                                                             |
| `nats.persistence.storageClassName`                        | nats service: Type of persistent volume claim                            | `nil`                                                              |
| `replicas`                                                 | Number of replicas for each service. Mutual exclusive with `autoscaling` | `1`                                                                |
| `resources`                                                | CPU/Memory resource requests/limits                                      | `{}`                                                               |
| `search.persistence.accessModes`                           | search service: Persistence access modes                                 | `[ReadWriteMany]`                                                   |
| `search.persistence.annotations`                           | search service: PersistentVolumeClaim annotations                        | `{}`                                                               |
| `search.persistence.enabled`                               | search service: Use persistent volume to store data                      | `false`                                                            |
| `search.persistence.existingClaim`                         | search service: Use an existing PVC to persist data                      | `nil`                                                              |
| `search.persistence.finalizers`                            | search service: PersistentVolumeClaim finalizers                         | `[ "kubernetes.io/pvc-protection" ]`                               |
| `search.persistence.size`                                  | search service: Size of persistent volume claim                          | `10Gi`                                                             |
| `search.persistence.storageClassName`                      | search service: Type of persistent volume claim                          | `nil`                                                              |
| `secretRefs.adminUserSecretRef`                            | Reference to an existing admin user secret                               | `""` (autogenerated)                                               |
| `secretRefs.idpSecretRef`                                  | Reference to an existing idp secret                                      | `""` (autogenerated)                                               |
| `secretRefs.jwtSecretRef`                                  | Reference to an existing JWT secret                                      | `""` (autogenerated)                                               |
| `secretRefs.ldapCaRef`                                     | Reference to an existing ldap ca secret                                  | `""` (autogenerated)                                               |
| `secretRefs.ldapSecretRef`                                 | Reference to an existing ldap secret                                     | `""` (autogenerated)                                               |
| `secretRefs.machineAuthApiKeySecretRef`                    | Reference to an existing machine auth api key secret                     | `""` (autogenerated)                                               |
| `secretRefs.storageSystemJwtSecretRef`                     | Reference to an existing storage system jwt secret                       | `""` (autogenerated)                                               |
| `secretRefs.storageSystemSecretRef`                        | Reference to an existing storage system secret                           | `""` (autogenerated)                                               |
| `secretRefs.thumbnailsSecretRef`                           | Reference to an existing thumbnails secret                               | `""` (autogenerated)                                               |
| `secretRefs.transferSecretSecretRef`                       | Reference to an existing transfer secret                                 | `""` (autogenerated)                                               |
| `storageSharing.persistence.accessModes`                   | sharing service: Persistence access modes                                | `[ReadWriteMany]`                                                   |
| `storageSharing.persistence.annotations`                   | sharing service: PersistentVolumeClaim annotations                       | `{}`                                                               |
| `storageSharing.persistence.enabled`                       | sharing service: Use persistent volume to store data                     | `false`                                                            |
| `storageSharing.persistence.existingClaim`                 | sharing service: Use an existing PVC to persist data                     | `nil`                                                              |
| `storageSharing.persistence.finalizers`                    | sharing service: PersistentVolumeClaim finalizers                        | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageSharing.persistence.size`                          | sharing service: Size of persistent volume claim                         | `5Gi`                                                              |
| `storageSharing.persistence.storageClassName`              | sharing service: Type of persistent volume claim                         | `nil`                                                              |
| `storageSystem.persistence.accessModes`                    | system storage service: Persistence access modes                         | `[ReadWriteMany]`                                                   |
| `storageSystem.persistence.annotations`                    | system storage service: PersistentVolumeClaim annotations                | `{}`                                                               |
| `storageSystem.persistence.enabled`                        | system storage service: Use persistent volume to store data              | `false`                                                            |
| `storageSystem.persistence.existingClaim`                  | system storage service: Use an existing PVC to persist data              | `nil`                                                              |
| `storageSystem.persistence.finalizers`                     | system storage service: PersistentVolumeClaim finalizers                 | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageSystem.persistence.size`                           | system storage service: Size of persistent volume claim                  | `5Gi`                                                              |
| `storageSystem.persistence.storageClassName`               | system storage service: Type of persistent volume claim                  | `nil`                                                              |
| `storageUsers.persistence.accessModes`                     | users storage service: Persistence access modes                          | `[ReadWriteMany]`                                                   |
| `storageUsers.persistence.annotations`                     | users storage service: PersistentVolumeClaim annotations                 | `{}`                                                               |
| `storageUsers.persistence.enabled`                         | users storage service: Use persistent volume to store data               | `false`                                                            |
| `storageUsers.persistence.existingClaim`                   | users storage service: Use an existing PVC to persist data               | `nil`                                                              |
| `storageUsers.persistence.finalizers`                      | users storage service: PersistentVolumeClaim finalizers                  | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageUsers.persistence.size`                            | users storage service: Size of persistent volume claim                   | `50Gi`                                                             |
| `storageUsers.persistence.storageClassName`                | users storage service: Type of persistent volume claim                   | `nil`                                                              |
| `storageUsers.storageBackend.driver:`                      | users storage: Storage backend driver                                    | `ocis`                                                             |
| `storageUsers.storageBackend.driverConfig.s3ng.accessKey:` | users storage: S3ng Storage backend driver S3 access key                 | `""`                                                               |
| `storageUsers.storageBackend.driverConfig.s3ng.bucket:`    | users storage: S3ng Storage backend driver S3 bucket                     | `""`                                                               |
| `storageUsers.storageBackend.driverConfig.s3ng.endpoint:`  | users storage: S3ng Storage backend driver S3 endpoint                   | `""`                                                               |
| `storageUsers.storageBackend.driverConfig.s3ng.region:`    | users storage: S3ng Storage backend driver S3 region                     | `""`                                                               | ` |
| `storageUsers.storageBackend.driverConfig.s3ng.secretKey:` | users storage: S3ng Storage backend driver S3 secret key                 | `""`                                                               |
| `store.persistence.accessModes`                            | store service: Persistence access modes                                  | `[ReadWriteMany]`                                                   |
| `store.persistence.annotations`                            | store service: PersistentVolumeClaim annotations                         | `{}`                                                               |
| `store.persistence.enabled`                                | store service: Use persistent volume to store data                       | `false`                                                            |
| `store.persistence.existingClaim`                          | store service: Use an existing PVC to persist data                       | `nil`                                                              |
| `store.persistence.finalizers`                             | store service: PersistentVolumeClaim finalizers                          | `[ "kubernetes.io/pvc-protection" ]`                               |
| `store.persistence.size`                                   | store service: Size of persistent volume claim                           | `5Gi`                                                              |
| `store.persistence.storageClassName`                       | store service: Type of persistent volume claim                           | `nil`                                                              |
| `thumbnails.persistence.accessModes`                       | thumbnails service: Persistence access modes                             | `[ReadWriteMany]`                                                   |
| `thumbnails.persistence.annotations`                       | thumbnails service: PersistentVolumeClaim annotations                    | `{}`                                                               |
| `thumbnails.persistence.enabled`                           | thumbnails service: Use persistent volume to store data                  | `false`                                                            |
| `thumbnails.persistence.existingClaim`                     | thumbnails service: Use an existing PVC to persist data                  | `nil`                                                              |
| `thumbnails.persistence.finalizers`                        | thumbnails service: PersistentVolumeClaim finalizers                     | `[ "kubernetes.io/pvc-protection" ]`                               |
| `thumbnails.persistence.size`                              | thumbnails service: Size of persistent volume claim                      | `10Gi`                                                             |
| `thumbnails.persistence.storageClassName`                  | thumbnails service: Type of persistent volume claim                      | `nil`                                                              |
| -----------------------------------                        | ----------------------------------------------------------------         | ------------------------------------                               |



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
