.PHONY: all install
BLAS_VERSION=3.6.0

all: install

.tessfpe-clean: .tessfpe-clean/src/BLAS
	virtualenv -p $(shell which python2.7) $@
	.tessfpe-clean/bin/pip install --upgrade pip
	BLAS_SRC=.tessfpe-clean/src/BLAS .tessfpe-clean/bin/pip install -r requirements.txt

venv: tessfpe
	rm -f $@
	ln -s $< $@

tessfpe: .tessfpe-clean
	.tessfpe-clean/bin/virtualenv-clone $< $@

.tessfpe-clean/src/BLAS:
	mkdir -p $(dir $@)
	(cd $(dir $@) ; \
	 curl http://www.netlib.org/blas/blas-$(BLAS_VERSION).tgz | tar zxfv - ; \
	 ln -s BLAS-$(BLAS_VERSION) BLAS)

install:
	make -C .. install_testsuite

reinstall:
	make -C .. reinstall_testsuite

clean:
	rm -rf .tessfpe-clean/ tessfpe/ venv/
