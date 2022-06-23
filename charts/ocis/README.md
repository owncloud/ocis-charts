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

| Parameter                                                  | Description                                                                      | Default                                                            |
| ---------------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| `autoscaling.enabled`                                      | Enables autoscaling. Mutual exclusive with `replicas`                            | `false`                                                            |
| `autoscaling.maxReplicas`                                  | Sets maximum replicas for autoscaling                                            | `10`                                                               |
| `autoscaling.metrics`                                      | Metrics to use for autoscaling                                                   | `[]`                                                               |
| `autoscaling.minReplicas`                                  | Sets minimum replicas for autoscaling                                            | `1`                                                                |
| `deploymentStrategy`                                       | Deployment strategy                                                              | `{ "type": "RollingUpdate" }`                                      |
| `externalDomain`                                           | Domain where oCIS is reachable for the outside world                             | `ocis.owncloud.test`                                               |
| `extraLabels`                                              | Custom labels for all manifests                                                  | `{}`                                                               |
| `extraResources`                                           | Extra resources to be included                                                   | `[]`                                                               |
| `features.basicAuthentication`                             | Enable basic authentication. Not recommended for production instances            | `false`                                                            |
| `features.demoUsers`                                       | Create demo users on the first startup                                           | `false`                                                            |
| `idm.persistence.accessModes`                              | idm service: Persistence access modes                                            | `[ReadWriteMany]`                                                  |
| `idm.persistence.annotations`                              | idm service: PersistentVolumeClaim annotations                                   | `{}`                                                               |
| `idm.persistence.enabled`                                  | idm service: Use persistent volume to store data                                 | `false`                                                            |
| `idm.persistence.existingClaim`                            | idm service: Use an existing PVC to persist data                                 | `nil`                                                              |
| `idm.persistence.finalizers`                               | idm service: PersistentVolumeClaim finalizers                                    | `[ "kubernetes.io/pvc-protection" ]`                               |
| `idm.persistence.size`                                     | idm service: Size of persistent volume claim                                     | `10Gi`                                                             |
| `idm.persistence.storageClassName`                         | idm service: Type of persistent volume claim                                     | `nil`                                                              |
| `image.pullPolicy`                                         | Image pull policy                                                                | `IfNotPresent`                                                     |
| `image.repository`                                         | Image repository                                                                 | `owncloud/ocis`                                                    |
| `image.sha`                                                | Image sha (optional)                                                             | `6cc24c065d2832c26fa628daa917e1a1543b63a24fab48daf56c0521a688ffe9` |
| `image.tag`                                                | Image tag                                                                        | `latest`                                                           |
| `ingress.annotations`                                      | Ingress annotations (values are templated)                                       | `{}`                                                               |
| `ingress.enabled`                                          | Enables Ingress                                                                  | `false`                                                            |
| `ingress.ingressClassName`                                 | Name of the ingress class                                                        | empty (default ingress)                                            |
| `ingress.labels`                                           | Custom labels                                                                    | `{}`                                                               |
| `ingress.tls`                                              | Ingress TLS configuration                                                        | `[]`                                                               |
| `logging.color`                                            | Log in color                                                                     | `false`                                                            |
| `logging.level`                                            | Log level                                                                        | `error`                                                            |
| `logging.pretty`                                           | Log json or human friendly                                                       | `false`                                                            |
| `namespaceOverride`                                        | Override the namespace of all resources in this Helm chart                       | ``                                                                 |
| `nats.persistence.accessModes`                             | nats service: Persistence access modes                                           | `[ReadWriteMany]`                                                  |
| `nats.persistence.annotations`                             | nats service: PersistentVolumeClaim annotations                                  | `{}`                                                               |
| `nats.persistence.enabled`                                 | nats service: Use persistent volume to store data                                | `false`                                                            |
| `nats.persistence.existingClaim`                           | nats service: Use an existing PVC to persist data                                | `nil`                                                              |
| `nats.persistence.finalizers`                              | nats service: PersistentVolumeClaim finalizers                                   | `[ "kubernetes.io/pvc-protection" ]`                               |
| `nats.persistence.size`                                    | nats service: Size of persistent volume claim                                    | `10Gi`                                                             |
| `nats.persistence.storageClassName`                        | nats service: Type of persistent volume claim                                    | `nil`                                                              |
| `replicas`                                                 | Number of replicas for each service. Mutual exclusive with `autoscaling`         | `1`                                                                |
| `resources`                                                | CPU/Memory resource requests/limits                                              | `{}`                                                               |
| `search.persistence.accessModes`                           | search service: Persistence access modes                                         | `[ReadWriteMany]`                                                  |
| `search.persistence.annotations`                           | search service: PersistentVolumeClaim annotations                                | `{}`                                                               |
| `search.persistence.enabled`                               | search service: Use persistent volume to store data                              | `false`                                                            |
| `search.persistence.existingClaim`                         | search service: Use an existing PVC to persist data                              | `nil`                                                              |
| `search.persistence.finalizers`                            | search service: PersistentVolumeClaim finalizers                                 | `[ "kubernetes.io/pvc-protection" ]`                               |
| `search.persistence.size`                                  | search service: Size of persistent volume claim                                  | `10Gi`                                                             |
| `search.persistence.storageClassName`                      | search service: Type of persistent volume claim                                  | `nil`                                                              |
| `secretRefs.adminUserSecretRef`                            | Reference to an existing admin user secret (see Secrets section below)           | `admin-user`                                                       |
| `secretRefs.idpSecretRef`                                  | Reference to an existing idp secret (see Secrets section below)                  | `idp-secrets`                                                      |
| `secretRefs.jwtSecretRef`                                  | Reference to an existing JWT secret (see Secrets section below)                  | `jwt-secret`                                                       |
| `secretRefs.ldapCaRef`                                     | Reference to an existing ldap ca secret (see Secrets section below)              | `ldap-ca`                                                          |
| `secretRefs.ldapCertRef`                                   | Reference to an existing ldap cert secret (see Secrets section below)            | `ldap-cert`                                                        |
| `secretRefs.ldapSecretRef`                                 | Reference to an existing ldap secret (see Secrets section below)                 | `ldap-bind-secrets`                                                |
| `secretRefs.machineAuthApiKeySecretRef`                    | Reference to an existing machine auth api key secret (see Secrets section below) | `machine-auth-api-key`                                             |
| `secretRefs.storageSystemJwtSecretRef`                     | Reference to an existing storage system jwt secret (see Secrets section below)   | `storage-system-jwt-secret`                                        |
| `secretRefs.storageSystemSecretRef`                        | Reference to an existing storage system secret (see Secrets section below)       | `storage-system`                                                   |
| `secretRefs.thumbnailsSecretRef`                           | Reference to an existing thumbnails secret (see Secrets section below)           | `thumbnails-transfer-secret`                                       |
| `secretRefs.transferSecretSecretRef`                       | Reference to an existing transfer secret (see Secrets section below)             | `transfer-secret`                                                  |
| `storageSharing.persistence.accessModes`                   | sharing service: Persistence access modes                                        | `[ReadWriteMany]`                                                  |
| `storageSharing.persistence.annotations`                   | sharing service: PersistentVolumeClaim annotations                               | `{}`                                                               |
| `storageSharing.persistence.enabled`                       | sharing service: Use persistent volume to store data                             | `false`                                                            |
| `storageSharing.persistence.existingClaim`                 | sharing service: Use an existing PVC to persist data                             | `nil`                                                              |
| `storageSharing.persistence.finalizers`                    | sharing service: PersistentVolumeClaim finalizers                                | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageSharing.persistence.size`                          | sharing service: Size of persistent volume claim                                 | `5Gi`                                                              |
| `storageSharing.persistence.storageClassName`              | sharing service: Type of persistent volume claim                                 | `nil`                                                              |
| `storageSystem.persistence.accessModes`                    | system storage service: Persistence access modes                                 | `[ReadWriteMany]`                                                  |
| `storageSystem.persistence.annotations`                    | system storage service: PersistentVolumeClaim annotations                        | `{}`                                                               |
| `storageSystem.persistence.enabled`                        | system storage service: Use persistent volume to store data                      | `false`                                                            |
| `storageSystem.persistence.existingClaim`                  | system storage service: Use an existing PVC to persist data                      | `nil`                                                              |
| `storageSystem.persistence.finalizers`                     | system storage service: PersistentVolumeClaim finalizers                         | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageSystem.persistence.size`                           | system storage service: Size of persistent volume claim                          | `5Gi`                                                              |
| `storageSystem.persistence.storageClassName`               | system storage service: Type of persistent volume claim                          | `nil`                                                              |
| `storageUsers.persistence.accessModes`                     | users storage service: Persistence access modes                                  | `[ReadWriteMany]`                                                  |
| `storageUsers.persistence.annotations`                     | users storage service: PersistentVolumeClaim annotations                         | `{}`                                                               |
| `storageUsers.persistence.enabled`                         | users storage service: Use persistent volume to store data                       | `false`                                                            |
| `storageUsers.persistence.existingClaim`                   | users storage service: Use an existing PVC to persist data                       | `nil`                                                              |
| `storageUsers.persistence.finalizers`                      | users storage service: PersistentVolumeClaim finalizers                          | `[ "kubernetes.io/pvc-protection" ]`                               |
| `storageUsers.persistence.size`                            | users storage service: Size of persistent volume claim                           | `50Gi`                                                             |
| `storageUsers.persistence.storageClassName`                | users storage service: Type of persistent volume claim                           | `nil`                                                              |
| `storageUsers.storageBackend.driver:`                      | users storage: Storage backend driver                                            | `ocis`                                                             |
| `storageUsers.storageBackend.driverConfig.s3ng.accessKey:` | users storage: S3ng Storage backend driver S3 access key                         | `""`                                                               |
| `storageUsers.storageBackend.driverConfig.s3ng.bucket:`    | users storage: S3ng Storage backend driver S3 bucket                             | `""`                                                               |
| `storageUsers.storageBackend.driverConfig.s3ng.endpoint:`  | users storage: S3ng Storage backend driver S3 endpoint                           | `""`                                                               |
| `storageUsers.storageBackend.driverConfig.s3ng.region:`    | users storage: S3ng Storage backend driver S3 region                             | `""`                                                               | ` |
| `storageUsers.storageBackend.driverConfig.s3ng.secretKey:` | users storage: S3ng Storage backend driver S3 secret key                         | `""`                                                               |
| `store.persistence.accessModes`                            | store service: Persistence access modes                                          | `[ReadWriteMany]`                                                  |
| `store.persistence.annotations`                            | store service: PersistentVolumeClaim annotations                                 | `{}`                                                               |
| `store.persistence.enabled`                                | store service: Use persistent volume to store data                               | `false`                                                            |
| `store.persistence.existingClaim`                          | store service: Use an existing PVC to persist data                               | `nil`                                                              |
| `store.persistence.finalizers`                             | store service: PersistentVolumeClaim finalizers                                  | `[ "kubernetes.io/pvc-protection" ]`                               |
| `store.persistence.size`                                   | store service: Size of persistent volume claim                                   | `5Gi`                                                              |
| `store.persistence.storageClassName`                       | store service: Type of persistent volume claim                                   | `nil`                                                              |
| `thumbnails.persistence.accessModes`                       | thumbnails service: Persistence access modes                                     | `[ReadWriteMany]`                                                  |
| `thumbnails.persistence.annotations`                       | thumbnails service: PersistentVolumeClaim annotations                            | `{}`                                                               |
| `thumbnails.persistence.enabled`                           | thumbnails service: Use persistent volume to store data                          | `false`                                                            |
| `thumbnails.persistence.existingClaim`                     | thumbnails service: Use an existing PVC to persist data                          | `nil`                                                              |
| `thumbnails.persistence.finalizers`                        | thumbnails service: PersistentVolumeClaim finalizers                             | `[ "kubernetes.io/pvc-protection" ]`                               |
| `thumbnails.persistence.size`                              | thumbnails service: Size of persistent volume claim                              | `10Gi`                                                             |
| `thumbnails.persistence.storageClassName`                  | thumbnails service: Type of persistent volume claim                              | `nil`                                                              |


### Secrets

oCIS needs some secrets to work.
We decided against creating them automagically for you, because Helm does not support one-off generation of secrets out of the box.
Also oCIS needs to have some certificates, which should have an expiry and therefore need a certificate rotation from time to time.
This is also not supported by Helm.
These reasons add up and as a result the responsibility about these secrets (and there lifecycle) lies at the operator, you.

We'll give you all information, you need to generate and maintain these secrets.

#### Static secrets (recommended)

This is is an example of how the secrets look like, that you need to generate.
The example assumes, that you don't change the `secretRefs`.
Each secret data entry holds a description on how to generate it or find the right value.

```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: jwt-secret
type: Opaque
data:
    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    jwt-secret: U1ZjTGVZMVdBUjJwRk1ocE90MzZwT050YVdrRDJVQzM=

