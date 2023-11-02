.PHONY: bump-%
bump-%:
	# no tag as chart-releaser will handle that
	tbump $(ARGS) --no-tag $(shell pysemver bump $* $(shell tbump current-version))

.PHONY: docs
docs:
	@echo Install helm-docs from https://github.com/norwoodj/helm-docs
	helm-docs --sort-values-order file .
