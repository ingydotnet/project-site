SHELL := bash

PROJECT_SITE := .project-site
SITE_BUILDER := bootstrap45
SITE_DIR := project-site
BUILD_DIR := gh-pages
PORT ?= $(shell grep '^  port: ' $(SITE_DIR)/ps-config.yaml | awk '{print $$2}')

export PATH := $(PROJECT_SITE)/bin:$(PATH)

default:

build local publish shell: $(PROJECT_SITE) $(BUILD_DIR)
	project-site --$@ \
	    --input=$(SITE_DIR) \
	    --output=$(BUILD_DIR) \
	    --builder=$(SITE_BUILDER) \
	    --port=$(PORT)

serve: build
	( \
	    cd $(BUILD_DIR); \
	    python -m SimpleHTTPServer $(PORT); \
	)

clean:
	rm -fr $(PROJECT_SITE) $(BUILD_DIR)

$(PROJECT_SITE):
ifeq ($(GIT_AUTHOR_NAME),Ingy döt Net)
	ln -s ../../project-site $@
else
	git clone git@github.com:ingydotnet/project-site $@
endif

$(BUILD_DIR):
	git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@
	touch $@/.project-site-build
