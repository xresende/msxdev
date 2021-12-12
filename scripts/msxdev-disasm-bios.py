#!/usr/bin/python3

# coding=utf-8
#
# msxdis - a MSX disassembler package
#
# Copyright (C) 2019 Ximenes R. Resende (xresende@gmail.com)
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


import sys

from msxdev import MSXDisasm


def msxbios_sysbeg(rom, beg, end):
    # rom.add_comment_ins(addr=0x0006, comment='Port address for VDP data read')
    # rom.add_comment_ins(addr=0x0007, comment='Port address for VDP data write')
    rom.add_dw(0x0004)
    rom.add_db([
        0x0006, 0x0007, 0x000B, 0x000F, 0x0013, 
        0x0017, 0x001B, 0x001F, 0x0023, 0x0027])    
    rom.add_db([0x002B, 0x002C])
    rom.add_db(0x002D, 0x0030)
    rom.add_db(0x0033, 0x0038)
    
    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_ioinij(rom, beg, end):

    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_vdprmc(rom, beg, end):

    rom.add_db(0x0065)
    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_psgini(rom, beg, end):

    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_inpprt(rom, beg, end):

    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_joystk(rom, beg, end):

    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_tapect(rom, beg, end):

    rom.add_docstring(beg, [
        '', 'Following are used to access the cassette tape, ',
        'data read/write, and motor on/off', '', ])
    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_basicq(rom, beg, end):

    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_basgrp(rom, beg, end):

    rom.add_db(0x015C, 0x01B6) 
    # rom.add_comment_ins(addr=0x015C, comment='RESERVED FOR EXPANSION - start')
    # rom.add_comment_ins(addr=0x01B5, comment='RESERVED FOR EXPANSION - end')
    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_slotsm(rom, beg, end):

    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_chkram(rom, beg, end):
    
    rom.add_skip(0x033B)
    rom.add_skip(0x039E)
    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_iscntc(rom, beg, end):
    
    rom.add_instruction_comment(0x03FB, 'Is BASIC text in ROM')
    rom.add_instruction_comment(0x03FF, 'Yes')
    rom.add_instruction_comment(0x0401, 'Seen any interesting key')
    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_initio(rom, beg, end):

    rom.add_db([0x0508, 0x0509, 0x050A, 0x050B, 0x050C, 0x050D])
    rom.add_instruction_comment(0x0508, 'default octave')
    rom.add_instruction_comment(0x0509, 'default note length')
    rom.add_instruction_comment(0x050A, 'default tempo')
    rom.add_instruction_comment(0x050B, 'default volume')
    rom.add_instruction_comment(0x050C, 'default envelope period')
    rom.add_instruction_comment(0x050D, 'end of music table')
    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios_vdputi(rom, beg, end):

    rom.add_skip(0x0674)
    rom.add_replace(0x0677, '1538', 'SETGRP')
    rom.disassemble(beg, end)
    print(rom.to_string())


def msxbios(rom_fname):
    """MSX BIOS Disassembler."""
    rom = MSXDisasm()
    rom.load_system_rom(rom_fname)

    msxbios_sysbeg(rom, 0x0000, 0x0038)
    msxbios_ioinij(rom, 0x0038, 0x0041)
    msxbios_vdprmc(rom, 0x0041, 0x0090)
    msxbios_psgini(rom, 0x0090, 0x009B)
    msxbios_inpprt(rom, 0x009C, 0x00D5)
    msxbios_joystk(rom, 0x00D5, 0x00E1)
    msxbios_tapect(rom, 0x00E1, 0x00F6)
    msxbios_basicq(rom, 0x00F6, 0x00FC)
    msxbios_basgrp(rom, 0x00FC, 0x01B6)
    msxbios_slotsm(rom, 0x01B6, 0x02D7)
    msxbios_chkram(rom, 0x02D7, 0x03FB)
    msxbios_iscntc(rom, 0x03FB, 0x046F)
    msxbios_initio(rom, 0x049D, 0x050E)
    msxbios_vdputi(rom, 0x050E, 0x085D)


if __name__ == "__main__":

    print(sys.argv)
    if len(sys.argv) > 1:
        rom_fname = sys.argv[1]
    else:
        rom_fname = './EXPERT10.ROM'
    
    print(rom_fname)
    msxbios(rom_fname)


