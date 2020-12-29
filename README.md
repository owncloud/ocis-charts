## Install

This chart is still in an experimental phase, and it has not yet been published.

## Development

Make sure to read the gotchas on the charts before attempting to run any, this project is still under heavy development.

1. Clone this repo
2. Install dependencies 
    2.1 [Helm](https://helm.sh/docs/intro/install/)
    2.2 [Minikube](https://minikube.sigs.k8s.io/docs/start/)
3. run `helm install ocis-refs ocis`

Verifying everything is running smooth can be done with `kubectl get services` and `kubectl get pods`; be sure to check on the pod status for errors, especially after committing an upgrade. If you want to update anything, modify the chart's `values.yaml` and run `helm upgrade ocis .` For listing installed charts run:

```console
$ helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
ocis-refs       default         1               2020-12-29 12:15:07.455781 +0100 CET    deployed        refs-ocis-0.1.0 1.0.0-rc8
``` 

### Dry runs
There are time when before upgrading you'd like to see the output of the yaml files that will be sent to Kubernetes, for that there is a little helper script `dry-run.sh`.