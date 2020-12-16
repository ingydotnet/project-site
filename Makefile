PROJECT_SITE_ROOT := $(shell pwd)
INPUT_DIR := share/src
include $(PROJECT_SITE_ROOT)/share/.vars.mk
include $(PROJECT_SITE_ROOT)/share/.rules.mk

builder-build:
	make -C builder/$(PROJECT_SITE_BUILDER) build

clean::
	rm -fr base-*
