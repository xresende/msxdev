# coding=utf-8
#
# msxdis - a MSX disassembler package
#
# Copyright (C) 2019 Ximenes R. Resende
#   https://github.com/xresende/msxdis
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


import os as _os


class MSXSymbol:
    """."""

    def __init__(self, addr, label, comi):
        self.addr = addr
        self.label = label
        self.comi = comi

    @property
    def addr_hexstr(self):
        return MSXSymbol.conv_addr_int2hexstr(self.addr)

    @staticmethod
    def conv_addr_int2hexstr(addr):
        """."""
        return '0x{:04X}'.format(addr)

    @staticmethod
    def load_symbols(fname):
        """."""
        # get gata from file
        with open(fname, 'r') as fp:
            text = fp.read().splitlines()

        symbols, docstrings_ = dict(), []
        for line in text:
            line = line.lstrip().rstrip()
            if not line:  # empty line
                continue
            if line[0] == ';':  # a docstring or file comment line
                docstrings_.append(line)
                continue

            # get label/symbol
            line.replace(' EQU ', ' equ ')
            words = line.split(':', 1)
            if len(words)<2:
                raise ValueError('Missing label definition in line "{}" !'.format(line))
            symbol = words[0].replace(':','')

            # get addr
            words = ''.join(words[1:]).lstrip()
            if not words.startswith('equ'):
                raise ValueError('Missing equ in line "{}" !'.format(line))
            words = words[3:].lstrip()
            addr, words = words.split(' ', 1)

            # get instrution comments
            words = words.lstrip()
            comments = ''
            if words[0] == ';':
                    words = words[1:]
                    if words:
                        words = words if words[0] != ' ' else words[1:]
                        comments = words.split('\\n')
                        for i in range(len(comments)):
                            comments[i] = comments[i] if comments[i][0] != ' ' else comments[i][1:]
    
            # add data to symbols dictionary
            addr_ = int(addr, base=16)
            symbols[addr_] = MSXSymbol(addr_, symbol, comments)

        # process docstrings:
        symbols_ = {symbols[addr].label: addr for addr in symbols} # build label -> address dict
        addr, comments = 'esc', []
        docstrings = dict()
        for line in docstrings_:
            line = line[1:].lstrip()
            if line and line[0] == '[' and ']' in line:
                MSXSymbol._add_docstring_comment(symbols_, addr, comments, docstrings)
                addr, *_ = line[1:].split(']')
                comments = []
                continue
            if addr not in ('esc', 'ESC'):
                comments.append(line)
        MSXSymbol._add_docstring_comment(symbols_, addr, comments, docstrings)
        return symbols, docstrings
                
    @staticmethod
    def _add_docstring_comment(symbols, addr, comments, docstrings):
        if addr not in ('esc', 'ESC'):
            addr_ = symbols.get(addr, addr) # if addr is symbol
            addr_ = int(addr_, base=16) if isinstance(addr_, str) else addr_
            docstrings[addr_] = comments

    
_BIOS_PATH = _os.path.join(
    _os.path.dirname(__file__), 'bios.asm')
_SYSVARS_PATH = _os.path.join(
    _os.path.dirname(__file__), 'sysvars.asm')


SYMBOLS_BIOS, DOCS_BIOS = MSXSymbol.load_symbols(_BIOS_PATH)
SYMBOLS_SYSVARS, DOCS_SYSVARS = MSXSymbol.load_symbols(_SYSVARS_PATH)

msx1_ports = {
    'A8h': dict(symbol='PPI.AW', comments=None),
    'AAh': dict(symbol='PPI.CW', comments=None),
    'ABh': dict(symbol='PPI.CM', comments=None),
    }

