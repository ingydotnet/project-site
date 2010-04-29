#
# Make Variables
#
.PHONY: new website all clean purge

# MAKEFILE := $(shell if [ -e Makefile ]; then readlink Makefile; fi)
ALL_CONTENT := $(shell if [ -e content ]; then find content -type f | egrep -v '(\.sw|~$$)' | perl -pe 's!^\w+/(.*)\.(?:st|pod|html)$$!$$1!' | sort; fi)

ALL_LAYOUT := $(shell if [ -e layout ]; then find layout -type f | egrep -v '(\.sw|~$$)' | perl -pe 's!^\w+/(.*)\.(?:st|pod|html)$$!$$1!' | sort; fi)

SITE = site
TEMPLATE = template

PROJECT_SITE_BASE = $(MAKEFILE_LIST:%/Makefile.mk=%)
PROJECT_SITE_CSS = project-site.css
PROJECT_SITE_DIRS = \
	bin \
	content \
	layout \
	template \
	site \
	site/images \
	site/js \

PROJECT_SITE_SYMLINKS_1 = \
	bin/render \
	bin/strip.pl \
	$(TEMPLATE)/wrapper.html \
	$(TEMPLATE)/header.html \
	$(TEMPLATE)/$(PROJECT_SITE_CSS) \

PROJECT_SITE_SYMLINKS_2 = \
	$(SITE)/js/jquery.js \
	$(SITE)/js/sidebar.js \

PROJECT_SITE_SYMLINKS = \
	$(PROJECT_SITE_SYMLINKS_1) \
	$(PROJECT_SITE_SYMLINKS_2) \

PROJECT_SITE_DEFAULTS = \
	config.yaml \
	template/sidebar.html \
	content/home.st \
	site/images/logo.png \
	$(TEMPLATE)/custom.css \

PROJECT_SITE_FILES = \
	Makefile \
	$(PROJECT_SITE_DIRS) \
	$(PROJECT_SITE_SYMLINKS) \
	$(PROJECT_SITE_DEFAULTS) \
	$(SITE)/index.html \
	htdocs \
	.gitignore \

SITE_CSS = $(SITE)/$(PROJECT_SITE_CSS)
SITE_DIRS = $(ALL_CONTENT:%=$(SITE)/%/)
SITE_HTML = $(ALL_CONTENT:%=$(SITE)/%/index.html) $(ALL_LAYOUT:%=$(TEMPLATE)/%.html)
SITE_FILES = $(SITE_HTML) $(SITE_CSS)

#
# Make Targets
#

default:
	@echo 'There is no default target. You probably want one of these:'
	@echo ''
	@echo '    new     - Create a new project'
	@echo '    update  - Update existing project'
	@echo '    upgrade - Get latest project-site files'
	@echo ''

# debug:
# 	echo $(MAKEFILE)
# 	@echo '>>' $(SITE_DIRS)
# 	@echo '>>>' $(SITE_FILES)

new: $(PROJECT_SITE_FILES)

update: $(SITE_DIRS) $(SITE_FILES)

upgrade:
	@if [ "$(PROJECT_SITE_BASE)" == "Makefile" ]; then echo 'run instead: make -f ../project-site/Makefile.mk upgrade'; exit 1; fi
	mkdir -p $(PROJECT_SITE_DIRS)
	rm Makefile
	ln -s $(PROJECT_SITE_BASE)/Makefile.mk Makefile
	@for f in `find $(PROJECT_SITE_BASE) -type f | \
	    egrep -v '\.git|\.rst|~|\.swp|gitignore|config\.yaml|Makefile.mk|/js/' | \
	    perl -pe 's!^$(PROJECT_SITE_BASE)/?!!'`; do \
	    if [ ! -e $$f ]; then \
	        echo "cp -R $(PROJECT_SITE_BASE)/$$f $$f"; \
	        cp -R $(PROJECT_SITE_BASE)/$$f $$f; \
	    fi \
	done \

$(SITE_CSS): $(TEMPLATE)/$(PROJECT_SITE_CSS) Makefile config.yaml
	tt-render --path=$(TEMPLATE) --data=config.yaml $(PROJECT_SITE_CSS) > $@

$(SITE)/%/index.html: template/%.html template/*.html config.yaml Makefile $(SITE)/%/
	tt-render --path=$(TEMPLATE) --data=config.yaml $(@:$(SITE)/%/index.html=%.html) > $@

template/%.html: content/%.html
	cp -p $< $@

template/%.html: content/%.st bin/render
	bin/render $< > $@

template/%.html: layout/%.st bin/render
	bin/render --html-already $< > $@

template/%.html: content/%.pod
	pod2html $< > $@.tmp 2> /dev/null
	rm pod2htm[id].tmp
	bin/strip.pl $@.tmp > $@
	rm $@.tmp

$(SITE_DIRS) $(PROJEC_SITE_DIRS):
	mkdir -p $@

# XXX Not working yet :\
# upgrade:
# 	make -f $(MAKEFILE) new

$(SITE)/index.html:
	ln -s home/index.html $@

.gitignore:
	cp -p $(PROJECT_SITE_BASE)/gitignore $@

Makefile:
	ln -s $(PROJECT_SITE_BASE)/Makefile.mk $@

htdocs:
	ln -s $(SITE) $@

$(PROJECT_SITE_SYMLINKS_0):
	ln -s $(PROJECT_SITE_BASE)/$@ $@

$(PROJECT_SITE_SYMLINKS_1):
	ln -s ../$(PROJECT_SITE_BASE)/$@ $@

$(PROJECT_SITE_SYMLINKS_2):
	ln -s ../../$(PROJECT_SITE_BASE)/$@ $@

$(PROJECT_SITE_DEFAULTS):
	cp -p $(PROJECT_SITE_BASE)/$@ $@

symlinks: cleanlinks $(PROJECT_SITE_SYMLINKS) Makefile

cleanlinks:
	rm -fr $(PROJECT_SITE_SYMLINKS) Makefile

clean:
	rm -fr $(SITE_DIRS)

purge: clean
	rm -f $(PROJECT_SITE_FILES)
