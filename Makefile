.PHONY: package
package:
	helm repo add bitnami https://charts.bitnami.com/bitnami || exit 0
	cr --config cr.yaml package chart/

.PHONY: upload
upload:
	cr --config cr.yaml upload --skip-existing --token $(TOKEN)

.PHONY: index
index:
	mkdir .cr-index || exit 0
	cr --config cr.yaml index --push --token $(TOKEN)

.PHONY: release
release: package upload index

.PHONY: bump-%
bump-%:
	tbump --no-tag $(ARGS) $(shell python3 -m semver bump $* $(shell tbump current-version))

.PHONY: venv
venv:
	@python3 -m venv metagrid-venv && \
		. metagrid-venv/bin/activate && \
		python3 -m pip install tbump semver