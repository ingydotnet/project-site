SHELL := bash

DOCKER_USER := projectsite
DOCKER_NAME := ps-builder-bootstrap45
DOCKER_TAG := 0.0.3
DOCKER_IMAGE := $(DOCKER_USER)/$(DOCKER_NAME):$(DOCKER_TAG)

default:

build:
	docker build \
	    --tag $(DOCKER_IMAGE) \
	    .

shell: build
        docker run -it --rm $(DOCKER_IMAGE) bash

publish: build
	docker push $(DOCKER_IMAGE)
