#
# Make Variables
#
SITE = site
TEMPLATE = template

ALL_CONTENT := $(shell find content/ -type f | grep -v '\.sw' | perl -pe 's!^\w+/(.*)\.(?:st|pod|html)$$!$$1!' | sort)

PROJECT_SITE_BASE = $(MAKEFILE_LIST:%/Makefile=%)
PROJECT_SITE_CSS = project-site.css
PROJECT_SITE_DIRS = \
	content \
	template \
	site \
	site/images \
	site/js \

PROJECT_SITE_SYMLINKS_0 = \
	Makefile \
	bin \

PROJECT_SITE_SYMLINKS_1 = \
	$(TEMPLATE)/wrapper.html \
	$(TEMPLATE)/header.html \
	$(TEMPLATE)/$(PROJECT_SITE_CSS) \

PROJECT_SITE_SYMLINKS_2 = \
	$(SITE)/js/jquery.js \
	$(SITE)/js/sidebar.js \

PROJECT_SITE_SYMLINKS = \
	$(PROJECT_SITE_SYMLINKS_0) \
	$(PROJECT_SITE_SYMLINKS_1) \
	$(PROJECT_SITE_SYMLINKS_2) \

PROJECT_SITE_DEFAULTS = \
	config.yaml \
	template/sidebar.html \
	content/home.st \
	site/images/logo.png \

SITE_CSS = $(SITE)/$(PROJECT_SITE_CSS)
SITE_DIRS = $(ALL_CONTENT:%=$(SITE)/%/)
SITE_HTML = $(ALL_CONTENT:%=$(SITE)/%/index.html)
SITE_FILES = $(SITE_HTML) $(SITE_CSS)

#
# Make Targets
#

# debug:
# 	@echo '>>' $(SITE_DIRS)
# 	@echo '>>>' $(SITE_FILES)

all: $(SITE_DIRS) $(SITE_FILES)

$(SITE_CSS): $(TEMPLATE)/$(PROJECT_SITE_CSS) Makefile config.yaml
	tt-render --path=$(TEMPLATE) --data=config.yaml $(PROJECT_SITE_CSS) > $@

$(SITE)/%/index.html: template/%.html config.yaml Makefile $(SITE)/%/
	tt-render --path=$(TEMPLATE) --data=config.yaml $(@:$(SITE)/%/index.html=%.html) > $@

template/%.html: content/%.html
	cp -p $< > $@

template/%.html: content/%.st
	bin/render $< > $@

template/%.html: content/%.pod
	pod2html $< > $@.tmp 2> /dev/null
	rm pod2htm[id].tmp
	bin/strip.pl $@.tmp > $@
	rm $@.tmp

$(SITE_DIRS) $(PROJECT_SITE_DIRS):
	mkdir -p $@

project-site: $(PROJECT_SITE_DIRS) $(PROJECT_SITE_SYMLINKS) $(PROJECT_SITE_DEFAULTS)
	(cd $(SITE); ln -s home/index.html)
	ln -s $(SITE) htdocs

$(PROJECT_SITE_SYMLINKS_0):
	ln -s $(PROJECT_SITE_BASE)/$@ $@

$(PROJECT_SITE_SYMLINKS_1):
	ln -s ../$(PROJECT_SITE_BASE)/$@ $@

$(PROJECT_SITE_SYMLINKS_2):
	ln -s ../../$(PROJECT_SITE_BASE)/$@ $@

$(PROJECT_SITE_DEFAULTS):
	cp -p $(PROJECT_SITE_BASE)/$@ $@

clean:
	rm -fr $(SITE_DIRS)
