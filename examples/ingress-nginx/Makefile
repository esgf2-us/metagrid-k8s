.PHONY: deploy
deploy:
	MINIKUBE_IP=$(shell minikube ip) envsubst '$$MINIKUBE_IP' < overrides.yaml.tpl > overrides.yaml
	helm upgrade --install -f overrides.yaml test ../../chart

.PHONY: delete
delete:
	helm delete test

.PHONY: open
open:
	@echo "Run:\n\techo '$(shell minikube ip) metagrid.minikube.io' >> /etc/hosts"
	@echo "Visit:\n\t https://metagrid.minikube.io/metagrid/"
