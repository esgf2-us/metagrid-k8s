REGISTRY ?= ghcr.io
REGISTRY_NAMESPACE ?= esgf-nimbus

build-django push-django: NAME = metagrid-django
build-django push-django: TAG ?= 0.1.0

build-react push-react: NAME = metagrid-react
build-react push-react: TAG ?= 0.1.0

.PHONY: build-react
build-react: DOCKERFILE = React.dockerfile
build-react: CONTEXT = .
build-react: build

.PHONY: build-django
build-django: DOCKERFILE = Django.dockerfile
build-django: CONTEXT = metagrid-upstream/backend
build-django: build

build:
	docker build -t $(REGISTRY)/$(REGISTRY_NAMESPACE)/$(NAME):$(TAG) -f $(DOCKERFILE) $(CONTEXT)

.PHONY: push-react
push-react: push

.PHONY: push-django
push-django: push

.PHONY: push
push:
	docker push $(REGISTRY)/$(REGISTRY_NAMESPACE)/$(NAME):$(TAG)
