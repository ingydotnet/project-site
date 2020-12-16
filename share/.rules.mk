.PHONY: info build local publish shell serve clean
.DELETE_ON_ERROR:

ifeq ($(PROJECT_SITE_ROOT),)
  $(error See https://project-site.org/site/installation)
endif

info::
	@echo ROOT = $(ROOT)
	@echo
	@echo PROJECT_SITE_ROOT = $(PROJECT_SITE_ROOT)
	@echo PROJECT_SITE_BUILDER = $(PROJECT_SITE_BUILDER)
	@echo PROJECT_SITE_CNAME = $(PROJECT_SITE_CNAME)
	@echo PROJECT_SITE_BASEURL = $(PROJECT_SITE_BASEURL)
	@echo
	@echo INPUT_DIR = $(INPUT_DIR)
	@echo WORK_DIR = $(WORK_DIR)
	@echo OUTPUT_DIR = $(OUTPUT_DIR)
	@echo PUBLISH_BRANCH = $(PUBLISH_BRANCH)
	@echo LOCAL_PORT = $(LOCAL_PORT)
	@echo
	@echo GITHUB_URL = $(GITHUB_URL)
	@echo GITHUB_PATH = $(GITHUB_PATH)
	@echo GITHUB_USER = $(GITHUB_USER)
	@echo GITHUB_REPO = $(GITHUB_REPO)
	@echo
	@echo GITHUB_SOURCE_URL = $(GITHUB_SOURCE_URL)
	@echo GITHUB_SOURCE_PATH = $(GITHUB_SOURCE_PATH)
	@echo GITHUB_SOURCE_USER = $(GITHUB_SOURCE_USER)

build local publish shell:: $(OUTPUT_DIR) $(BUILD_DEPS)
	project-site --$@ \
	    --input=$(INPUT_DIR) \
	    --output=$(OUTPUT_DIR) \
	    --builder=$(PROJECT_SITE_BUILDER) \
	    --port=$(LOCAL_PORT)

serve:: build
	( \
	    cd $(OUTPUT_DIR); \
	    python -m SimpleHTTPServer $(LOCAL_PORT); \
	)

clean::
	rm -fr $(OUTPUT_DIR)

$(OUTPUT_DIR):
ifneq ($(PUBLISH_BRANCH),)
	@git rev-parse --verify --quiet $(PUBLISH_BRANCH) >/dev/null || { \
	    echo "No local branch '$(PUBLISH_BRANCH)' found"; \
	    echo "Try: project-site --make-branch=$(PUBLISH_BRANCH)"; \
	    exit 1; \
	}
	git branch --track $(PUBLISH_BRANCH) \
	    origin/$(PUBLISH_BRANCH) 2>/dev/null || true
	git worktree add -f $@ $(PUBLISH_BRANCH)
	touch $@/.project-site-build
else
	mkdir -p $@
endif
