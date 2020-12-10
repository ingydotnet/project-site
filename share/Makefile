SHELL := bash

SITE_DIR := src
SITE_BUILDER := bootstrap45
BUILD_DIR := .build
PROJECT_SITE := .project-site
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
	git clone git@github.com:ingydotnet/project-site $@

$(BUILD_DIR):
# 	git branch --track $@ origin/$@ 2>/dev/null || true
# 	git worktree add -f $@
