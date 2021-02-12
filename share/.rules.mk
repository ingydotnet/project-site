.PHONY: info build local publish shell serve clean
.DELETE_ON_ERROR:

ifeq ($(PROJECT_SITE_ROOT),)
  $(error See https://project-site.org/doc/installation)
endif

info::
	@echo ROOT = $(ROOT)
	@echo
	@echo PROJECT_SITE_ROOT = $(PROJECT_SITE_ROOT)
	@echo
	@echo PS_BUILDER = $(PS_BUILDER)
	@echo PROJECT_SITE_CNAME = $(PROJECT_SITE_CNAME)
	@echo PROJECT_SITE_BASEURL = $(PROJECT_SITE_BASEURL)
	@echo
	@echo PS_INPUT_DIR = $(PS_INPUT_DIR)
	@echo PS_BUILD_DIR = $(PS_BUILD_DIR)
	@echo PS_OUTPUT_DIR = $(PS_OUTPUT_DIR)
	@echo PS_PUBLISH_BRANCH = $(PS_PUBLISH_BRANCH)
	@echo PS_LOCAL_PORT = $(PS_LOCAL_PORT)
	@echo PS_GITHUB_URL = $(PS_GITHUB_URL)
	@echo
	@echo GITHUB_URL = $(GITHUB_URL)
	@echo GITHUB_PATH = $(GITHUB_PATH)
	@echo GITHUB_USER = $(GITHUB_USER)
	@echo GITHUB_REPO = $(GITHUB_REPO)
	@echo
	@echo GITHUB_SOURCE_URL = $(GITHUB_SOURCE_URL)
	@echo GITHUB_SOURCE_PATH = $(GITHUB_SOURCE_PATH)
	@echo GITHUB_SOURCE_USER = $(GITHUB_SOURCE_USER)

build local publish shell:: $(PS_OUTPUT_DIR) $(BUILD_DEPS)
	project-site --$@ \
	    --input-dir=$(PS_INPUT_DIR) \
	    --build-dir=$(PS_BUILD_DIR) \
	    --output-dir=$(PS_OUTPUT_DIR) \
	    --builder=$(PS_BUILDER) \
	    --port=$(PS_LOCAL_PORT) \
	    $(args)

serve:: build
	( \
	    cd $(PS_OUTPUT_DIR); \
	    python -m SimpleHTTPServer $(PS_LOCAL_PORT); \
	)

clean::
	rm -fr $(PS_BUILD_DIR) $(PS_OUTPUT_DIR)

$(PS_OUTPUT_DIR):
ifneq ($(PS_PUBLISH_BRANCH),)
	$(call add-branch-dir,$(PS_PUBLISH_BRANCH))
else
	mkdir -p $@
endif
	touch $@/.project-site-build

define add-branch-dir
	@( \
	  git rev-parse --verify --quiet $1 >/dev/null || \
	  git branch --track $1 origin/$1 \
	) || { \
	    echo "No local branch '$1' found"; \
	    echo "Try: project-site --make-branch=$1"; \
	    exit 1; \
	}
	git worktree add -f $@ $1
endef
