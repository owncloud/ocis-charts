config = {
    "branches": [
        "main",
    ],
    # if this changes, also tested versions in need to be changed here:
    # - Makefile
    "kubernetesVersions": [
        "1.27.0",
        "1.28.0",
        "1.29.0",
        "1.30.0",
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

    kubeconform_steps = []

    for version in config["kubernetesVersions"]:
        kubeconform_steps.append(
            {
                "name": "template - %s" % version,
                "image": "owncloudci/alpine:latest",
                "commands": [
                    "make api-%s-template" % version,
                ],
            },
        )
        kubeconform_steps.append(
            {
                "name": "kubeconform - %s" % version,
                "image": "owncloudci/golang:latest",
                "commands": [
                    "make api-%s-kubeconform" % version,
                ],
                "volumes": [
                    {
                        "name": "gopath",
                        "path": "/go",
                    },
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
                "image": "owncloudci/alpine:latest",
                "commands": [
                    "helm lint charts/ocis",
                ],
            },
            {
                "name": "helm template",
                "image": "owncloudci/alpine:latest",
                "commands": [
                    "helm template charts/ocis -f 'charts/ocis/ci/values.yaml' > charts/ocis/ci/templated.yaml",
                ],
            },
            {
                "name": "kube-linter",
                "image": "stackrox/kube-linter:latest",
                "entrypoint": [
                    "/kube-linter",
                    "lint",
                    "--exclude=latest-tag",
                    "charts/ocis/ci/templated.yaml",
                ],
            },
        ] + kubeconform_steps,
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
                "name": "helm-docs-readme",
                "image": "jnorwood/helm-docs:v1.13.1",
                "entrypoint": [
                    "/usr/bin/helm-docs",
                    "--template-files=README.md.gotmpl",
                    "--output-file=README.md",
                ],
            },
            {
                "name": "helm-docs-values-table-adoc",
                "image": "jnorwood/helm-docs:v1.13.1",
                "entrypoint": [
                    "/usr/bin/helm-docs",
                    "--template-files=charts/ocis/docs/templates/values-desc-table.adoc.gotmpl",
                    "--output-file=docs/values-desc-table.adoc",
                ],
            },
            {
                "name": "gomplate-values-adoc",
                "image": "hairyhenderson/gomplate:v3.11.7-alpine",
                "entrypoint": [
                    "/bin/gomplate",
                    "--file=charts/ocis/docs/templates/values.adoc.yaml.gotmpl",
                    "--out=charts/ocis/docs/values.adoc.yaml",
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
        "image": "docker.io/owncloudci/alpine",
        "commands": [
            "export KUBECONFIG=kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
            "helm install --values charts/ocis/ci/deployment-values.yaml --atomic --timeout 5m0s ocis charts/ocis/",
        ],
    }]

def wait(config):
    return [{
        "name": "wait",
        "image": "docker.io/bitnami/kubectl:1.25",
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
        "name": "showPodsAfterInstall",
        "image": "docker.io/bitnami/kubectl:1.25",
        "user": "root",
        "commands": [
            "export KUBECONFIG=kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
            "until test -f $${KUBECONFIG}; do sleep 1s; done",
            "kubectl get pods -A",
            "kubectl get ingress",
        ],
    }]
