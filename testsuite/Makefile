.PHONY: all install
BLAS_VERSION=3.6.0
VIRTUAL_ENV_VERSION=15.0.1
PYTHON_VERSION=2.7.11
OPENSSL_VERSION=1.0.2g

all: install

install: venv/src/BLAS venv/local/bin/python2.7 venv/local/bin/virtualenv
	LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" venv/local/bin/pip install --upgrade setuptools
	LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" \
        BLAS_SRC=venv/src/BLAS venv/local/bin/pip install -q -r requirements.txt
	[ -f venv/bin/python2.7 ] || LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" \
                                     venv/local/bin/virtualenv --system-site-packages -p venv/local/bin/python2.7 venv
	LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" venv/bin/pip install --upgrade pip
	make -C .. testsuite_install
	if [ ! -x venv/bin/python2.7-official ] ; then \
	   mv venv/bin/python2.7 venv/bin/python2.7-official ; \
	   echo "#!/usr/bin/env bash" >> venv/bin/python2.7 ; \
	   echo "set -euo pipefail" >> venv/bin/python2.7 ; \
	   echo 'DIR="$$( cd "$$( dirname "$${BASH_SOURCE[0]}" )" && pwd )"' >> venv/bin/python2.7 ; \
	   echo 'LD_LIBRARY_PATH="$${DIR}/../local/lib:$${DIR}/../local/lib64:$${LD_LIBRARY_PATH-}" $${DIR}/python2.7-official $$*' >> venv/bin/python2.7 ; \
	fi
	chmod +x venv/bin/python2.7


venv/src/openssl:
	mkdir -p $(dir $@)
	(cd $(dir $@) ; \
	 rm -rf $(notdir $@) ; \
	 curl https://www.openssl.org/source/openssl-$(OPENSSL_VERSION).tar.gz  | tar zxfv - ; \
	 rm -rf $@ ; \
	 ln -s $(notdir $@)-$(OPENSSL_VERSION) $(notdir $@))

venv/local/lib/libssl.a: venv/src/openssl
	(cd $< ; \
	 ./config shared --prefix=$(CURDIR)/venv/local/ --openssldir=$(CURDIR)/venv/local/include/openssl ; \
	 make install )

venv/src/Python:
	mkdir -p $(dir $@)
	(cd $(dir $@) ; \
	 rm -rf $(notdir $@) ; \
	 curl https://www.python.org/ftp/python/$(PYTHON_VERSION)/Python-$(PYTHON_VERSION).tgz | tar zxfv - ; \
	 rm -rf $@ ; \
         ln -s $(notdir $@)-$(PYTHON_VERSION) $(notdir $@))

venv/local/bin/python2.7: venv/src/Python venv/local/lib/libssl.a
	rm -f $@
	(cd $< ; \
	 LDFLAGS="-L$(CURDIR)/venv/local/lib -L$(CURDIR)/venv/local/lib64" \
         LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" \
	 CPPFLAGS="-I$(CURDIR)/venv/local/include -I$(CURDIR)/venv/local/include/openssl" \
         ./configure --prefix=$(CURDIR)/venv/local/ ; \
	 LDFLAGS="-L$(CURDIR)/venv/local/lib -L$(CURDIR)/venv/local/lib64" \
         LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" \
	 CPPFLAGS="-I$(CURDIR)/venv/local/include -I$(CURDIR)/venv/local/include/openssl" \
	 make install)
	touch $@

venv/local/bin/pip: venv/local/bin/python2.7
	curl https://bootstrap.pypa.io/get-pip.py -o - | LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" $<
	LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" venv/local/bin/pip install --upgrade setuptools
	touch $@

venv/local/bin/virtualenv: venv/local/bin/pip
	LD_LIBRARY_PATH="$(CURDIR)/venv/local/lib:$(CURDIR)/venv/local/lib64" $< install $(notdir $@)

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
