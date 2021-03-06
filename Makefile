MODULE=pylama
SPHINXBUILD=sphinx-build
ALLSPHINXOPTS= -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
BUILDDIR=_build


.PHONY: clean
clean:
	sudo rm -rf build dist docs/_build
	find . -name "*.pyc" -delete
	find . -name "*.orig" -delete

.PHONY: register
	python setup.py register

.PHONY: upload
upload:
	python setup.py sdist upload || echo 'Upload already'

.PHONY: t
t: audit
	python setup.py test

.PHONY: audit
audit:
	python -m "pylama.main" \
	    --skip='*/.tox/*,*pylama/pep8.py,*pylama/pyflakes/*,*/pylama/_/*,*/pylama/pylint/*,*/.env/*,*dummy.py' -l "pylint,pep8,pyflakes,mccabe" $(CURDIR)
