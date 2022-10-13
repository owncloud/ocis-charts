include .bingo/Variables.mk

all: docs lint api clean

.PHONY: docs
docs: $(HELM_DOCS) $(GOMPLATE)
	$(HELM_DOCS) --template-files=README.md.gotmpl --output-file=README.md
	$(HELM_DOCS) --log-level debug --template-files=charts/ocis/docs/templates/values-desc-table.adoc.gotmpl --output-file=docs/values-desc-table.adoc
	$(HELM_DOCS) --log-level debug --template-files=charts/ocis/docs/templates/kube-versions.adoc.gotmpl --output-file=docs/kube-versions.adoc
	$(GOMPLATE) --file=charts/ocis/docs/templates/values.adoc.yaml.gotmpl  --out=charts/ocis/docs/values.adoc.yaml

.PHONY: clean
clean:
	@rm charts/ocis/ci/templated.yaml


.PHONY: lint
lint: $(KUBE_LINTER)
	# TODO: use helm from bingo
	helm lint charts/ocis
	helm template charts/ocis -f charts/ocis/ci/values.yaml > charts/ocis/ci/templated.yaml
	$(KUBE_LINTER) lint charts/ocis/ci/templated.yaml


.PHONY: api
api: $(KUBECONFORM)
	helm template --kube-version 1.22.0 charts/ocis -f charts/ocis/ci/values.yaml > charts/ocis/ci/templated.yaml
	$(KUBECONFORM) -kubernetes-version 1.22.0 -summary -strict charts/ocis/ci/templated.yaml

	helm template --kube-version 1.23.0 charts/ocis -f charts/ocis/ci/values.yaml > charts/ocis/ci/templated.yaml
	$(KUBECONFORM) -kubernetes-version 1.23.0 -summary -strict charts/ocis/ci/templated.yaml

	helm template --kube-version 1.24.0 charts/ocis -f charts/ocis/ci/values.yaml > charts/ocis/ci/templated.yaml
	$(KUBECONFORM) -kubernetes-version 1.24.0 -summary -strict charts/ocis/ci/templated.yaml

	helm template --kube-version 1.25.0 charts/ocis -f charts/ocis/ci/values-1-25.yaml > charts/ocis/ci/templated.yaml
	$(KUBECONFORM) -kubernetes-version 1.25.0 -summary -strict charts/ocis/ci/templated.yaml
