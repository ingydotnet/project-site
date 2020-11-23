SHELL := bash

BUILDER := bootstrap45

DOCKER_TAG := 1.0.0
# DOCKER_IMAGE := project-site-builder-$(BUILDER):$(DOCKER_TAG)
DOCKER_IMAGE := project-site-builder-$(BUILDER)

default:

build:
	docker build \
	    --tag $(DOCKER_IMAGE) \
	    .
