.POSIX:

SLIM_INTERPRETER = ~/local/var/slime.sh

# ------ phony targets ------

_default: _warning _run_tidy _run_slim

_force:

_warning:
	@echo "WARNING: this uses a hand-rolled slim interpreter at"
	@echo " ~/local/var/slime.sh"
	@echo
	@echo "WARNING: this Makefile is hand-rolled and not complete yet"
	@echo
	@echo " currently it handles:"
	@echo
	@echo "   - employment/index.html"
	@echo "   - docs/index.html"
	@echo "   - docs/contact/index.html"


# ------ generate with slim up html ------

_run_slim: _run_slim_description \
           docs/employment/index.html

_run_slim_description: _force
	@echo
	@echo "Generating html from slim files..."

docs/employment/index.html: employment/index.slim
	$(SLIM_INTERPRETER) <employment/index.slim >docs/employment/index.html
	tidy5 -config tidy_config.txt -m docs/employment/index.html

# ------ tidy up html ------

_run_tidy:  _run_tidy_description \
	    docs/index.html \
            docs/contact/index.html
#            docs/employment/index.html

_run_tidy_description: _force
	@echo
	@echo "Linting html files with tidy..."

docs/index.html: _force
	tidy5 -config tidy_config.txt -m docs/index.html

docs/contact/index.html: _force
	tidy5 -config tidy_config.txt -m docs/contact/index.html

#docs/employment/index.html: _force
#	tidy5 -config tidy_config.txt -m docs/employment/index.html

