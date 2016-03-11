#!/usr/bin/env python2.7

data_type_codes = {
    "no_data": 0b10,
    "pixel_data": 0b00
}


def compile_do_program(program_ast, sequences):
    """Compile a do loop program into a number"""
    res = []
    for p in program_ast["body"]:
        output = 0
        start = sequences[p["sequence"]]["start"]
        end = sequences[p["sequence"]]["end"]
        output |= start << 37
        output |= end << 27
        output |= p["RPT"] << 13
        output |= data_type_codes[p["DATA_TYPE"]] << 1
        output |= 1 if "frame" in program_ast else 0
        res.append(output)
    output = 0
    output |= 1 << 26
    output |= program_ast["do"] << 13
    output |= program_ast["body"][0]["idx"] << 4
    output |= 0b10 << 1
    output |= 1 if "frame" in program_ast else 0
    res.append(output)
    return res


def compile_ordinary_program(program_ast, sequences):
    """Compile a program into a number"""
    if program_ast["sequence"] not in sequences:
        raise Exception("Unknown sequence: " + program_ast["sequence"])
    output = 0
    start = sequences[program_ast["sequence"]]["start"]
    end = sequences[program_ast["sequence"]]["end"]
    output |= start << 37
    output |= end << 27
    output |= program_ast["RPT"] << 13
    output |= data_type_codes[program_ast["DATA_TYPE"]] << 1
    output |= 1 if "frame" in program_ast else 0
    return [output]


def compile_program(program_ast, sequences):
    """Compile a program, either a do program or a regular program"""
    if "do" in program_ast:
        return compile_do_program(program_ast, sequences)
    else:
        return compile_ordinary_program(program_ast, sequences)


def hold_program(sequence_name, sequences):
    """Compile a hold program into a number"""
    if sequence_name not in sequences:
        raise Exception("Unknown sequence: " + sequence_name)
    output = 0
    start = sequences[sequence_name]["start"]
    end = sequences[sequence_name]["end"]
    output |= start << 37
    output |= end << 27
    output |= 1 << 3  # hold bit
    output |= data_type_codes["no_data"] << 1
    return [output]


def number_programs(programs):
    idx = 0
    for i in range(len(programs)):
        p = dict(programs[i])
        if "do" in p:
            for j in range(len(p["body"])):
                q = dict(p["body"][j])
                q["idx"] = idx
                idx += 1
                p["body"][j] = q
        p["idx"] = idx
        idx += 1
        programs[i] = p


def compile_programs(ast):
    """Compile a list of programs in an ast into a list of numbers"""
    sequences = ast["sequences"]
    number_programs(ast["programs"])
    output = [y for x in ast["programs"] for y in compile_program(x, sequences)] + hold_program(ast["hold"], sequences)
    if len(output) > 512:
        raise Exception("Program contains too many instructions, has {} instructions".format(len(output)))
    return output + (512 - len(output)) * [0]


def compile_programs_from_file(file_name):
    from parse import parse_file
    return compile_programs(parse_file(file_name))


if __name__ == "__main__":
    from sys import argv
    from pprint import pprint

    out = compile_programs_from_file(argv[1])
    pprint(out)
