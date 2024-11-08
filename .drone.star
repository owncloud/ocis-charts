config = {
    "branches": [
        "main",
    ],
}

def main(ctx):
    pipeline_linting = linting(ctx)
    pipeline_checkstarlark = checkStarlark()

    pipeline_docs = documentation(ctx)
    pipeline_docs[0]["depends_on"].append(pipeline_checkstarlark[0]["name"])

    pipeline_deployments = deployments(ctx)
    for pipeline in pipeline_deployments:
        pipeline["depends_on"].append(pipeline_linting[0]["name"])

    return pipeline_checkstarlark + pipeline_linting + pipeline_deployments + pipeline_docs

def linting(ctx):
    pipelines = []

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "lint charts/ocis",
        "steps": [
            {
                "name": "lint",
                "image": "owncloudci/golang:latest",
                "commands": [
                    "make lint",
                ],
                "volumes": [
                    {
                        "name": "gopath",
                        "path": "/go",
                    },
                ],
            },
            {
                "name": "api",
                "image": "owncloudci/golang:latest",
                "commands": [
                    "make api",
                ],
                "volumes": [
                    {
                        "name": "gopath",
                        "path": "/go",
                    },
                ],
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
        },
        "volumes": [
            {
                "name": "gopath",
                "temp": {},
            },
        ],
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    pipelines.append(result)

    return pipelines

def documentation(ctx):
    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "documentation",
        "steps": [
            {
                "name": "generate docs",
                "image": "owncloudci/golang:latest",
                "commands": [
                    "make docs",
                ],
                "volumes": [
                    {
                        "name": "gopath",
                        "path": "/go",
                    },
                ],
            },
            {
                "name": "check-unchanged",
                "image": "owncloudci/alpine",
                "commands": [
                    "git diff --exit-code",
                ],
            },
        ],
        "depends_on": [],
        "volumes": [
            {
                "name": "gopath",
                "temp": {},
            },
        ],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
        },
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    return [result]

def checkStarlark():
    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "check-starlark",
        "steps": [
            {
                "name": "format-check-starlark",
                "image": "owncloudci/bazel-buildifier:latest",
                "commands": [
                    "buildifier --mode=check .drone.star",
                    "buildifier -d -diff_command='diff -u' .drone.star",
                ],
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
        },
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    return [result]

def deployments(ctx):
    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "k3d",
        "steps": wait(ctx) + install(ctx) + showPodsAfterInstall(ctx),
        "services": [
            {
                "name": "k3d",
                "image": "ghcr.io/k3d-io/k3d:5-dind",
                "privileged": True,
                "commands": [
                    "nohup dockerd-entrypoint.sh &",
                    "until docker ps 2>&1 > /dev/null; do sleep 1s; done",
                    "k3d cluster create --config ci/k3d-drone.yaml --api-port k3d:6445",
                    "until kubectl get deployment coredns -n kube-system -o go-template='{{.status.availableReplicas}}' | grep -v -e '<no value>'; do sleep 1s; done",
                    "k3d kubeconfig get drone > kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
                    "chmod 0600 kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
                    "printf '@@@@@@@@@@@@@@@@@@@@@@@\n@@@@ k3d is ready @@@@\n@@@@@@@@@@@@@@@@@@@@@@@\n'",
                    "kubectl get events -Aw",
                ],
            },
        ],
        "depends_on": [],
        "volumes": [
            {
                "name": "gopath",
                "temp": {},
            },
        ],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
        },
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    return [result]

def install(ctx):
    return [{
        "name": "helm-install",
        "image": "owncloudci/golang:latest",
        "commands": [
            "export KUBECONFIG=kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
            "make helm-install-atomic",
        ],
        "volumes": [
            {
                "name": "gopath",
                "path": "/go",
            },
        ],
    }]

def wait(config):
    return [{
        "name": "wait",
        "image": "docker.io/bitnami/kubectl:1.31",
        "user": "root",
        "commands": [
            "export KUBECONFIG=kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
            "until test -f $${KUBECONFIG}; do sleep 1s; done",
            "kubectl config view",
            "kubectl get pods -A",
        ],
    }]

def showPodsAfterInstall(config):
    return [{
        "name": "testPodsAfterInstall",
        "image": "docker.io/bitnami/kubectl:1.31",
        "user": "root",
        "commands": [
            "export KUBECONFIG=kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
            "until test -f $${KUBECONFIG}; do sleep 1s; done",
            "kubectl get pods -n ocis",
            "if [ \"$(kubectl get pods -n ocis --field-selector status.phase=Running | wc -l)\" -le \"32\" ]; then exit 1; fi",  # there are 32 pods + 1 header line
            "kubectl get ingress -n ocis",
            "if [ \"$(kubectl get ingress -n ocis | wc -l)\" -le \"1\" ]; then exit 1; fi",
        ],
    }]
