#!/bin/env python3

import re
import subprocess
import os

FILENAME = "Geometria.mo"

os.system("clear")

with open(FILENAME) as f:
    content = f.read()

identifiers = re.findall(r"test_\w+", content)
identifiers = list(set(identifiers))

for i in identifiers:
    print(f" - {i}")

with open("tmp_simulate.mos", mode="w+") as f:
    f.write(f'loadFile("{FILENAME}"); getErrorString();\n')
    f.write('cd("/tmp");')
    for i in identifiers:
        f.write(f"simulate({i}); getErrorString();\n")

result = subprocess.run(['omc', './tmp_simulate.mos'], stdout=subprocess.PIPE)
result = result.stdout.decode()

result = "\n".join(filter(lambda line: "time" not in line, result.split("\n")))

# result = "\n".join(filter(lambda s: s.startswith("assert") and "error" in s, result.split("\n")))
print(result)