---
apiVersion: v1
kind: Secret
metadata:
  name: ldap-bind-secrets
type: Opaque
data:
    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    reva-ldap-bind-password: eFhZM09va2FXOGtuZU1saGNNY1FRYldoVjlmaFFNSWM=

    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    idp-ldap-bind-password: Ymg0UFRIRTZrZ0o3YndOZktBam5kbG9qbTc4WkFYa0o=

    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    graph-ldap-bind-password: M3BuMzJGSUJWQkpGSEcxRml0UTlhTUVVMldmbDM4VUc=

---
apiVersion: v1
kind: Secret
metadata:
  name: ldap-ca
type: Opaque
data:
    # how to generate: base64 encode the pem-encoded certificate of a (self-signed) x509 certificate authority
    ldap-ca-cert: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURFRENDQWZpZ0F3SUJBZ0lSQU1ZR2ZacjF4K3d0bWtlQjlVVHZTb1V3RFFZSktvWklodmNOQVFFTEJRQXcKRWpFUU1BNEdBMVVFQXhNSGJHUmhjQzFqWVRBZUZ3MHlNakEyTWpFeE16RTRNemxhRncwek1qQTJNVGd4TXpFNApNemxhTUJJeEVEQU9CZ05WQkFNVEIyeGtZWEF0WTJFd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3CmdnRUtBb0lCQVFEUnpIdjFuVnFVYVV0dXlHcWVGQmRNVU9VRmN6a1owQnNqN0JFSGYxTzRCZEVmbGVTMUlTVmkKT1lPNjhLU3YrVHVqNEdDeHZIYmNwclppQXBsZFFSbzZLa3FMankzNUhNbFU3bGJsVzhlNnZQa1Y2SVFYTFdrbApxSXJPVEx3d3NHWDcrS0FGTFd6T3hJU1R4UmFFRHhCNS82OHAyTGdvdVE5UHA1ZEtzaURJZVE3aVdIaWtBRzR4CmhUdURWV1k0ZHF6OWRRV3RHank3VTdLbWFvdVh1cmErMTZZSUNka1A4VlV1UzhSZ2g0U1dQZlhYd2ptVHBWVkgKblhRSmtuNmpCSDNITlR4RXptSUJGcTYzRjMyVEpDVTVmellIWUJIdjU5L2NUcU1OTGJRWFhEcVlVai81Q2pFNworcXNoVzVlZjNQYXZuWm1zNC9wbU1YMmt0eGRvdkFKdkFnTUJBQUdqWVRCZk1BNEdBMVVkRHdFQi93UUVBd0lDCnBEQWRCZ05WSFNVRUZqQVVCZ2dyQmdFRkJRY0RBUVlJS3dZQkJRVUhBd0l3RHdZRFZSMFRBUUgvQkFVd0F3RUIKL3pBZEJnTlZIUTRFRmdRVUNsZ1BBQUpKMk9kWVQzUEVtbUs0ZEpJbGtOTXdEUVlKS29aSWh2Y05BUUVMQlFBRApnZ0VCQUhpTVR6bGJGQlY1cHR4bWljMXVVOEd2VnF3OFhlZFdySDkrYmRMcVhuOWpDUTZDeVJTRHAwK1g5UHVFCmMvWXdrZ29IYkxYQVZKM0Fmd1NWR2xCajFuK21FQ2p4TTlVOW05b21adXFwN28vVTNQVm96NURWcmVKZmhtTisKYzFVNUxYSk1kZ09uaHhsRS85QUwxb21sclltSHJVRmFkcVlpVjh2N2hwbzhrK0VBWU9ZckFkVHFpejBWSTN0bwp2ZVFSL2MxbEdFTSt4dXh0OXIzenU5M3hHRitxQzlhOEpiaUN6dlQ3REsyaXM5QnU2ZmVGaEhkRWdJd0NvM255ClpTZkpzUkVKS0lRdVNkKzNEWW9XZmYyRVBsVGpESVZkVEtnWTcvamhJY2MrZ1FvL3lBVitUUXRZOUpLT1lYRmkKb2FobUhPYkM1QXVGelo1SlBmSkVoMXY1OCtFPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==

