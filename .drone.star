config = {
    "branches": [
        "master",
    ],
}

def main(ctx):
    return linting(ctx)

def linting(ctx):
    pipelines = []

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "lint ocis",
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
                "name": "kubeconform",
                "image": "ghcr.io/yannh/kubeconform:latest",
                "entrypoint": [
                    "/kubeconform",
                    "-summary",
                    "-strict",
                    "ocis-ci-templated.yaml",
                ],
            },
            {
                "name": "kube-linter",
                "image": "stackrox/kube-linter:latest",
                "entrypoint": [
                    "/kube-linter",
                    "lint",
                    "/drone/src/charts/ocis",
                ],
            },
        ],
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
