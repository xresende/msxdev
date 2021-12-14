#!/usr/bin/env python3

from msxdev import MSXBasic


text = """
10 goto
20 gosub 25
"""

print(text)

bas = MSXBasic()
bas.load_basic(fname=None, text=text)

print(bas.to_string())
for line in bas.lines:
    print(line)
