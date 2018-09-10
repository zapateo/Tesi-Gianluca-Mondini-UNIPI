#!/bin/env python3

import re
import subprocess
import os
import sys

FILENAMES = ["Geometria.mo", "VoronoiCell.mo"]

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

os.system("clear")

content = ""
for filename in FILENAMES:
    with open(filename) as f:
        content += f.read()

identifiers = re.findall(r"test_\w+", content)
identifiers = list(set(identifiers))

with open("tmp_simulate.mos", mode="w+") as f:
    for filename in FILENAMES:
        f.write(f'loadFile("{filename}"); getErrorString();\n')
    f.write('cd("/tmp");')
    for i in identifiers:
        f.write(f"simulate({i}); getErrorString();\n")

result = subprocess.run(['omc', './tmp_simulate.mos'], stdout=subprocess.PIPE)
result = result.stdout.decode()

if "--raw" in sys.argv:
    print(result)
else:
    for func in [
        lambda line: not line.startswith("    time"),
        lambda line: "record SimulationResult" not in line,
        lambda line: "end SimulationResult" not in line,
        lambda line: line != '""',
        lambda line: line != 'true',
    ]:
        result = "\n".join(filter(func, result.split("\n")))
    result = result.replace("The simulation finished successfully.", bcolors.OKGREEN + "The simulation finished successfully!" + bcolors.ENDC)
    result = result.replace("assert", bcolors.FAIL + "assert" + bcolors.ENDC)
    print(result)
