# oCIS "kubernetes" service registry

oCIS services uses the go-micro registry for service discovery.

The "kubernetes" registry implementation uses pod metadata annotations. Therefore oCIS needs to write and read pod annotations via the Kubernetes API. Therefore it needs a service account that grants permission to do so.

See also [go-micro docs](https://github.com/asim/go-micro/blob/master/plugins/registry/kubernetes/README.md)
