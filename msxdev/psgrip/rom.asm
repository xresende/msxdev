
ENASLT:         equ 0x0024          ; Mapeia slot
INITXT:         equ 0x006C          ; Inicializa VDP em modo texto 40x24
CHPUT:          equ 0x00A2          ; Escreve caractere na tela
RSLREG:         equ 0x0138          ; Lê registrador do slot primário
EXPTBL:         equ 0xFCC1          ; 4 slots, (0x00=não expandido, 0x80=expandido)

LF:             equ	0Ah
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
    
PLAY:
     call R0000
     ld  bc, 13090
     call wait88 ; (lack 20)
     call R0001
     ld  bc, 691
     call wait88 ; (lack 14)
     call R0002
     ld  bc, 116
     call wait88 ; (lack 87)
     call R0003
     ld  bc, 9762
     call wait88 ; (lack 48)
     call R0004
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0005
     ld  bc, 4067
     call wait88 ; (lack 39)
     call R0004
     ld  bc, 435
     call wait88 ; (lack 69)
     call R0001
     ld  bc, 20718
     call wait88 ; (lack 23)
     call R0006
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0005
     ld  bc, 183
     call wait88 ; (lack 19)
     call R0001
     ld  bc, 36426
     call wait88 ; (lack 82)
     call R0006
     ld  bc, 6141
     call wait88 ; (lack 5)
     call R0004
     ld  bc, 31284
     call wait88 ; (lack 12)
     call R0006
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0007
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0008
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0009
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0010
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0012
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0013
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0014
     ld  bc, 4880
     call wait88 ; (lack 86)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0015
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0016
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0017
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0010
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0012
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0013
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0018
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0016
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0017
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0010
     ld  bc, 12203
     call wait88 ; (lack 35)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0012
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0013
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0019
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0016
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0017
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0010
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0012
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0013
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0020
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0016
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0017
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0010
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0012
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0013
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0018
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0016
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0017
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0010
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0012
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0013
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0021
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0022
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0023
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0024
     ld  bc, 12203
     call wait88 ; (lack 37)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0025
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0026
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0027
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0028
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0029
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0030
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0025
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0026
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0031
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0028
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0029
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0030
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0025
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0026
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0032
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0028
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0029
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0030
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0025
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0026
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0031
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0028
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0029
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0030
     ld  bc, 7321
     call wait88 ; (lack 62)
     call R0011
     ld  bc, 4881
     call wait88 ; (lack 3)
     call R0033
     ld  bc, 39865
     call wait88 ; (lack 40)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0034
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0035
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0036
     ld  bc, 16271
     call wait88 ; (lack 46)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0037
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0038
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0039
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0040
     ld  bc, 1626
     call wait88 ; (lack 68)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0041
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0042
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0043
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0044
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0045
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0046
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0047
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0044
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0045
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0046
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0037
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0038
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0039
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0040
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0048
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0049
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0050
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0051
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0038
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0039
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0040
     ld  bc, 47187
     call wait88 ; (lack 84)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0041
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0042
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0036
     ld  bc, 18712
     call wait88 ; (lack 45)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0052
     ld  bc, 3253
     call wait88 ; (lack 80)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0053
     ld  bc, 42307
     call wait88 ; (lack 22)
     call R0011
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0052
     ld  bc, 0FFFFh
     call wait88
     ld  bc, 14197
     call wait88 ; (lack 14)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0054
     ld  bc, 2440
     call wait88 ; (lack 31)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0056
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0057
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0058
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0056
     ld  bc, 4881
     call wait88 ; (lack 7)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0059
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0060
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0061
     ld  bc, 1626
     call wait88 ; (lack 64)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0063
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0064
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0065
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0066
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0067
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0068
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0069
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0070
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0061
     ld  bc, 1626
     call wait88 ; (lack 62)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0071
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0072
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0073
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0067
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0059
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0060
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0061
     ld  bc, 1626
     call wait88 ; (lack 61)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0071
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0074
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0065
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0075
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0076
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0077
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0059
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0078
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0079
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0080
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0081
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0071
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0072
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0073
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0067
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0068
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0082
     ld  bc, 6508
     call wait88 ; (lack 29)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0054
     ld  bc, 2440
     call wait88 ; (lack 34)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0056
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0083
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0084
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0085
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0086
     ld  bc, 7322
     call wait88 ; (lack 6)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0087
     ld  bc, 1626
     call wait88 ; (lack 57)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0056
     ld  bc, 2440
     call wait88 ; (lack 39)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0088
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0089
     ld  bc, 10576
     call wait88 ; (lack 56)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0054
     ld  bc, 2440
     call wait88 ; (lack 27)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0056
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0083
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0084
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0085
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0086
     ld  bc, 12203
     call wait88 ; (lack 46)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0054
     ld  bc, 2440
     call wait88 ; (lack 28)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0056
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0083
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0084
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0085
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0086
     ld  bc, 3253
     call wait88 ; (lack 72)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0059
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0060
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0061
     ld  bc, 1626
     call wait88 ; (lack 66)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0063
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0064
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0065
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0066
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0067
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0068
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0059
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0090
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0091
     ld  bc, 1626
     call wait88 ; (lack 60)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0071
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0072
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0073
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0067
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0059
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0060
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0061
     ld  bc, 1626
     call wait88 ; (lack 59)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0071
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0074
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0065
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0075
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0076
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0077
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0059
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0078
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0079
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0080
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0081
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0071
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0062
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0072
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0073
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0067
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0068
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0082
     ld  bc, 6508
     call wait88 ; (lack 29)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0054
     ld  bc, 2440
     call wait88 ; (lack 31)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0056
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0083
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0084
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0085
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0086
     ld  bc, 7321
     call wait88 ; (lack 71)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0087
     ld  bc, 1626
     call wait88 ; (lack 65)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0056
     ld  bc, 2440
     call wait88 ; (lack 32)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0088
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0089
     ld  bc, 10576
     call wait88 ; (lack 36)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0054
     ld  bc, 2440
     call wait88 ; (lack 42)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0056
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0083
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0084
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0085
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0086
     ld  bc, 12203
     call wait88 ; (lack 45)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0054
     ld  bc, 2440
     call wait88 ; (lack 29)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0056
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0083
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0084
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0085
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0086
     ld  bc, 7321
     call wait88 ; (lack 79)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0087
     ld  bc, 1626
     call wait88 ; (lack 70)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0056
     ld  bc, 2440
     call wait88 ; (lack 33)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0088
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0089
     ld  bc, 10576
     call wait88 ; (lack 32)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0054
     ld  bc, 2440
     call wait88 ; (lack 34)
     call R0055
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0056
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0083
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0084
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0085
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0086
     ld  bc, 9762
     call wait88 ; (lack 78)
     call R0005
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0092
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0093
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0094
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0095
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0096
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0097
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0098
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0099
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0100
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0101
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0102
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0103
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0104
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0106
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0107
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0108
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0109
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0110
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0111
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0112
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0108
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0107
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0106
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0113
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0114
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0115
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0095
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0116
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0097
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0117
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0099
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0118
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0101
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0119
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0103
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0109
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0110
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0112
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0108
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0107
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0120
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0106
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0121
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0113
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0122
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0123
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0124
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0104
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0125
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0126
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0127
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0128
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0129
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0130
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0131
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0132
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0133
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0134
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0135
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0136
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0099
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0137
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0101
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0138
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0139
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0109
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0108
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0107
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0106
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0104
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0106
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0107
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0127
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0108
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0109
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0114
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0140
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0095
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0141
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0097
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0142
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0099
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0118
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0101
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0102
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0103
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0143
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0144
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0145
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0146
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0147
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0148
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0149
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0150
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0112
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0108
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0107
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0114
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0151
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0095
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0152
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0097
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0153
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0099
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0154
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0155
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0156
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0103
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0128
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0157
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0158
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0159
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0160
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0161
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0162
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0163
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0109
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0108
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0107
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0129
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0164
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0131
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0165
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0133
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0166
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0167
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0168
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0169
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0170
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0171
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0172
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0124
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0110
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0125
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0112
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0127
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0108
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0107
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0106
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0113
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0123
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0104
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0106
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0105
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0173
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0174
     ld  bc, 3253
     call wait88 ; (lack 79)
     call R0175
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0176
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0175
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0177
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0175
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0178
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0175
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0179
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0175
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0180
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0175
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0181
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0182
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0183
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0184
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0185
     ld  bc, 813
     call wait88 ; (lack 20)
     call R0186
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0187
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0177
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0175
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0188
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0175
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0179
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0189
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0190
     ld  bc, 813
     call wait88 ; (lack 18)
     call R0191
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0192
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0191
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0193
     ld  bc, 813
     call wait88 ; (lack 17)
     call R0194
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0195
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0191
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0196
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0197
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0198
     ld  bc, 813
     call wait88 ; (lack 19)
     call R0199
     ld  bc, 813
     call wait88 ; (lack 16)
     call R0200
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0201
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0202
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0203
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0204
     ld  bc, 813
     call wait88 ; (lack 15)
     call R0205
     ld  bc, 813
     call wait88 ; (lack 21)
     call R0206
     ld  bc, 813
     call wait88 ; (lack 14)
     call R0207
     ld  bc, 813
     call wait88 ; (lack 10)
     call R0208
     ld  bc, 813
     call wait88 ; (lack 12)
     call R0207
     ld  bc, 813
     call wait88 ; (lack 11)
     call R0209
     ld  bc, 813
     call wait88 ; (lack 13)
     call R0210
     ret
