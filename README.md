# ownCloud Infinite Scale Community Kubernetes Helm Charts

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

The code is provided as-is with no warranties.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.


This chart repository and it's charts are still in an experimental phase, and it has not yet been published.
For instructions on how to run it anyways the the respective chart's readme.

[//]: # (Once Helm is set up properly, add the repo as follows:)



<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
Chart documentation is available in [oCIS directory](https://github.com/owncloud/ocis-charts/blob/master/charts/ocis/README.md).

## Changes

**Attention** Version 0.2.0 introduces some changes to the value names to align the service/app names at various places (values file, YAML files, directories)
The following changes have been done in detail between 0.1.0 and 0.2.0:

`configRefs.storageUsersConfigRef` -> `configRefs.storageusersConfigRef` \
`secretRefs.storageSystemJwtSecretRef` -> `secretRefs.storagesystemJwtSecretRef` \
`secretRefs.storageSystemSecretRef` -> `secretRefs.storagesystemSecretRef` \
`services.appProvider` -> `services.appprovider` \
`services.appRegistry` -> `services.appregistry` \
`services.authBasic` -> `services.authbasic` \
`services.authMachine` -> `services.authmachine` \
`services.storagePublicLink` -> `services.storagepubliclink` \
`services.storageShares` -> `services.storageshares` \
`services.storageSystem` -> `services.storagesystem` \
`services.storageUsers` -> `services.storageusers`

## Contributing

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
We'd love to have you contribute! Please refer to our [contribution guidelines](https://github.com/owncloud/ocis/blob/master/CONTRIBUTING.md) for details.

## License

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
[Apache 2.0 License](https://github.com/owncloud/ocis-charts/blob/main/LICENSE).
