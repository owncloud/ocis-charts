# agents.md -- ownCloud Infinite Scale Helm Charts

## Repository Overview

Kubernetes Helm charts for deploying oCIS. Licensed under Apache-2.0. Uses Helm, Helmfile, and KubeLinter for chart management and validation.

- **Product family:** oCIS
- **Primary language(s):** Mustache (Helm templates), YAML

## Architecture & Key Paths

- `charts/ocis/` -- Main oCIS Helm chart
- `ci/` -- CI configuration
- `deployments/` -- Example deployment configurations
- `Makefile` -- Build, lint, and documentation automation
- `renovate.json` -- Renovate bot configuration

## Development Conventions

- Helm chart conventions
- KubeLinter for Kubernetes manifest validation
- Helmfile for deployment examples
- Helm-docs for chart documentation generation

## Build & Test Commands

```bash
make docs                     # Generate chart documentation
make lint                     # Run all linting (CI + examples)
make lint-ci                  # Run CI-focused linting
make lint-examples            # Lint example deployments
make schema                   # Generate values schema
make clean                    # Clean generated files
```

## Important Constraints

- Licensed under Apache-2.0 (already at the OSPO target license). The broader ownCloud organization is migrating other repositories from copyleft licenses to Apache 2.0.
- `main` branch targets oCIS 6; `stable-5` targets oCIS 5.
- All contributions require a DCO sign-off.


## OSPO Policy Constraints

### GitHub Actions
- **Only** use actions owned by `owncloud`, created by GitHub (`actions/*`), verified on the GitHub Marketplace, or verified by the ownCloud Maintainers.
- Pin all actions to their full commit SHA (not tags): `uses: actions/checkout@<SHA> # vX.Y.Z`
- Never introduce actions from unverified third parties.

### Dependency Management
- Dependabot is configured for automated dependency updates.
- Review and merge Dependabot PRs as part of regular maintenance.
- Do not introduce new dependencies without discussion in an issue first.

### Git Workflow
- **Rebase policy**: Always rebase; never create merge commits. Use `git pull --rebase` and `git rebase` before pushing.
- **Signed commits**: All commits **must** be PGP/GPG signed (`git commit -S -s`).
- **DCO sign-off**: Every commit needs a `Signed-off-by` line (`git commit -s`).
- **Conventional Commits & Squash Merge**: Use the [Conventional Commits](https://www.conventionalcommits.org/) format where the repository enforces it. Many repos use squash merge, where the PR title becomes the commit message on the default branch — apply Conventional Commits format to PR titles as well. A reusable GitHub Actions workflow enforces this.

## Context for AI Agents

The main Helm chart is in `charts/ocis/`. Values schema is auto-generated. Example deployments in `deployments/` show various configurations. Chart versioning follows the oCIS release cadence.
