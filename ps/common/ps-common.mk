ifeq ($(wildcard /ps),)
    $(error This Makefile should only run in a ProjectShell Docker container)
endif

SHELL := bash
.DELETE_ON_ERROR:
.SECONDEXPANSION:

export PATH := /ps/bin:$(PATH)

# Function to run a shell command and assign output to a variable.
# If command fails, Makefile will error out.
assign-output = $(eval $(call assign-output-body,$1,$2))
define assign-output-body
  cmd := $$(strip $2)
  out := $$(shell $$(cmd) 2>&1 || echo FAILURE)
  ifeq ($$(filter FAILURE,$$(out)),FAILURE)
    $$(info Failed to run command: '$$(cmd)')
    $$(error $$(filter-out FAILURE,$$(out)))
  endif
  $1 := $$(out)
endef

default::