---
apiVersion: v1
kind: Secret
metadata:
  name: ldap-cert
type: Opaque
data:
    # how to generate: base64 encode a private key (eg. ed25519, ensure that you use reasonable long key size)
    ldap-cert-key: LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1DNENBUUF3QlFZREsyVndCQ0lFSUNjUUJKa2dBYmJ4OWxvQ3VBYjhEK3E3VEFNd3prcGpSeisyRkpTWWpZN2QKLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLQo=

    # how to generate: base64 encode a x509 certificate signed by the above CA, using the above private key.
    ldap-cert-cert: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUNJVENDQVFtZ0F3SUJBZ0lSQUtYVklwcy85YThMRW9QTzdYbk1QcU13RFFZSktvWklodmNOQVFFTEJRQXcKRWpFUU1BNEdBMVVFQXhNSGJHUmhjQzFqWVRBZUZ3MHlNakEyTWpFeE16RTRNemxhRncwek1qQTJNVGd4TXpFNApNemxhTUE0eEREQUtCZ05WQkFNVEEybGtiVEFxTUFVR0F5dGxjQU1oQUhZemtTcVE2aVRwVTlkSllidkVrL01ZCkc5YTQ5aFVIVzNtZlJkYW9ubFcybzNBd2JqQU9CZ05WSFE4QkFmOEVCQU1DQmFBd0hRWURWUjBsQkJZd0ZBWUkKS3dZQkJRVUhBd0VHQ0NzR0FRVUZCd01DTUF3R0ExVWRFd0VCL3dRQ01BQXdId1lEVlIwakJCZ3dGb0FVQ2xnUApBQUpKMk9kWVQzUEVtbUs0ZEpJbGtOTXdEZ1lEVlIwUkJBY3dCWUlEYVdSdE1BMEdDU3FHU0liM0RRRUJDd1VBCkE0SUJBUUN2SG5yN1dFa2FaWGVoN1FlQ3o2T0xPK3QveDcydk1GR01oemNqaGJlWisxTGFuOUs3SFZPR0dobEoKV3JPR2phV2hFcXprNVRJc3ZKOElleGZqK2hjV25jL29QSGY4cklWdDcrQmliNndnMzNrR2xuSjlSbWYxdjFpOQowRWF0MDV5UUl2MEEzak5pYmpsaW0vMmgxK0FjUk91MEozaVp5R25mZXd3UGFUc2htZjBBT2o1bGczbTRtcS95CmYwQnRZenI1WGtmVVllNWQxZmYvczZOSm5yMERWaGU2TVB2cUlQc1RvZjFMcTZsNFc4cHl1ZlN2ditpTkNkS1QKRzlxMWNuZ2Fqd0FxVDQrWHJMZGlMV1FRWlpxdzV0R29DRVVWS3YxYWlsVlRZM3R5M2kvbjVEY044MDZPRE01OQp4bTZZbmN6TWVnMzY5VEVwU2tFM1FtRklTVGs3Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K


