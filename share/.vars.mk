SHELL := bash

ifeq ($(PROJECT_SITE_ROOT),)
  $(error See https://project-site.org/site/installation)
endif

export PATH := $(PROJECT_SITE_ROOT)/bin:$(PATH)

ROOT := $(shell pwd)
PROJECT_SITE_BUILDER ?= bootstrap45
INPUT_DIR ?= src
# TODO Add support for using WORK_DIR:
WORK_DIR ?= .work
OUTPUT_DIR ?= .output
LOCAL_PORT ?= 12345

PUBLISH_BRANCH ?= $(shell \
  grep '^  publish: ' $(INPUT_DIR)/PS.yaml | \
  awk '{print $$2}' \
)

GITHUB_SOURCE_URL ?= $(shell \
  grep '^  repo: ' $(INPUT_DIR)/PS.yaml | \
  awk '{print $$2}' \
)

GITHUB_URL ?= $(shell git config --get remote.origin.url)
ifneq ($(GITHUB_URL),)
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
