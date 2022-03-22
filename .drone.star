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
        "name": "lint",
        "steps": [
            {
                "name": "helm lint",
                "image": "alpine/helm:latest",
                "commands": [
                    "helm lint charts/**",
                ],
            },
            {
                "name": "helm template",
                "image": "alpine/helm:latest",
                "commands": [
                    "helm template charts/** > charts-templated.yaml",
                ],
            },
            {
                "name": "kube-apply-dry-run",
                "image": "alpine/k8s:1.21.5",
                "commands": [
                    "kubectl apply --dry-run=client -f charts-templated.yaml",
                ],
            },
            {
                "name": "kube-linter",
                "image": "stackrox/kube-linter:latest",
                "entrypoint": [
                    "/kube-linter",
                    "lint",
                    "/drone/src/charts/",
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