---
apiVersion: v1
kind: Secret
metadata:
  name: machine-auth-api-key
type: Opaque
data:
    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    machine-auth-api-key: OFZkWFU2VXIwVG1hN3ZYb2xkajFiRHU5TEVBMDl4T00=

---
apiVersion: v1
kind: Secret
metadata:
  name: storage-system
type: Opaque
data:
    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    api-key: dkphNms4SXVSd3RuMXNhSkJNbWNrSzlwNlZMT0txWXc=

    # how to generate: base64 encode a UUID V4
    user-id: YWMwZDRlZDAtZDYxOC00MzBmLTkwYjUtNzQwNjk1MjdmNDA4

---
apiVersion: v1
kind: Secret
metadata:
  name: storage-system-jwt-secret
type: Opaque
data:
    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    storage-system-jwt-secret: aGJRbzU2OFh0dDI3bWpVUHZuYUZWcFVxTUk2cE5PMHY=

---
apiVersion: v1
kind: Secret
metadata:
  name: transfer-secret
type: Opaque
data:
    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    transfer-secret: ajFZRGVObW05UmNETEx0eU9YeU1jeWlic0pGbUY4NEo=

---
apiVersion: v1
kind: Secret
metadata:
  name: admin-user
type: Opaque
data:
    # how to generate: base64 encode a UUID V4
    user-id: NTczY2ZkNWMtOGM0YS00ZjczLWIyNDgtOWEyM2RlOTNmYjI0
    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    password: clBjODhrekdpYzd0alZQWWVFMnd5R1BFMXJFdmtuc1Y=

