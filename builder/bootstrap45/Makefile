SHELL := bash

DOCKER_TAG := 1.0.0
DOCKER_IMAGE := project-site-builder-bootstrap45:$(DOCKER_TAG)

build: docker-build

docker-build:
	docker build --tag=$(DOCKER_IMAGE) .

docker-run: docker-build
	docker run -it --rm \
	    --workdir /work/base \
	    --publish 9001:9001 \
	    $(DOCKER_IMAGE) \
		bash -c '( \
		    bundle exec jekyll build && \
		    cp -r dist _gh_pages/docs/4.5/ && \
		    bundle exec jekyll serve \
			--skip-initial-build \
			--host 0.0.0.0 \
		)'

docker-shell: docker-build
	$(call docker-run,tmux)

define docker-run
docker run -it --rm \
    --workdir /work/base \
    --publish 9001:9001 \
    --volume $(PWD):/host \
    $(DOCKER_IMAGE) \
	bash -c '( \
	    bundle exec jekyll build && \
	    cp -r dist _gh_pages/docs/4.5/ && \
	    $1 \
	)'
endef
