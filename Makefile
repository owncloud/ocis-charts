include .bingo/Variables.mk

all: docs lint api clean

.PHONY: docs
docs: $(HELM_DOCS) $(GOMPLATE)
	$(HELM_DOCS) --template-files=README.md.gotmpl --output-file=README.md
	$(HELM_DOCS) --log-level debug --template-files=charts/ocis/docs/templates/values-desc-table.adoc.gotmpl --output-file=docs/values-desc-table.adoc
	$(HELM_DOCS) --log-level debug --template-files=charts/ocis/docs/templates/kube-versions.adoc.gotmpl --output-file=docs/kube-versions.adoc
	ASSUME_NO_MOVING_GC_UNSAFE_RISK_IT_WITH=go1.18 $(GOMPLATE) --file=charts/ocis/docs/templates/values.adoc.yaml.gotmpl  --out=charts/ocis/docs/values.adoc.yaml

.PHONY: ci-template
ci-template:
	# TODO: use helm from bingo
	helm template charts/ocis -f charts/ocis/values-ci-testing.yaml > ocis-ci-templated.yaml

.PHONY: clean
clean:
	@rm ocis-ci-templated.yaml


.PHONY: lint
lint: ci-template $(KUBE_LINTER)
	# TODO: use helm from bingo
	helm lint charts/ocis
	helm template charts/ocis -f charts/ocis/values-ci-testing.yaml > ocis-ci-templated.yaml
	$(KUBE_LINTER) lint ocis-ci-templated.yaml


.PHONY: api
api: ci-template $(KUBECONFORM)
	$(KUBECONFORM) -kubernetes-version 1.20.0 -summary -strict ocis-ci-templated.yaml
	$(KUBECONFORM) -kubernetes-version 1.21.0 -summary -strict ocis-ci-templated.yaml
	$(KUBECONFORM) -kubernetes-version 1.22.0 -summary -strict ocis-ci-templated.yaml
	$(KUBECONFORM) -kubernetes-version 1.23.0 -summary -strict ocis-ci-templated.yaml
	$(KUBECONFORM) -kubernetes-version 1.24.0 -summary -strict ocis-ci-templated.yaml