---
apiVersion: v1
kind: Secret
metadata:
  name: idp-secrets
type: Opaque
data:
  # how to generate: base64 encode a random string (reasonable long and mixed characters)
  encryption.key: UnFQV25HeFVrMGk1Q0I1YzRrNDFWVGlvSVFmUzNJa2k=

  # how to generate: base64 encode a private key (eg. RSA, ensure that you use reasonable long key size)
  private-key.pem: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKS0FJQkFBS0NBZ0VBd3pKb2VVQ2p2WnhwRzZTbVZqaWY3SktHUFVYeUJZRk1HZFJvNE9uWWFXd3RHSGxNClBkVUl5U0E2Q1J0eERWdjhLekVKOGN5RmpHVlN4NTRqWUpNbkNicVlzOEhIaDF4MEVUV3pBTkkxVDZpbG8ySUoKYlRqd05tZnRQNXk1WTRPYkpZSzgwdWdNMnFWOTc3Mm82SUJSSzdBTGZJMjdIMzFRMUVlNGtsWHNVdkJpYVQ5ZgpmU3ZRamNKR29UU0pBM3FBeDhvN001QWE0alMzaVRTMXJsaDlzMW54RHI2TCtvRjlwWFFITUZ5bzBVOENHNlp5CnA2Tm1zVzNJZitTUC9jTU9DNXdjbzlQUlJSZVlTZGVmenNWOWlEelFqS1hZd3NTQmgrY3ZveE1WVnhXZEpPYXcKOVVTV0JwTC96elB4WnF1RTZML2ZCNUtVY0E1aXFnOVdtZWZUdyt5czZDSDViZjRlQWNrK0FLbDUrTzJwSnUySgpTT2FOM2J4Tk12NklFNktVNFVYVDFNT29KdHRtRDNsM1kxUkYydWRTNHBVejRtQnRXa0FRQ1AwNi9jOXh4MjFMCmtJTHBNSDZLUG9rYzFIMVZFVE9YVUpuRFFQSUoxbi9laGRNT0VzOS9vWXNyeTZJWFhScTQzZ1hRQnB5bUlQbGEKVlJtdXRLaHltQ05pWUJuWGk3bCtJYTM0MmdTRzcydm8zTWc5NFo5SnkyMjdOSFJpTjc0L0szSGhmZ0tySVV6Ngpyckp2SXU5dGRpTnJ3NHRWZC9jZXRYcGphUU1kVXpDUnhvdFVsc3BOOFNsQWhsVDJYSnhFeWZEclRQV2grdmJ1CnFXdGwzd1p0V2Q2NUsrdDBJNGo2SDZGdzhaVm55OFNTMlA4WlhmRmFtSkMxZzhldHFVN1pCVFVHcDNrQ0F3RUEKQVFLQ0FnQm9jUDVKY25hcUs1aHB2QTFzTU53US9zMW8xNVlKc0FjQ0F3OGkyTHg4bSs3OUcxblo4N1RCdU1hVQp2T1FlbThzdmFRdkRId1dOKzJEeGdnRzMyTVNZaGdqU2xhcW5HS2JaMW51eXdzYlhtb3NXQW95OHJpeUpUODQzCnJTbmN2end5TStQSWpYVGpRSTFEeTUwbTJoR1VhSnVjeDFFS0pra3JiRHlyditHMDl2NFJCbUdYWGV3M0RXNHgKTHlUb2daR0tWUUNjTkV6T0lCcmNCU0g0NlV4SXZLVW9tSGZaVDVQbEJWSWJaRmpIdFppUkp0eE9LalgyVmFGawpITzJXZjlseUNOT2lMT0hhTUNmQnl1ZXRBU3FMek01aGt4T0tFdzZqb3VWd1FmTzNKczl3UVNjSjlPcTVGY3BlCkdaTGV0b05rN2RUdC9sWUNKeEJQb2VsYWJCcDMyV0ZoQVovRXVYbWcvUHJ4QzlDdjd3MitqM2dOcjFHVkpnSHAKRHRkUkFPY2FDdmNkUmdMeHNEUFZ2RDdHYVdidlJxc0xmWnlYaStNQ1FyQ2s4WnZNT1hPOXlWU1Z3QmpoYmh6dAp0OHJ3TG5GSDhjNWV3NG9SYUIzMkNudFYxVGNzM2pQQ3RLVFM2M0tmRVhJMUE4V0k3d0hsYU1kSEd1Z2VOdHJECm5QZU5FT3JaeHI1VnFhZ0ZxZ0xKRWRtMnV4dEZjaE1vUEtpamZ1bnZUekFwbFFSSDJxZWZmV3V0TDBTMDA1VGEKcW5ZTkRMTmQyb2V0R0pmUzJndHlPNURMa3VnQTh4bTZ4c0o0NHB2c2xRUVhJYTNpdGtYTm9SOWd6VTFJTjFjVgp6NncySjIzWFFIUm1NOStmZS9XOW9uQkdJeUJUSFRVaEpacy9NSkFtTi9MZlRSaFRTUUtDQVFFQTN5QUdmbU1BCkJvcVZsbSszOHNVUzBWR2FrNU1wTlNqVElNTE9USnhmVlFjTUV6QjhBdTB1U29WYmpOaVlQdExjMms2eHNvSDMKb01KMklFeE1xWllXOVBBNHRqbzlXeEhjcGVqUGx0d0pzMVJOWkNJZThlZi9lRUtIYkRieUEwWTFUeUZkblNLWAp5Ly9ZckhraVpXSFpUNDJ4dFNZS3oyZGNHTjlpTUUvMHJpY3owcWF2dHoySDVyZmdSMmlVbG9peUNkSnZGWG5iClN0U0ZROFFwQVBIMlFGS2dLUTFqYW50ZG1zcndtbWxScUlxeTdDTDgxc09sU3l2NW0rQ1NaWGg0Y2ZIMW1CWnIKZjN1UUpzK0RIWTZtWjFpNHRoa0N2SWZlU2cyb2pxS0hCVGEyM0xlczZULzlVTE5tUVpuQTlSSmIrd25HaStqbgp3ZmxzOWxXeWpxcXZ0d0tDQVFFQTMvVDRLVDFuakZRamJDVURsanhpUEd3OW9Od05janhuUVJDWkttZmZaMUw0CkdBTU9CRHEzdHQrRlJmMVF6SDRaVEoyNy9CMWpBNUtxdXNiM0ZGZmVMNTJrRGRNSFpvVE9ULzNRdlNFMTFYUkIKbXVDTkhnUS9vbll2TXhEa2N2dllKYndvY3AzbkU1Kzl3UHZWc0k5OXl1K01kcXpPMmdSWkkwV2h5M05xQUQyTApnVGV4Tnk3WllWWFpHWGk2b1pENHBSbDlCZkZjMkZVRHFxYzNRbFNFOHUxY2FUNkFLTHhxNTM2U2NwQUJhSnVJCkF1WFNpaGhCbjg0WjJzRk00bHpCTmpBYmdyTkl2d3Zzbmpna0d5WFY0R25LWnJQS3RxWWcwd29xZXpoQnlrZHIKMXFZZjVvSEtTeDdFbnhoazhueTBjdHhjSTZJKy9HRDVreEhkR04wQ1R3S0NBUUJjTGJ2aERQOWV0SFEyTVROYQpmV1pYeVpIRnMvOUxNZkYvVUZ1d05NNEJyNmFpYXQ1Z3l5SGJzWnB2NXErSEROQW05R25mS0dob0pzNXNhM2trCmVwaERXdGJqR2M1dFNFVFMyZ3FnOVlpZ2FJeU1lTGcyRWpWdHRuYUNFM1VLTzBBY3o5ai82T0d6YXFCV0tMazQKRHlPYkJSdk1qY25iZzRUOTFaT1lDQUE2em9GUFhvT3JmU1VmQVFvTUZqMkVyeloyYmxSc0YrcXIwSDY1ejFsdApSWWtKYTlrMC9JMzgyTGlFRWFFeStaMjl0b2RTbk9XOXlCZ0twVUU2ejUxTGhHaW1FbUwzRVJRYUY2OG5DWVhPCmVUZHY3S3hxdG94MTNOL04walMzc0pkOVpPeEk1U3p2TS90d0VwMkZMb01UL0NDNTVvRDdIaDVZK2JXMVV4UXcKY24yakFvSUJBRkxjbUZUcDJ6NFlnMktuNzBQTzQ2bm5nb1haNVQrM0NaMFJQeHBwaEViK2M3eXVwS2o3OEsxQQoxbGFtK3hZdU1iNGZQa1p4dVFqQlkxbm44OU1iRDZJZWVXeUQvK0Qya2o4V2NmMElKSnJ0Z0xpRkRMRm1jUVR6CkpWT0hsSDdXbjRxV3E0QjgyOXB1NkE1WEh5Rk1kZ1ozeTBpOWQydEM0SmdrVTFDclN6VDdrSG9tMlBMSjZyUVEKeDFxZFNMQXVxMUNxdFk5VlZqelVkNTdVYjZXakQrMngxTmM3d0w5UnQxd2ZnSi9TbURMVUdPYTVrY1IyWlJGegplQzF3QjdwWkIwTzlXUEJxMVNlYWlkbWdlL3R2YkVxejJhZFdMbEtWOU44Z2k4YzdjVndlUU5BU2R3c2FTbmF3CjA1N3ByNi9vWS90N2ZMdlNjK3Q5RmRwTWFibWhUQkVDZ2dFQkFNN0tseElISys3ZVArS0UvamVRaFpXamdwSkEKelVZazM4TElFQ3dJMDFZYkQ0TDFJRWg0ZXlhNWdTZldOWXYyTVJSZUdCOGw2SXBveU1ybzk0YVRremJ6UGhhQQpDTGQ3TEpxYktOcGRsSXpra3dvWGVWR0FJLzN4M3B1NXYzcWlWWWhuWHZOSWFFNTlBVDhaL29SVTlMWk5peXdXCktPYno2OWEzS2lFbDNYcHJ6dFUyMFZPYnp1RlJzTHB6RW5tUUkrc0tuTVlNa3hRZjVxM1VndEE3dWtSQk5XQ1UKMmtVOHg5YkZKSUNqWmdVS3ExcHQrNUhJQ3M0OG5tNDB3VE9QY2pxUDh6Q3NlS0Z2emYvQWpEdWhmdlNNdTE1WQptb2g2YUx6VHpUa3NPZ2FlOUhzRzRwNVA1cEhOcnRyb2pDQW5xLzlKZXQyZmYwekNoa29PSWZaUXZkUT0KLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K

