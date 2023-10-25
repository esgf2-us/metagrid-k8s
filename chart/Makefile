.PHONY: bump-%
bump-%:
	# no tag as chart-releaser will handle that
	tbump $(ARGS) --no-tag $(shell pysemver bump $* $(shell tbump current-version))
