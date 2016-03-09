FPE_SCRIPTS=$(wildcard examples/*.fpe)
FPE_TESTS=$(patsubst examples/%.fpe, %_test, $(FPE_SCRIPTS))
.PHONY: all clean test

all: SequencerDSLParser.py DefaultsParser.py SequencesParser.py ProgramsParser.py

%_test: examples/%.fpe SequencerDSLParser.py
	./parse.py $<
	./sequence.py $<
	./program.py $<

test: $(FPE_TESTS) 

SequencerDSLParser.py: SequencerDSL.ebnf
	grako $< -o $@

clean:
	rm -rf *Parser.py *.pyc
