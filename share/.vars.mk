SHELL := bash

ifeq ($(PROJECT_SITE_ROOT),)
  $(error See https://project-site.org/doc/installation)
endif

export PATH := $(PROJECT_SITE_ROOT)/bin:$(PATH)

ROOT := $(shell pwd)
PS_BUILDER ?= bootstrap45
PS_INPUT_DIR ?= src
PS_BUILD_DIR ?= .build
PS_OUTPUT_DIR ?= .output
PS_LOCAL_PORT ?= 12345

PS_PUBLISH_BRANCH ?= $(shell \
  grep '^  publish: ' $(PS_INPUT_DIR)/PS.yaml | \
  awk '{print $$2}' \
)

GITHUB_SOURCE_URL ?= $(shell \
  grep '^  repo: ' $(PS_INPUT_DIR)/PS.yaml | \
  awk '{print $$2}' \
)

PS_GITHUB_URL ?= $(shell git config --get remote.origin.url)
ifneq ($(PS_GITHUB_URL),)
  GITHUB_URL := $(PS_GITHUB_URL)
  GITHUB_PATH := $(GITHUB_URL:%.git=%)
  GITHUB_PATH := $(GITHUB_PATH:https://github.com/%=%)
  GITHUB_PATH := $(GITHUB_PATH:git@github.com:%=%)
  GITHUB_USER := $(word 1,$(subst /, ,$(GITHUB_PATH)))
  GITHUB_REPO := $(word 2,$(subst /, ,$(GITHUB_PATH)))

  ifneq ($(GITHUB_SOURCE_URL),)
    ifeq ($(findstring project-site,$(GITHUB_SOURCE_URL)),)
      GITHUB_SOURCE_PATH := $(GITHUB_SOURCE_URL:%.git=%)
      GITHUB_SOURCE_PATH := $(GITHUB_SOURCE_PATH:https://github.com/%=%)
      GITHUB_SOURCE_PATH := $(GITHUB_SOURCE_PATH:git@github.com:%=%)
      GITHUB_SOURCE_USER := $(word 1,$(subst /, ,$(GITHUB_SOURCE_PATH)))

      ifneq ($(GITHUB_USER),)
        ifneq ($(GITHUB_USER),$(GITHUB_SOURCE_USER))
          export PROJECT_SITE_CNAME := none
          export PROJECT_SITE_BASEURL := /$(GITHUB_REPO)
        endif
      endif
    endif
  endif
endif
