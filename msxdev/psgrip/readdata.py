#!/usr/bin/env python3


import matplotlib.pyplot as plt


def read_datafile(fname):
    with open(fname) as fp:
        data = fp.read()
    lines = []
    for line in data.splitlines():
        counter, line = line.split(' ', 1)
        cpu_tick, instruction = line.split(' ', 1)
        lines.append((int(counter), int(cpu_tick), instruction))
    return lines


def find_blocks(lines, dtick_threshold):
    dtick = []
    for i in range(1, len(lines)):
        t1, t0 = lines[i][1], lines[i-1][1]
        dtick.append(t1 - t0)
    
    blocks = []
    last_i = 0
    for i in range(len(dtick)):
        if dtick[i] > dtick_threshold:
            blocks.append((last_i, i+1))
            last_i = i+1
    return dtick, blocks


def add_routines(routines, label, lines):
    def check_lines(lines, routine):
        for i in range(len(lines)):
            if lines[i][2] != routine[i][2]:
                return False
        return True
    labels = routines.keys()
    found = False
    for label_ in labels:
        routine = routines[label_]
        if len(lines) != len(routine):
            continue
        if not check_lines(lines, routine):
            continue
        label = label_
        found = True
        break
    if not found:
        routines[label] = lines
    return label


def define_block_routines(lines, blocks):
    routines = dict()
    newlines = []
    for block in blocks:
        i1, i2 = block
        counter, cpu_tick, instruction = lines[i1]
        label = 'R' + '{:04d}'.format(len(routines))
        label = add_routines(routines, label, lines[i1:i2])
        newlines.append((counter, cpu_tick, 'call {}'.format(label)))
    return newlines, routines



def asm_header():
    
    text = """
ENASLT:         equ 0x0024          ; Mapeia slot
INITXT:         equ 0x006C          ; Inicializa VDP em modo texto 40x24
CHPUT:          equ 0x00A2          ; Escreve caractere na tela
RSLREG:         equ 0x0138          ; Lê registrador do slot primário
EXPTBL:         equ 0xFCC1          ; 4 slots, (0x00=não expandido, 0x80=expandido)

LF:             equ 0Ah
CR:             equ 0Dh
PageSize:       equ 4000h           ; 16kB


     org &4000h
    
; --- ROM header ---

     db  "AB"                       ; ID for auto-executable ROM
     dw  INIT                       ; Main program execution address
     dw  0                          ; STATEMENT
     dw  0                          ; DEVICE
     dw  0                          ; TEXT
     dw  0,0,0                      ; Reserved

     ds 4091h - $,255               ; Fill the unused  with 0FFh
     
INIT:	; Program code entry point label

; Typical routine to select the ROM on page 8000h-BFFFh from page 4000h-7BFFFh

 	call RSLREG
  	rrca
 	rrca
 	and	3	               ; Keep bits corresponding to the page 4000h-7FFFh
 	ld	c,a
 	ld	b,0
 	ld	hl,EXPTBL
 	add	hl,bc
 	ld	a,(hl)
 	and	80h
 	or	c
 	ld	c,a
 	inc	hl
 	inc	hl
 	inc	hl
 	inc	hl
 	ld	a,(hl)
 	and	0Ch
 	or	c
 	ld	h,080h
 	call ENASLT		     ; Select the ROM on page 8000h-BFFFh

    di
    call INITXT
    
    ld	hl,text1         ; Text pointer into HL
    call  print		     ; Call the routine print below

    call PLAY

    ld   hl,text2        ; Text pointer into HL
    call print           ; Call the routine print below

_halt:
     jr  _halt
    
print:
 	ld	a,(hl)		; Load the byte from memory at address indicated by HL to A.
 	and	a		    ; Same as CP 0 but faster.
 	ret	z		    ; Back behind the call print if A = 0
 	call CHPUT		; Call the routine to display a character.
 	inc	hl		    ; Increment the HL value.
 	jr	print		; Relative jump to the address in the label Print.

text1:			; Text pointer label
 	db "MSX PSG Rip Off by Ximenes R. Resende",LF,CR	
     db LF,CR
     db "playing ... ",0
text2:
     db "finished.",LF,CR,0

wait88:
;    88 time cycles: 24.55 us @ CLOCK_FREQ = 3584160 Hz
;    TOTAL: 37 + BC * 88 time cycles
;
;    ld      bc, XXXX  ; -- 10
;    call    wait88    ; -- 17
     ld      a,c       ; 4
     bit     #0,a      ; 8
     bit     #0,a      ; 8
     bit     #0,a      ; 8
     bit     #0,a      ; 8
;    bit     #0,a      ; 8
;    bit     #0,a      ; 8
;    bit     #0,a      ; 8
     and     255       ; 7
     and     255       ; 7
     dec     bc        ; 6
     ld      a,c       ; 4
     or      b         ; 4
     jp      nz,wait88 ; 10
     ret               ; -- 10
    """

    for line in text.splitlines():
        print(line)


