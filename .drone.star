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
                "name": "kube-linter",
                "image": "archlinux:latest",
                "commands": [
                    "pacman -Sy",
                    "pacman --noconfirm -S kube-linter",
                    "kube-linter lint charts/**",
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
