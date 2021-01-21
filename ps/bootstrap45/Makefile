include /common/ps-common.mk

# Use a generated makefile for input pages:
$(shell /ps/bin/ps-pages-mk > /tmp/ps-pages.mk || rm -f /tmp/ps-pages.mk)
include /tmp/ps-pages.mk


BUILD_STAMP := /build/.project-site-build

# Main config file:
BASE_CONFIG_FILE := /ps/template/_config.yml
INPUT_MAIN_CONFIG_FILE := /input/PS.yaml
BUILD_CONFIG_FILE := /build/_config.yml

# Base files:
$(call assign-output, BASE_FILES, ps-find base-files)
BUILD_FILES := $(BASE_FILES:/base/%=/build/%)

# Base asset files:
$(call assign-output, BASE_ASSET_FILES, ps-find base-asset-files)
BUILD_FILES += $(BASE_ASSET_FILES:/base/site/docs/4.5/%=/build/site/%)

# PS override files:
$(call assign-output, PS_FILES, ps-find ps-files)
BUILD_FILES += $(PS_FILES:/ps/base/%=/build/%)

# Template files:
$(call assign-output, TEMPLATE_FILES, ps-find template-files)
BUILD_FILES += $(TEMPLATE_FILES:/ps/template/%=/build/%)

# Page files:
BUILD_FILES += $(PAGES_FILES)

BUILD_DIRS != ( \
  printf "%s\n" $(PAGES_DIRS); \
  dirname $(BUILD_FILES) \
) | sort | uniq


#------------------------------------------------------------------------------
default:: debug

debug:
	@echo 'BUILD_FILES:'
	@printf "%s\n" $(BUILD_FILES)
	@echo
	@echo 'BUILD_DIRS:'
	@printf "%s\n" $(BUILD_DIRS)

build: $(BUILD_DIRS) $(BUILD_FILES)
	date > $(BUILD_STAMP)

clean:
	rm -fr /build/* /build.*

$(BUILD_DIRS):
	mkdir -p $@

$(BUILD_CONFIG_FILE): $(BASE_CONFIG_FILE) $(INPUT_MAIN_CONFIG_FILE)
	ps-config $^ > $@

/build/%: /ps/template/% /input/PS.yaml
	ps-render $^ > $@

/build/site/%: /ps/base/site/%
	cp -p $< $@

/build/site/assets/%: /ps/base/site/assets/%
	cp -p $< $@

/build/scss/%: /ps/base/scss/%
	cp -p $< $@

/build/build/%: /ps/base/build/%
	cp -p $< $@

/build/package.json: /ps/base/package.json
	cp -p $< $@

/build/site/assets/%: /ps/template/site/assets/% /input/PS.yaml
	ps-render $^ > $@

/build/site/assets/%: /base/site/docs/4.5/assets/%
	cp -p $< $@

/build/%: /base/%
	cp -p $< $@
