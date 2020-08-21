.POSIX:

SLIM_INTERPRETER = ~/local/var/slime.sh

# ------ phony targets ------

_default: _run_tidy 

_force:

# ------ tidy up html ------

_run_tidy:  _run_tidy_description \
	    docs/index.html \
            docs/contact/index.html \
            docs/employment/index.html

_run_tidy_description: _force
	@echo "Linting html files with tidy..."

docs/index.html: _force
	tidy5 -config tidy_config.txt -m docs/index.html

docs/contact/index.html: _force
	tidy5 -config tidy_config.txt -m docs/contact/index.html

docs/employment/index.html: _force
	tidy5 -config tidy_config.txt -m docs/employment/index.html

