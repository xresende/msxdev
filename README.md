# MSXDEV

Python tools for MSX development

## MSXSymbols Class
To manipule MSX BIOS and BASIC assembly symbols

## MSXDisasm Class
To disassemble MSX Z80 code using BIOS/BASIC symbols and allowing for 
format specification, docstrings, line-by-line choice of hex/dec/bin 
value representation, and so on.

## Package Installation:

Run `make install`

## Exaples of package usage:

```Python3

from msxdev import MSXDisasm

rom_fname = './GOONIES.ROM' # replace with ROM filename
rom = MSXDisasm()
rom.load_rom(rom_fname)
rom.disassemble(beg, end)
print(rom.to_string())
```
## Scripts installed

- `msxdev-disasm-bios.py`



