
.PHONY: docs
docs:
	helm-docs
	helm-docs --template-files values-table.adoc.gotmpl --output-file values-table.adoc