---
apiVersion: v1
kind: Secret
metadata:
  name: thumbnails-transfer-secret
type: Opaque
data:
    # how to generate: base64 encode a random string (reasonable long and mixed characters)
    thumbnails-transfer-secret: ajZjMG1mNlU4M2JVSUJDeHJxdlZMWTNNWEFndGxQQ2M=
```

#### Auto generate secrets (not recommended)

If you want to give oCIS just a quick try, you could also decide to let Helm autogenerate all these secrets.
Please read the Secrets section, why you shouldn't do so for production deployments and instead go with static secrets.

Create a file `extra-resources.yaml` and paste following content:

```yaml
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: jwt-secret
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "jwt-secret") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $jwtSecret := (get $secretData "jwt-secret") | default (b64enc (randAlphaNum 32)) }}
      jwt-secret: {{ $jwtSecret }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: ldap-ca
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "ldap-ca") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $ldapCA := genCA "ldap-ca" 3650 }} # TODO: CA lifetime? how to rotate?
      {{- $ldapCaCert := (get $secretData "ldap-ca-cert") | default (b64enc $ldapCA.Cert) }}
      {{- $ldapCaKey := (get $secretData "ldap-ca-key") | default (b64enc $ldapCA.Key) }}
      {{- $ldapCA := buildCustomCert $ldapCaCert $ldapCaKey }}
      {{- $ldapCertKey := (get $secretData "ldap-cert-key") | default (b64enc (genPrivateKey "ed25519")) }}
      {{- $tmpLdapCert := genSignedCertWithKey "idm" nil (list "idm") 3650 $ldapCA (b64dec $ldapCertKey) }} # TODO: lifetime? how to rotate?
      {{- $ldapCert := (get $secretData "ldap-cert-cert") | default (b64enc $tmpLdapCert.Cert) }}
      ldap-ca-key: {{ $ldapCaKey }}
      ldap-ca-cert: {{ $ldapCaCert }}
      ldap-cert-cert: {{ $ldapCert }}
      ldap-cert-key: {{ $ldapCertKey }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: machine-auth-api-key
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "machine-auth-api-key") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $machineAuthApiKey := (get $secretData "machine-auth-api-key") | default (b64enc (randAlphaNum 32)) }}
      machine-auth-api-key: {{ $machineAuthApiKey }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: storage-system
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "storage-system") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $apiKey := (get $secretData "api-key") | default (b64enc (randAlphaNum 32)) }}
      {{- $userID := (get $secretData "user-id") | default (b64enc (uuidv4)) }}
      api-key: {{ $apiKey }}
      user-id: {{ $userID }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: storage-system-jwt-secret
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "storage-system-jwt-secret") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $jwtSecret := (get $secretData "storage-system-jwt-secret") | default (b64enc (randAlphaNum 32)) }}
      storage-system-jwt-secret: {{ $jwtSecret }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: ldap-bind-secrets
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "ldap-bind-secrets") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $revaLdapBindPassword := (get $secretData "reva-ldap-bind-password") | default (b64enc (randAlphaNum 32)) }}
      {{- $idpLdapBindPassword := (get $secretData "idp-ldap-bind-password") | default (b64enc (randAlphaNum 32)) }}
      {{- $graphLdapBindPassword := (get $secretData "graph-ldap-bind-password") | default (b64enc (randAlphaNum 32)) }}
      reva-ldap-bind-password: {{ $revaLdapBindPassword }}
      idp-ldap-bind-password: {{ $idpLdapBindPassword }}
      graph-ldap-bind-password: {{ $graphLdapBindPassword }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: transfer-secret
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "transfer-secret") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $transferSecret := (get $secretData "transfer-secret") | default (b64enc (randAlphaNum 32)) }}
      transfer-secret: {{ $transferSecret }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: admin-user
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "admin-user") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $userID := (get $secretData "user-id") | default (b64enc (uuidv4)) }}
      {{- $password := (get $secretData "password") | default (b64enc (randAlphaNum 32)) }}
      user-id: {{ $userID }}
      password: {{ $password }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: idp-secrets
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
    {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "idp-secrets") | default dict }}
    {{- $secretData := (get $secret "data") | default dict }}
    {{- $idpEncryptionKey := (get $secretData "encryption.key") | default (b64enc (randAlphaNum 32)) }}
    {{- $idpPrivateKey := (get $secretData "private-key.pem") | default (b64enc (genPrivateKey "rsa")) }} # TODO: use something stronger!?
    encryption.key: {{ $idpEncryptionKey }}
    private-key.pem: {{ $idpPrivateKey }}
- |
  apiVersion: v1
  kind: Secret
  metadata:
    name: thumbnails-transfer-secret
    annotations:
      "helm.sh/resource-policy": "keep"
  type: Opaque
  data:
      {{- $secret := (lookup "v1" "Secret" (include "ocis.namespace" .) "thumbnails-transfer-secret") | default dict }}
      {{- $secretData := (get $secret "data") | default dict }}
      {{- $transferSecret := (get $secretData "thumbnails-transfer-secret") | default (b64enc (randAlphaNum 32)) }}
      thumbnails-transfer-secret: {{ $transferSecret }}
```

You then need to invoke your `helm x` commands with following additional values set:

- `--set-file extraResources extra-resources.yaml` to include the autogenerated secrets (at least once to generate them, for subsequent deployments / upgrades you do not need to include them)
- `--set secretRefs.ldapCertRef=ldap-ca`, because we cannot generate the LDAP CA and certificate in different secrets, like we can when doing it manually. Also we need to store the CA key in the secret. This means that the private keys of the LDAP cert and CA are both available to all services using the LDAP CA cert. Therefore this is not recommended at all. You need to set this option always, also for subsequent deployments / upgrades.

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
