.PHONY: all install_testsuite testsuite_install clean test version

all: tessfpe/sequencer_dsl/SequencerDSLParser.py

version:
	@echo $(VERSION)

tessfpe/sequencer_dsl/SequencerDSLParser.py: 
	make -C $(dir $@) $(notdir $@)

testsuite_install: install_testsuite

install_testsuite: setup.py testsuite/tessfpe tessfpe/sequencer_dsl/SequencerDSLParser.py
	@[ -d testsuite/tessfpe/lib/python2.7/site-packages/tessfpe-*.egg ] \
        || LD_LIBRARY_PATH="$(CURDIR)/testsuite/tessfpe/local/lib:$(CURDIR)/testsuite/tessfpe/local/lib64" testsuite/tessfpe/bin/python setup.py install
	make -C testsuite/venv

reinstall_testsuite:
	rm -rf testsuite/tessfpe
	make install_testsuite

testsuite/tessfpe:
	make -C testsuite tessfpe

test:
	python2.7 -m tessfpe.dhu.ops
	make -C tessfpe test

clean:
	make -C tessfpe clean
	make -C testsuite clean
	rm -rf $(shell find . -name "*.pyc")
	rm -rf MANIFEST dist/ tessfpe.egg-info/ build/