def asm_end():
    print()
    print()
    print('fill:')
    print('     ds PageSize - ($ - 8000h),255	; Fill the unused area with 0xFF')


def generate_asm2(newlines, routines):

    asm_header()

    print('PLAY:')
    last_tick = None
    i = 0
    while i < len(newlines):
        _, cpu_tick, inst = newlines[i]
        j=i+1
        while j < len(newlines) and newlines[j][2] == inst:
            cpu_tick = newlines[j][1]
            j += 1
        i = j - 1
        if last_tick is None:
            last_tick = cpu_tick
        dtime = cpu_tick - last_tick
        if dtime:
            # 37 + BC * 88 time cycles
            div = int((dtime - 37) // 88)
            res = dtime - (37 + div * 88)
            div2 = int(div // 0xffff)
            res2 = div - div2 * 0xffff
            # print('     ; wait for {} time cycles'.format(dtime))
            for _ in range(div2):
                print('     ld  bc, 0FFFFh')
                print('     call wait88')
            print('     ld  bc, {}'.format(res2))
            print('     call wait88 ; (lack {})'.format(res))
        print('     ' + inst)
        last_tick = cpu_tick
        i += 1
        # break
    print('     ret')
    
    print(';')
    print('; --- VDP interaction subroutines ---')
    print(';')
    for label, routine in routines.items():
        print(label + ':')
        for line in routine:
            _, reg, val = line[2].split()
            # reg = reg.replace('(','').replace('),','')
            print(' '*len(label) + 'ld  a,{}'.format(val))
            print(' '*len(label) + 'out {} a'.format(reg))
        print('     ret')

    asm_end()


def generate_asm(newlines, routines):

    print('PLAY:')
    last_tick = None
    for line in newlines:
        _, cpu_tick, inst = line
        if last_tick is None:
            last_tick = cpu_tick
        dtime = cpu_tick - last_tick
        if dtime:
            # 37 + BC * 88 time cycles
            div = int((dtime - 37) // 88)
            res = dtime - (37 + div * 88)
            div2 = int(div // 0xffff)
            res2 = div - div2 * 0xffff
            print('     ; wait for {} time cycles'.format(dtime))
            for _ in range(div2):
                print('     ld  bc, 0xFFFF')
                print('     call wait88')
            print('     ld  bc, {}'.format(res2))
            print('     call wait88')
            print('     ; lacking {} cycles'.format(res))
        print('     ' + inst)
        last_tick = cpu_tick
    print('     ret')
    
    print(';')
    print('; --- VDP interaction subroutines ---')
    print(';')
    for label, routine in routines.items():
        print(label + ':')
        for line in routine:
            _, reg, val = line[2].split()
            # reg = reg.replace('(','').replace('),','')
            print(' '*len(label) + 'ld  a,{}'.format(val))
            print(' '*len(label) + 'out {} a'.format(reg))
        print('     ret')

    print()
    print()
    print('fill:')
    print('     ds PageSize - ($ - 8000h),255	; Fill the unused aera with 0FFh')


def process_inst_file(fname, dtick_thresdold, plot_dtick):
    lines = read_datafile(fname)
    dtick, blocks = find_blocks(lines, dtick_thresdold)
    if plot_dtick:
        plt.plot(dtick, 'o')
        plt.xlabel('Instruction order')
        plt.ylabel('Instruction Clock Tick Separation')
        plt.show()
    return lines, dtick, blocks


lines, dtick, blocks = process_inst_file('psg.txt', 10000, False)
fname = 'psg.txt'

# for block in blocks:
#     print('({},{}):'.format(*block))
#     for i in range(*block):
#         print(lines[i])

   
newlines, routines = define_block_routines(lines, blocks)


# counter = 1
# for line in newlines:
#     # print(line)
#     _, tick, inst = line
#     _, label = inst.split()
#     if label not in routines:
#         continue
#     # print(label)
#     lines = routines[label]
#     # print(lines)
#     for line_ in lines:
#         print('{:06d} {:012d} {}'.format(counter, line_[1], line_[2]))
#         counter += 1
    
generate_asm2(newlines, routines)

