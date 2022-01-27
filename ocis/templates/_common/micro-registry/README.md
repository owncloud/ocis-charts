# oCIS service discovery

oCIS services use go-micro for service discovery. For Kubernetes deployments,
this uses pod metadata annoations. Therefore oCIS needs to write and ready annotations.

See also [go-micro docs](https://github.com/asim/go-micro/blob/master/plugins/registry/kubernetes/README.md)
