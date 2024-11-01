.PHONY: deploy
deploy:
	MINIKUBE_IP=$(shell minikube ip) envsubst '$$MINIKUBE_IP' < overrides.yaml.tpl > overrides.yaml
	helm upgrade --install -f overrides.yaml test ../../chart

.PHONY: delete
delete:
	helm delete test

.PHONY: open
open:
	@echo https://$(shell minikube ip)/metagrid
