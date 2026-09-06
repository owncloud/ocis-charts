# ownCloud Infinite Scale Helm Charts

<!-- OSPO-managed README | Generated: 2026-04-16 | v2 -->

[![License](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](LICENSE) [![ownCloud OSPO](https://img.shields.io/badge/OSPO-ownCloud-blue)](https://kiteworks.com/opensource) [![Docker Hub](https://img.shields.io/docker/pulls/owncloud)](https://hub.docker.com/r/owncloud/ocis)

Community Kubernetes Helm charts for deploying ownCloud Infinite Scale (oCIS) on Kubernetes clusters. These charts provide production-ready templates for configuring oCIS services, persistent storage, ingress, TLS, and scaling -- enabling automated, repeatable deployments in cloud-native environments.

## Getting Started

Follow the steps below to deploy oCIS on Kubernetes using Helm.

### Prerequisites

- [Helm](https://helm.sh/) 3+
- Kubernetes cluster (1.28+)

### Installation

The official oCIS Helm chart repository is available at `https://owncloud.github.io/ocis-charts/`.

```bash
helm repo add owncloud https://owncloud.github.io/ocis-charts/
helm repo update
helm install ocis owncloud/ocis
```

Chart documentation: [charts/ocis/README.md](https://github.com/owncloud/ocis-charts/blob/master/charts/ocis/README.md)

### Development

```bash
make docs     # Generate chart docs
make lint     # Run linting
make schema   # Generate values schema
```

## Documentation

- [oCIS Helm Chart README](https://github.com/owncloud/ocis-charts/blob/master/charts/ocis/README.md)
- [Breaking Changes by Version](https://doc.owncloud.com/ocis/next/deployment/container/orchestration/tab-pages/breaking-changes.html)

## Part of ownCloud Infinite Scale

These Helm charts deploy [oCIS](https://github.com/owncloud/ocis) on Kubernetes. The `main` branch targets oCIS 6, while `stable-5` supports oCIS 5.

> **Note:** This chart repository is still in an experimental phase.

This component is part of the [oCIS Docker image](https://hub.docker.com/r/owncloud/ocis).

## Community & Support

**[Star](https://github.com/owncloud/ocis-charts)** this repo and **Watch** for release notifications!

- [ownCloud Website](https://owncloud.com)
- [Community Discussions](https://github.com/orgs/owncloud/discussions)
- [Matrix Chat](https://app.element.io/#/room/#owncloud:matrix.org)
- [Documentation](https://doc.owncloud.com)
- [Enterprise Support](https://owncloud.com/contact-us/)
- [OSPO Home](https://kiteworks.com/opensource)

## Contributing

We welcome contributions! Please read the [Contributing Guidelines](CONTRIBUTING.md)
and our [Code of Conduct](CODE_OF_CONDUCT.md) before getting started.

### Workflow

- **Rebase Early, Rebase Often!** We use a rebase workflow. Always rebase on the target branch before submitting a PR.
- **Dependabot**: Automated dependency updates are managed via Dependabot. Review and merge dependency PRs promptly.
- **Signed Commits**: All commits **must** be PGP/GPG signed. See [GitHub's signing guide](https://docs.github.com/en/authentication/managing-commit-signature-verification).
- **DCO Sign-off**: Every commit must carry a `Signed-off-by` line:
  ```
  git commit -s -S -m "your commit message"
  ```
- **GitHub Actions Policy**: Workflows may only use actions that are (a) owned by `owncloud`, (b) created by GitHub (`actions/*`), or (c) verified in the GitHub Marketplace.

## Security

**Do not open a public GitHub issue for security vulnerabilities.**

Report vulnerabilities at **<https://security.owncloud.com>** -- see [SECURITY.md](SECURITY.md).

Bug bounty: [YesWeHack ownCloud Program](https://yeswehack.com/programs/owncloud-bug-bounty-program)

## License

This project is licensed under the [Apache-2.0](LICENSE).

## About the ownCloud OSPO

The [Kiteworks Open Source Program Office](https://kiteworks.com/opensource), operating under
the [ownCloud](https://owncloud.com) brand, launched on May 5, 2026, to steward the open source
ecosystem around ownCloud's products. The OSPO ensures transparent governance, license compliance,
community health, and sustainable collaboration between the open source community and
[Kiteworks](https://www.kiteworks.com), which acquired ownCloud in 2023.

- **OSPO Home**: <https://kiteworks.com/opensource>
- **GitHub**: <https://github.com/owncloud>
- **ownCloud**: <https://owncloud.com>

For questions about the OSPO or licensing, contact ospo@kiteworks.com.

> **License status:** This repository is already licensed under Apache-2.0 -- the OSPO target license.
> No migration is required.
