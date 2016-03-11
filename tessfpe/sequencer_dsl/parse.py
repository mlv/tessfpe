#!/usr/bin/env python2.7
"""
A module that wraps grako's generated parser as well
as the associated grammatical semantics for the FPE DSL.
"""

from __future__ import print_function


class ParseException(Exception):
    pass


def strip_block_comments(text):
    """Strips text of block comments"""
    import re
    # Ignore quoted or double quoted strings, double slash, and /* block comments */
    block_comment_re = re.compile(
        r'//.*?$|/\*.*?\*/|\'(?:\\.|[^\\\'])*\'|"(?:\\.|[^\\"])*"',
        re.DOTALL | re.MULTILINE
    )
    return re.sub(block_comment_re, '', text)


class Semantics(object):
    """Semantics for the FPE DSL implemented in grako"""

    def __init__(self):
        self.parameters = {}
        self.sequences = {}
        self.sequence_counter = 0

    @staticmethod
    def readout(readout_ast):
        return {"programs": [p for l in readout_ast["programs"] for p in l],
                "defaults": readout_ast["defaults"],
                "hold": readout_ast["hold"]}

    def parameter(self, parameter_ast):
        self.parameters[parameter_ast["name"]] = parameter_ast["value"]

    def sequence(self, sequence_ast):
        new_sequencer_counter_val = \
            self.sequence_counter + \
            sum(s["steps"]
                for s in sequence_ast["value"]
                if "steps" in s)
        self.sequences[sequence_ast["name"]] = {
            "sequence": sequence_ast["value"],
            "start": self.sequence_counter,
            "end": new_sequencer_counter_val - 1
        }
        self.sequence_counter = new_sequencer_counter_val

    @staticmethod
    def single_step(_):
        return {"steps": 1}

    @staticmethod
    def state_changes(state_change_ast):
        return dict(zip(state_change_ast[::2], state_change_ast[1::2]))

    @staticmethod
    def steps(steps_ast):
        return {"steps": sum(i for x in steps_ast for i in x.values())}

    @staticmethod
    def signal(signal_ast):
        state_changes, steps = signal_ast
        if state_changes == {}:
            return steps
        else:
            return signal_ast

    def subsequence(self, subsequence_ast):
        return self.sequences[subsequence_ast]["sequence"]

    @staticmethod
    def sequence_body(sequence_body_ast):
        def merge_sequences(s1, s2):
            if "steps" in s1[-1] and "steps" in s2[0]:
                return s1[:-1] + [{"steps": s1[-1]["steps"] + s2[0]["steps"]}] + s2[1:]
            else:
                return s1 + s2

        return reduce(merge_sequences, sequence_body_ast)

    @staticmethod
    def frame(frame_ast):
        out = frame_ast["body"]
        for d in out:
            d["frame"] = True
        return out

    @staticmethod
    def constant(constant_ast):
        return int(constant_ast)

    def predefined_symbol(self, symbol_name):
        return self.parameters[symbol_name]

    @staticmethod
    def value(value_ast):
        return value_ast["value"]

    @staticmethod
    def term(term_ast):
        val, ops = term_ast
        for op, val2 in zip(ops[::2], ops[1::2]):
            if op == "*":
                val *= val2
            elif op == "/":
                val /= val2
            else:
                raise ParseException("Unsupported term operation: {op} (must be * or /)".format(op=op))
        return val

    @staticmethod
    def expression(expression_ast):
        val, ops = expression_ast
        for op, val2 in zip(ops[::2], ops[1::2]):
            if op == "-":
                val -= val2
            elif op == "+":
                val += val2
            else:
                raise ParseException("Unsupported expression operation: {op} (must be - or +)".format(
                    op=op
                ))
        return val


def parse(text):
    """Parses some SequencerDSL text into an AST"""
    from SequencerDSLParser import SequencerDSLParser
    comment_stripped_text = strip_block_comments(text)
    parser = SequencerDSLParser(whitespace='\t ;\n')
    semantics = Semantics()
    abstract_syntax_tree = parser.parse(comment_stripped_text,
                                        rule_name='readout',
                                        semantics=semantics)
    abstract_syntax_tree["parameters"] = semantics.parameters
    abstract_syntax_tree["sequences"] = semantics.sequences
    return abstract_syntax_tree


def parse_file(file_name):
    """Parses a file containing SequencerDSL text into an AST"""
    if isinstance(file_name, basestring):
        f = open(file_name)
    elif hasattr(file_name, 'read'):
        f = file_name
    else:
        raise RuntimeError("Cannot read FPE program from object with type {0}".format(type(file_name)))
    out = f.read()
    if hasattr(f, 'close'):
        f.close()
    return parse(out)


if __name__ == "__main__":
    from sys import argv
    import json

    ast = parse_file(argv[1])
    print(json.dumps(ast, indent=2))
