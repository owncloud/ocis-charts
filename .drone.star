config = {
    "branches": [
        "master",
    ],
    # if this changes, also the kubeVersion in the Chart.yaml needs to be changed
    "kubernetesVersions": [
        "1.20.0",
        "1.21.0",
        "1.22.0",
        "1.23.0",
        "1.24.0",
    ],
}

def main(ctx):
    return linting(ctx)

def linting(ctx):
    pipelines = []

    kubeconform_steps = []

    for version in config["kubernetesVersions"]:
        kubeconform_steps.append(
            {
                "name": "kubeconform-%s" % version,
                "image": "ghcr.io/yannh/kubeconform:master",
                "entrypoint": [
                    "/kubeconform",
                    "-kubernetes-version",
                    "%s" % version,
                    "-summary",
                    "-strict",
                    "ocis-ci-templated.yaml",
                ],
            },
        )

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "lint charts/ocis",
        "steps": [
            {
                "name": "helm lint",
                "image": "alpine/helm:latest",
                "commands": [
                    "helm lint charts/ocis",
                ],
            },
            {
                "name": "helm template",
                "image": "alpine/helm:latest",
                "commands": [
                    "helm template charts/ocis -f charts/ocis/values-ci-testing.yaml > ocis-ci-templated.yaml",
                ],
            },
            {
                "name": "kube-linter",
                "image": "stackrox/kube-linter:latest",
                "entrypoint": [
                    "/kube-linter",
                    "lint",
                    "ocis-ci-templated.yaml",
                ],
            },
        ] + kubeconform_steps,
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/pull/**",
                "refs/tags/**",
            ],
        },
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    pipelines.append(result)

    return pipelines
