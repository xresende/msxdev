# coding=utf-8
#
# MSXDev - a Python Development Package for MSX
#
# Copyright (C) 2019 Ximenes R. Resende (xresende@gmail.com)
#   https://github.com/xresende/msxdev
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

from .z80dis import disassemble as _disassemble
from .symbols import MSXSymbol
from .symbols import SYMBOLS_BIOS, DOCS_BIOS
from .symbols import SYMBOLS_SYSVARS, DOCS_SYSVARS


class MSXInstLine:
    """."""

    class Line:
        """."""
        
        def __init__(self, pc, data, label, inst, comd, comi, isdw=False):
            self.pc = pc
            self.data = data
            self.label = label
            self.inst = inst
            self.comd = comd
            self.comi = comi
            self.isdw = isdw

        @property
        def size(self):
            return len(self.data)

        def to_string(self, org=0x0000):
            fmt_pc = '{:<6s}'
            fmt_dt = '{:<15s}'
            fmt_lb = '{:<12s}'
            fmt_in = '{:<25s}'
            fmt_ci = '{:<20s}'
            fmt_cd = '{:<40s}'
            stn = ''
            _cd = ';  ' + self.comd if self.comd is not None else ''
            if _cd:
                _pc = ' ' * len(fmt_pc.format(''))
                _dt = ' ' * len(fmt_dt.format(''))
                stn += fmt_pc.format(_pc) + ' '
                stn += fmt_dt.format(_dt) + ' '
                stn += fmt_cd.format(_cd)
            else:
                _pc = '0x{:04X}'.format(self.pc) if self.pc is not None else ''
                _dt = ' '.join(['{:02X}'.format(d) for d in self.data]) if self.data else ''
                _lb = self.label + ':' if self.label else ''
                _in = self.inst if self.inst else ''
                _ci = '; ' + self.comi if self.comi else ''
                stn += fmt_pc.format(_pc) + ' '
                stn += fmt_dt.format(_dt) + ' '
                stn += fmt_lb.format(_lb) + ' '
                stn += fmt_in.format(_in) + ' '
                stn += fmt_ci.format(_ci)
            stn += '\n'
            return stn

    def __init__(self, org, memory, 
        symbols, replaces_at_pc, skip, comments_inst, comments_docs,
        dw, db):
        """."""
        self._org = org
        self._memory = memory
        self._symbols = symbols
        self._replaces_at_pc = replaces_at_pc
        self._skip = skip
        self._comments_inst = comments_inst
        self._comments_docs = comments_docs
        self._dw = dw
        self._db = db
        self._lines = list()

    @property
    def org(self):
        return self._org

    @property
    def pc(self):
        if self._lines:
            return self[0].pc
        else:
            return None

    @property
    def size(self):
        val = 0
        for line in self._lines:
            val += line.size
        return val
        
    def __getitem__(self, idx):
        return self._lines[idx]

    def build(self, pc):
        """."""
        self._lines = []

        if pc in self._comments_docs:
            # add docstring comments
            self._add_comments_docs(pc)

        if pc in self._dw:
            # add dw
            self._add_dw(pc)
        elif self._check_pc_in_db(pc):
            # add db
            self._add_db(pc)
        else:
            # add instruction
            self._add_instruction(pc)
    
    def get_lines(self):
        return self._lines[:]

    def _check_pc_in_db(self, pc):
        for lst in self._db:
            if pc == lst[0]:
                return True
        return False

    def _add_label(self, pc):
        sym = self._symbols[pc]
        label = sym.label
        line = MSXInstLine.Line(pc=None, data=[],
            label=label, inst='', comd=None, comi='')
        self._lines.append(line)

    def _add_db(self, pc):
        for lst in self._db:
            if pc == lst[0]:
                break

        size = lst[-1] - lst[0]
        data = self.fetch(pc, size)
        # print(size, data)
        # addr = MSXInstLine.conv_data2addr(data)

        # label line?
        if pc in self._symbols:
            sym = self._symbols[pc]
            label = self._symbols[pc].label
            comi = sym.comi
        else:
            label = ''
            comi = ''
        if pc in self._comments_inst:
            comi = self._comments_inst[pc]
        
        ndb = 5
        nlines = 1 + int((size-1) // ndb)
        for ln in range(nlines):
            data_ = []
            for i in range(5):
                if ln*ndb+i >= len(data):
                    break
                data_.append(data[ln*ndb+i])
            inst = 'db   ' + ','.join(['{:02X}h'.format(v) for v in data_])
            if pc in self._comments_inst:
                comi = self._comments_inst[pc]
            line = MSXInstLine.Line(pc=pc, data=data_, 
                label=label, inst=inst, comd=None, comi=comi, isdw=False)
            pc += len(data_)
            label = '' 
            self._lines.append(line)

    def _add_dw(self, pc):
        data = self.fetch(pc, 2)
        addr = MSXInstLine.conv_data2addr(data)
        
        # label line?
        if pc in self._symbols:
            sym = self._symbols[pc]
            label = self._symbols[pc].label
            comi = sym.comi
        else:
            label=''
            comi = ''

        # symbol replace?
        if addr in self._symbols: 
            addr = self._symbols[addr].label
        else:
            addr = '0x{:04X}'.format(addr)

        inst='dw   {}'.format(addr)
        if isinstance(comi, (list, tuple)):
            for comi_ in comi:
                line = MSXInstLine.Line(pc=pc, data=data, 
                    label=label, inst=inst, comd=None, comi=comi_, isdw=True)
                self._lines.append(line)
                pc, data, label, inst = None, [], '', ''  
        else: 
            line = MSXInstLine.Line(pc=pc, data=data,
                label=label, inst=inst, comd=None, comi=comi, isdw=True)
            self._lines.append(line)

    def _add_instruction(self, pc):
        # disassemble
        inst, size, addr = _disassemble(self._memory, pc, self._org)
    
        # general replace
        if pc in self._replaces_at_pc:
            rep = self._replaces_at_pc[pc]
            inst = inst.replace(rep[0], rep[1])
        
        if pc in self._symbols:
            # add label
            self._add_label(pc)

        label = ''
        comi = ''
        # symbol replace?
        if addr is not None:
            addr_ = '0x' + addr[:-1] if addr.endswith('h') else addr
            addr_ = int(addr_, base=16)
        else:
            addr_ = addr
        if addr_ is not None and addr_ in self._symbols and pc not in self._skip:
            sym = self._symbols[addr_]
            inst = inst.replace(addr, sym.label)
            comi = sym.comi
        if pc in self._comments_inst:
            comi = self._comments_inst[pc]
        
        data = self.fetch(pc, size)
        if isinstance(comi, (list, tuple)):
            for comi_ in comi:
                line = MSXInstLine.Line(pc=pc, data=data,
                    label=label, inst=inst, comd=None, comi=comi_)
                self._lines.append(line)
                pc, data, label, inst = None, [], '', ''
        else:
            line = MSXInstLine.Line(pc=pc, data=data,
                label=label, inst=inst, comd=None, comi=comi)
            self._lines.append(line)
        
    def _add_comments_docs(self, pc):
        comments = self._comments_docs[pc]
        for comd in comments:
            line = MSXInstLine.Line(pc=None, data=[],
                label='', inst='', comd=comd, comi='')
            self._lines.append(line)
    
    def fetch(self, pc, nrbytes):
        pc = pc
        if pc + nrbytes < len(self._memory):
            return self._memory[pc:pc+nrbytes]
        else:
            return []

    @staticmethod
    def conv_data2addr(data):
        return (data[1] << 8) + data[0]


class MSXDisasm:
    """."""

    _SYMBOLS = dict()
    _SYMBOLS.update(SYMBOLS_BIOS)
    _SYMBOLS.update(SYMBOLS_SYSVARS)

    _DOCS = dict()
    _DOCS.update(DOCS_BIOS)
    _DOCS.update(DOCS_SYSVARS)

    def __init__(self):
        """."""
        self._memory = None
        self._org = None
        self._rom_id = None
        self._rom_init = None
        self._rom_statement = None
        self._rom_device = None
        self._rom_text = None
        self._rom_reserved = None
        self._msxline = None
        self._symbols = MSXDisasm._SYMBOLS
        self._replaces_at_pc = dict()
        self._skip = list()
        self._comments_inst = dict()
        self._comments_docs = MSXDisasm._DOCS
        self._dw = list()
        self._db = list()
        self._lines = list()

    @property
    def org(self):
        return self._org

    @property
    def memory(self):
        return self._memory

    def add_replace(self, pc, str_orig, str_final):
        self._replaces_at_pc[pc] = (str_orig, str_final)

    def add_skip(self, pc):
        if isinstance(pc, int):
            pc = [pc, ]
        self._skip += pc
        self._update_msxline()

    def add_docstring(self, pc, docstring):
        """."""
        if isinstance(docstring, str):
            docstring = [docstring, ]
        self._comments_docs[pc] = docstring
        self._update_msxline()

    def add_instruction_comment(self, pc, comment):
        """."""
        self._comments_inst[pc] = comment

    def add_dw(self, pc):
        self._dw.append(pc)
        self._update_msxline()

    def add_db(self, addr_beg, addr_end=None):
        """Add db command at specific addresses."""
        if isinstance(addr_beg, (list, tuple)):
            for addr in addr_beg:
                self._db.append([addr, addr+1])
        else:
            addr_end = addr_beg + 1 if addr_end is None else addr_end
            self._db.append([addr_beg, addr_end])
        self._update_msxline()
        
    def disassemble(self, pc_start, pc_end):
        self._lines = []
        pc = pc_start
        while pc < pc_end:
            self._msxline.build(pc=pc - self.org)
            self._lines += self._msxline.get_lines()
            pc += self._msxline.size

    def load_system_rom(self, fname):
        """."""
        self._memory = MSXDisasm._get_data_from_file(fname)
        self._org = 0x0000
        self._update_msxline()

    def load_rom(self, fname):
        """."""
        data = MSXDisasm._get_data_from_file(fname)
        self._memory, org, pc = self._check_rom(data)
        self._org = org
        self._rom_id = 'AB'
        self._rom_init = '0x{:04X}'.format(pc)
        self._rom_statement = '0x{:04X}'.format((data[5] << 8) + data[4])
        self._rom_device = '0x{:04X}'.format((data[7] << 8) + data[6])
        self._rom_text = '0x{:04X}'.format((data[9] << 8) + data[8])
        self._rom_reserved = \
            '0x{:02X}{:02X},0x{:02X}{:02X},0x{:02X}{:02X}'.format(
                data[0x0b], data[0x0a], 
                data[0x0f], data[0x0d],
                data[0x0f], data[0x0e])
        self._update_msxline()

    def to_string(self):
        stn = ''
        for line in self._lines:
            stn += line.to_string(org=self.org)
        return stn

    def _update_msxline(self):
        self._msxline = MSXInstLine(
            org=self.org, memory=self.memory,
            symbols=self._symbols,
            replaces_at_pc=self._replaces_at_pc,
            skip=self._skip,
            comments_inst=self._comments_inst,
            comments_docs=self._comments_docs,
            dw=self._dw,
            db=self._db,
            )

    def _check_rom(self, data):
        if data[0] != 0x41 or data[1] != 0x42:
            raise TypeError
        memory = data
        pc = (data[3] << 8) + data[2]
        if pc < 0x4000:
            org = 0x0000
        elif pc < 0x8000:
            org = 0x4000
        elif pc < 0xc000:
            org = 0x8000
        else:
            raise ValueError
        return memory, org, pc

    @staticmethod
    def _get_data_from_file(fname):
        data = []
        with open(fname, 'rb') as fp:
            byte = fp.read(1)
            while byte:
                data.append(byte)
                byte = fp.read(1)
        data = bytearray([ord(b) for b in data])
        return data
