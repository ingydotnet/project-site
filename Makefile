TARGET = site
TEMPLATE = template

ALL := $(shell find content/ -type f | grep -v '\.sw' | perl -pe 's!^\w+/(.*)\.(?:st|pod)$$!$$1!' | sort)

ALL_TARGETS = $(ALL:%=$(TARGET)/%/index.html)
ALL_DIRS = $(ALL:%=$(TARGET)/%/)
CSS = $(TARGET)/style.css

all: $(ALL_TARGETS) $(CSS)

$(CSS): $(TEMPLATE)/style.css Makefile config.yaml
	tt-render --path=$(TEMPLATE) --data=config.yaml style.css > $@

site/%/index.html: template/%.html config.yaml Makefile site/%/
	tt-render --path=$(TEMPLATE) --data=config.yaml $(@:$(TARGET)/%/index.html=%.html) > $@

template/%.html: content/%.st
	bin/render $< > $@

template/%.html: content/%.pod
	pod2html $< > $@.tmp 2> /dev/null
	rm pod2htm[id].tmp
	bin/strip.pl $@.tmp > $@
	rm $@.tmp

$(ALL_DIRS):
	mkdir -p $@

clean:
	rm -fr $(ALL_DIRS) $(CSS)
