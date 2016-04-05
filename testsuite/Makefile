.PHONY: install
BLAS_VERSION=3.6.0
VIRTUAL_ENV_VERSION=15.0.1
PYTHON_VERSION=2.7.11

all: install

install: venv/src/BLAS venv/local/bin/python2.7 venv/local/bin/virtualenv
	BLAS_SRC=venv/src/BLAS venv/local/bin/pip install -q -r requirements.txt
	[ -f venv/bin/python2.7 ] || venv/local/bin/virtualenv --system-site-packages -p venv/local/bin/python2.7 venv
	venv/bin/pip install --upgrade pip
	make -C .. testsuite_install

venv/local/:
	mkdir -p $@

venv/src/Python:
	mkdir -p $(dir $@)
	(cd $(dir $@); \
	 rm -rf $(notdir $@) ; \
	 curl https://www.python.org/ftp/python/$(PYTHON_VERSION)/Python-$(PYTHON_VERSION).tgz | tar zxfv - ; \
	 rm -rf $@ ; \
         ln -s $(notdir $@)-$(PYTHON_VERSION) $(notdir $@))

venv/local/bin/python2.7: venv/src/Python venv/local/
	(cd $< ; \
	 ./configure --prefix=$(CURDIR)/venv/local/ ; \
	 make install)
	touch $@

venv/local/bin/pip: venv/local/bin/python2.7
	curl https://bootstrap.pypa.io/get-pip.py -o - | $<
	touch $@

venv/local/bin/virtualenv: venv/local/bin/pip
	$< install $(notdir $@)

venv/src/BLAS:
	mkdir -p $(dir $@)
	(cd $(dir $@); \
	 rm -rf $(notdir $@); \
         curl http://www.netlib.org/blas/blas-$(BLAS_VERSION).tgz | tar zxfv - ; \
	 rm -rf $@ ; \
         ln -s $(notdir $@)-$(BLAS_VERSION) $(notdir $@))


reinstall:
	rm -rf venv/{bin,lib,include,pip-selfcheck.json}
	make install

clean:
	rm -rf venv/
