SHELL := bash

ROOT := $(shell pwd)

export PATH := $(ROOT)/bin:$(PATH)

input := share/bootstrap
output := .gh-pages
builder := bootstrap45
port ?= $(shell grep '^  port: ' $(input)/ps-config.yaml | awk '{print $$2}')

BUILDER_BASE := base-$(builder)


default:

build local shell publish: builder-build $(BUILDER_BASE)
	project-site --$@ \
	    --input=$(input) \
	    --output=$(output) \
	    --builder=$(builder) \
	    --port=$(port) \
	    "$(cmd)"

builder-build:
	make -C builder/$(builder) build

$(BUILDER_BASE):
	git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@

$(output):
	git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@
	touch $@/.project-site-build

clean:
	rm -fr base-* $(output)