;
; --- VDP interaction subroutines ---
;
R0000:
     ld  a,10000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ret
R0001:
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0002:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ret
R0003:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ret
R0004:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ret
R0005:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0006:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0007:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,10101100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000011b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011000b
     out (0xA1), a
     ret
R0008:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ret
R0009:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ret
R0010:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0011:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0012:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0013:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0014:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,11000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,11000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0015:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,10101100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000011b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0016:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0017:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0018:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,10101100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000011b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0019:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000011b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0020:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,10101100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000011b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0021:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,11010110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000011b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0022:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0023:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0024:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0025:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0026:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0027:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0028:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0029:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0030:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0031:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00011100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0032:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0033:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ret
R0034:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0035:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0036:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,11000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0037:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,10111110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0038:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0039:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0040:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0041:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0042:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0043:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0044:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0045:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0046:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0047:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0048:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,11000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0049:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0050:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0051:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,10101010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,11100100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00011000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0052:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0053:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00010011b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00011000b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00011010b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0054:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,10111011b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0055:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0056:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0057:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00000100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011101b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0058:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00000100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011101b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0059:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0060:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011100b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0061:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00101010b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0062:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0063:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,00110101b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00010100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0064:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0065:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0066:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0067:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01111010b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0068:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0069:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,11101110b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,11101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,11101110b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0070:
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011100b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0071:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0072:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0073:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0074:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,10111011b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0075:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0076:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01111010b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0077:
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0078:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,11101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001111b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,11111111b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011100b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0079:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110011b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00101010b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0080:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,11101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0081:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0082:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0083:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,11101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001111b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,11111111b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0084:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110011b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0085:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,11101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0086:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0087:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,00110101b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00010100b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0088:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,11101110b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,11101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,11101110b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0089:
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0090:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,11101110b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,11101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,12
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,11
     out (0xA0), a
     ld  a,11101110b
     out (0xA1), a
     ld  a,13
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000010b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00011111b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01011100b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0091:
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00101010b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0092:
     ld  a,7
     out (0xA0), a
     ld  a,10111000b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01011010b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0093:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,11010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0094:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01011000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0095:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0096:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010110b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0097:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0098:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010011b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0099:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0100:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0101:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0102:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0103:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0104:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0105:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0106:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0107:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0108:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0109:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0110:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0111:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0112:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0113:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0114:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,11010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0115:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0116:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010110b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0117:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0118:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0119:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0120:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010011b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0121:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010110b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0122:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01110001b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0123:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0124:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01101101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0125:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01101010b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0126:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00111101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0127:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01100101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0128:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00111011b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0129:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,11000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0130:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00111001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0131:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0132:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110111b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0133:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0134:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0135:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0136:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110011b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0137:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0138:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0139:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01100101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0140:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0141:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010110b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0142:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0143:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01101001b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0144:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01101110b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0145:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01110100b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0146:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01011010b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0147:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01011000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0148:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0149:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010011b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0150:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0151:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001101b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0152:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010110b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0153:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00011100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0154:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0155:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0156:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00111101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0157:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00111001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0158:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110111b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0159:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0160:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110011b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0161:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0162:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0163:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00101000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0164:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0165:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0166:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01010101b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0167:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010011b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0168:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,01110000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001100b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0169:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01010110b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0170:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10010000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0171:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01110001b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000001b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0172:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0173:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001010b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,01100101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0174:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0175:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0176:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0177:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0178:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0179:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0180:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100110b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0181:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001011b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0182:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0183:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110011b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0184:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0185:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0186:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,00110110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0187:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01010100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0188:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0189:
     ld  a,7
     out (0xA0), a
     ld  a,10100000b
     out (0xA1), a
     ld  a,6
     out (0xA0), a
     ld  a,00011110b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0190:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100110b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0191:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0192:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0193:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0194:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001001b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0195:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0196:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01010010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0197:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01010001b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0198:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01010000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100110b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0199:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01001111b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00001000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0200:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01001110b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0201:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01001101b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0202:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01001100b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100010b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000110b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0203:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01001011b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000110b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0204:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,1
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,0
     out (0xA0), a
     ld  a,01001010b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000101b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100100b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000110b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0205:
     ld  a,7
     out (0xA0), a
     ld  a,10000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000111b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0206:
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100101b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000101b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0207:
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0208:
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,3
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,2
     out (0xA0), a
     ld  a,00100110b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000101b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0209:
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10001000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10011000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret
R0210:
     ld  a,7
     out (0xA0), a
     ld  a,10011000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10011000b
     out (0xA1), a
     ld  a,8
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,7
     out (0xA0), a
     ld  a,10011000b
     out (0xA1), a
     ld  a,9
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,5
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,4
     out (0xA0), a
     ld  a,00000000b
     out (0xA1), a
     ld  a,10
     out (0xA0), a
     ld  a,00000110b
     out (0xA1), a
     ld  a,15
     out (0xA0), a
     ld  a,11001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ld  a,15
     out (0xA0), a
     ld  a,10001111b
     out (0xA1), a
     ld  a,14
     out (0xA0), a
     ret


fill:
     ds PageSize - ($ - 8000h),255	; Fill the unused area with 0xFF
