.PHONY: deploy
deploy:
	helm upgrade --install test ../../chart

.PHONY: delete
delete:
	helm delete test

.PHONY: open
open:
	@echo "Visit:\n\thttp://127.0.0.1:3000/metagrid/"
	minikube kubectl -- port-forward $(shell minikube kubectl --  get pods --selector app.kubernetes.io/component=django -oname) 5000 & \
		minikube kubectl -- port-forward $(shell minikube kubectl --  get pods --selector app.kubernetes.io/component=react -oname) 3000
