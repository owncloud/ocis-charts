ifneq (, $(shell command -v go 2> /dev/null)) # suppress `command not found warnings` for non go targets in CI
include .bingo/Variables.mk
endif

all: docs lint api clean

.PHONY: docs
docs: $(HELM_DOCS) $(GOMPLATE)
	$(HELM_DOCS) --template-files=README.md.gotmpl --output-file=README.md
	$(HELM_DOCS) --log-level debug --template-files=charts/ocis/docs/templates/values-desc-table.adoc.gotmpl --output-file=docs/values-desc-table.adoc
	$(GOMPLATE) --file=charts/ocis/docs/templates/values.adoc.yaml.gotmpl  --out=charts/ocis/docs/values.adoc.yaml

.PHONY: clean
clean:
	@rm charts/ocis/ci/templated.yaml

.PHONY: helm-install-atomic
c: $(HELM)
	$(HELM) install -n ocis --create-namespace --values charts/ocis/ci/deployment-values.yaml --atomic --timeout 5m0s ocis charts/ocis/

.PHONY: lint
lint: $(KUBE_LINTER) $(HELM)
	$(HELM) lint charts/ocis
	$(HELM) template charts/ocis -f 'charts/ocis/ci/values.yaml' > charts/ocis/ci/templated.yaml
	$(KUBE_LINTER) lint charts/ocis/ci/templated.yaml

.PHONY: api
api: api-1.28.0 api-1.29.0 api-1.30.0 api-1.31.0

define api_test
	$(HELM) template --kube-version $(1) charts/ocis -f 'charts/ocis/ci/values.yaml' > charts/ocis/ci/templated.yaml
	$(KUBECONFORM) -kubernetes-version $(1) -summary -strict charts/ocis/ci/templated.yaml
endef

.PHONY: api-1.28.0
api-1.28.0: $(KUBECONFORM) $(HELM)
	$(call api_test,"1.28.0")

.PHONY: api-1.29.0
api-1.29.0: $(KUBECONFORM) $(HELM)
	$(call api_test,"1.29.0")

.PHONY: api-1.30.0
api-1.30.0: $(KUBECONFORM) $(HELM)
	$(call api_test,"1.30.0")

.PHONY: api-1.31.0
api-1.31.0: $(KUBECONFORM) $(HELM)
	$(call api_test,"1.31.0")

.PHONY: tools-update
tools-update: $(BINGO)
	$(BINGO) get helm.sh/helm/v3/cmd/helm@latest
	$(BINGO) get github.com/bwplotka/bingo@latest
	$(BINGO) get github.com/hairyhenderson/gomplate/v3/cmd/gomplate@latest
	$(BINGO) get github.com/norwoodj/helm-docs/cmd/helm-docs@latest
	$(BINGO) get golang.stackrox.io/kube-linter/cmd/kube-linter@latest
	$(BINGO) get github.com/yannh/kubeconform/cmd/kubeconform@latest
