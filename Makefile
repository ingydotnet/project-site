default:

test: shellcheck

shellcheck:
	shellcheck bin/project-site
	@echo 'shellchecks passed'

update: bin/getopt.bash


bin/getopt.bash: ../getopt-bash/getopt.bash
	cp $< $@
