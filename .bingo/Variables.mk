# Auto generated binary variables helper managed by https://github.com/bwplotka/bingo v0.6. DO NOT EDIT.
# All tools are designed to be build inside $GOBIN.
BINGO_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
GOPATH ?= $(shell go env GOPATH)
GOBIN  ?= $(firstword $(subst :, ,${GOPATH}))/bin
GO     ?= $(shell which go)

# Below generated variables ensure that every time a tool under each variable is invoked, the correct version
# will be used; reinstalling only if needed.
# For example for bingo variable:
#
# In your main Makefile (for non array binaries):
#
#include .bingo/Variables.mk # Assuming -dir was set to .bingo .
#
#command: $(BINGO)
#	@echo "Running bingo"
#	@$(BINGO) <flags/args..>
#
BINGO := $(GOBIN)/bingo-v0.6.1-0.20220802115931-bc8384942721
$(BINGO): $(BINGO_DIR)/bingo.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/bingo-v0.6.1-0.20220802115931-bc8384942721"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=bingo.mod -o=$(GOBIN)/bingo-v0.6.1-0.20220802115931-bc8384942721 "github.com/bwplotka/bingo"

GOMPLATE := $(GOBIN)/gomplate-v3.11.3
$(GOMPLATE): $(BINGO_DIR)/gomplate.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/gomplate-v3.11.3"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=gomplate.mod -o=$(GOBIN)/gomplate-v3.11.3 "github.com/hairyhenderson/gomplate/v3/cmd/gomplate"

HELM_DOCS := $(GOBIN)/helm-docs-v1.11.0
$(HELM_DOCS): $(BINGO_DIR)/helm-docs.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/helm-docs-v1.11.0"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=helm-docs.mod -o=$(GOBIN)/helm-docs-v1.11.0 "github.com/norwoodj/helm-docs/cmd/helm-docs"

KUBE_LINTER := $(GOBIN)/kube-linter-v0.4.0
$(KUBE_LINTER): $(BINGO_DIR)/kube-linter.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/kube-linter-v0.4.0"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=kube-linter.mod -o=$(GOBIN)/kube-linter-v0.4.0 "golang.stackrox.io/kube-linter/cmd/kube-linter"

KUBECONFORM := $(GOBIN)/kubeconform-v0.4.14
$(KUBECONFORM): $(BINGO_DIR)/kubeconform.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/kubeconform-v0.4.14"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=kubeconform.mod -o=$(GOBIN)/kubeconform-v0.4.14 "github.com/yannh/kubeconform/cmd/kubeconform"

