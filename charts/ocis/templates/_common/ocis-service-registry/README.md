# oCIS service discovery

oCIS services uses the go-micro registry for service discovery. For Kubernetes deployments, this uses pod metadata annotations. Therefore oCIS needs to write and ready annotations.

See also [go-micro docs](https://github.com/asim/go-micro/blob/master/plugins/registry/kubernetes/README.md)
