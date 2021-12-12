; MSX BIOS Symbol Table

    BEGIN:      equ 0x0000  ; Fail safe

    RDSLT:      equ 0x01B6  ; Read a byte from another slot
    RDESLT:     equ 0x01C6  ; 
    WRSLT:      equ 0x01D1  ; Write a byte to another slot
    WRESLT:     equ 0x01E1  ; 
    WRESED:     equ 0x01EC  ; 
    CALBAS:     equ 0x01FF  ; 
    CALLF:      equ 0x0205  ; Perform far-call (i.e., inter-slot)
    CALSLT:     equ 0x0217  ; Perform inter-slot call
    CALESL:     equ 0x022E  ; 
    CALESL:     equ 0x022E  ; 
    ENASLT:     equ 0x025E  ; Permanently enables a slot
    ENESLT:     equ 0x026B  ; 
    SELPRM:     equ 0x027E  ; 
    SLPRM1:     equ 0x0288  ; 
    SLPRM2:     equ 0x0299  ; 
    SELEXP:     equ 0x02A3  ; 
    SLEXP1:     equ 0x02BB  ; 

    CHKRAM:     equ 0x02D7  ; Find all connected RAM \n and cartridges
    CKRM05:     equ 0x02E7  ; 
    CKRM10:     equ 0x02FF  ; 
    CKRM15:     equ 0x0302  ; 
    CKRM20:     equ 0x0305  ; 
    CKRM25:     equ 0x0314  ; 
    CKRM30:     equ 0x0327  ; 
    CKRM35:     equ 0x0335  ; 
    CKRM50:     equ 0x0353  ; 
    CKRM55:     equ 0x0362  ; 
    CKRM60:     equ 0x0365  ; 
    CKRM65:     equ 0x0368  ; 
    CKRM70:     equ 0x0379  ; 
    CKRM75:     equ 0x038C  ; 
    CKRM80:     equ 0x0398  ; 

    ISCNTC:     equ 0x03FB  ; [SHIFT+STOP] pressed?
    
    WATINT:     equ 0x0419  ;
    EXCABO:     equ 0x042C  ; 
    EXABO1:     equ 0x043F  ; 
    CKSTTP:     equ 0x0454  ; 
    KILBUF:     equ 0x0468  ; 
    BREAKX:     equ 0x046F  ; [CTRL+STOP] pressed?
    INITIO:     equ 0x049D  ; Device initialization
    GICINI:     equ 0x04BD  ; Init PSG and static data for PLAY
    MUSCLL:     equ 0x04C7  ;
    GICIN1:     equ 0x04D3  ;
    MUSITB:     equ 0x0508  ;

    INITXT:     equ 0x050E  ; Init VDP for 40 x 24 text mode (SCREEN 0)
    INIT32:     equ 0x0538  ; Init VDP for 32 x 24 text mode (SCREEN 1)
    ENASCR:     equ 0x0570  ; Enable screen display
    DISSCR:     equ 0x0577  ; Disable screen display
    DISSC1:     equ 0x057C  ;
    WRTVDP:     equ 0x057F  ; Write a byte to any VDP register
    SETTXT:     equ 0x0594  ; Set VDP display 40 x 24 text mode
    SETT32:     equ 0x05B4  ; Set VDP display 32 x 24 text mode
    INIGRP:     equ 0x05D2  ; Init VDP for high resolution mode (SCREEN 2)
    INIGR1:     equ 0x05EF  ;
    
    SETGRP:     equ 0x0602  ; Set VDP display high resolution mode
    INIMLT:     equ 0x061F  ; Init VDP for multi color mode (SCREEN 3)
    INIML1:     equ 0x063C  ;
    INIML2:     equ 0x063E  ;
    INIML3:     equ 0x0641  ;
    SETMLT:     equ 0x0659  ; Set VDP display multi color mode
    SETSCM:     equ 0x0677  ;
    SETREG:     equ 0x0690  ;
    SETRG1:     equ 0x0691  ;
    SETRG3:     equ 0x0698  ;
    CLRSPR:     equ 0x06A8  ; Init sprite data
    ERASPR:     equ 0x06BB  ; 
    CLSPR2:     equ 0x06C5  ;
    CALPAT:     equ 0x06E4  ; Get address of sprite pattern table
    GSPAD1:     equ 0x06F3  ;
    CALATR:     equ 0x06F9  ; Get address of sprite attribute table

    GSPSIZ:     equ 0x0704  ; Return current sprite size
    LDIRMV:     equ 0x070F  ; Move block of data from VRAM to memory
    LDIMV1:     equ 0x0714  ;
    INIPAT:     equ 0x071E  ;
    INIPT1:     equ 0x0731  ;
    LDIRVM:     equ 0x0744  ; Move block of data from memory to VRAM
    LDIVM1:     equ 0x0748  ;
    GTPAT1:     equ 0x0765  ;
    CLSSUB:     equ 0x0777  ;
    CLRTXT:     equ 0x077E  ;
    CLRTX1:     equ 0x078D  ;
    CLRTX2:     equ 0x079A  ;
    CLSHRS:     equ 0x07A1  ;
    JFLVRM:     equ 0x07B6  ;
    CLSMLT:     equ 0x07B9  ;
    WRTVRM:     equ 0x07CD  ; Write VRAM address using [HL]
    RDVRM:      equ 0x07D7  ; Read VRAM address using [HL]
    SETWRT:     equ 0x07DF  ; Set up VDP for write
    SETRD:      equ 0x07EC  ; Set up VDP for read
    CHGCLR:     equ 0x07F7  ; Change fg, bg and border colors

    FILVRM:     equ 0x0815  ; Fill VRAM with specified data
    FLVRM1:     equ 0x0819  ; Fill VRAM with specified data
    CHCLTX:     equ 0x0824  ;
    CHGBDR:     equ 0x0832  ;
    CHGBD1:     equ 0x0835  ;
    TOTEXT:     equ 0x083B  ; Force screen to text mode
    CHGMOD:     equ 0x084F  ; Change screen mode of VDP to [SCRMOD]
    LPTOUT:     equ 0x085D  ; Output character to printer, if possible
    CLS:        equ 0x0848  ; Clear screen
    LPTSTT:     equ 0x0884  ; Check status of line printer
    POSIT:      equ 0x088E  ; Place cursor at column [H], row [L]
    CNVCHR:     equ 0x089D  ; Check for graphic header byte and convert code
    CHPUT:      equ 0x08BC  ; Output character to console
    POPALL:     equ 0x08DA  ;

    CKDPC0:     equ 0x09DA  ; Display cursor if disabled
    CSHOME:     equ 0x0A7F  ;
    FNKSB:      equ 0x0B26  ; Display function keys, if necessary
    ERAFNK:     equ 0x0B15  ; Stop displaying the function keys
    DSPFNK:     equ 0x0B2B  ; Enable funcion keys display
    CHKSCR:     equ 0x0B9F  ;
    
    KEYINT:     equ 0x0C3C  ; Handlers for hardware interrupt
    CHSNS:      equ 0x0D6A  ; Check keyboard status

    CHGCAP:     equ 0x0F3D  ; 
    CHGSND:     equ 0x0F7A  ; 

    CHGET:      equ 0x10CB  ; Return char typed, with wait
    CKCNTC:     equ 0x10F9  ; Same as ISCNTC, but used by BASIC
    WRTPSG:     equ 0x1102  ; Write data to PSG
    INGI:       equ 0x110C  ;
    RDPSG:      equ 0x110E  ; Read data from PSG
    BEEP:       equ 0x1113  ; Buzz
    STRTMS:     equ 0x11C4  ; Check and start bg task for PLAY
    GTSTCK:     equ 0x11EE  ; 

    GTTRIG:     equ 0x1253  ; 
    GTPAD:      equ 0x12AC  ; 
    GTPDL:      equ 0x1273  ; 

    STMOTR:     equ 0x1384  ; 
    NMI:        equ 0x1398  ; Handler of non-maskarable interrupt
    INIFNK:     equ 0x139D  ; Reset all function key's text

    RSLREG:     equ 0x144C  ; 
    WSLREG:     equ 0x144F  ; 
    RDVDP:      equ 0x1449  ; 
    SNSMAT:     equ 0x1452  ; 
    ISFLIO:     equ 0x145F  ; 
    DCOMPR:     equ 0x146A  ; Compare [HL] to [DE]
    GETVCP:     equ 0x1470  ; 
    GETVC2:     equ 0x1474  ; 
    GETVC1:     equ 0x1477  ; 
    PHYDIO:     equ 0x148A  ; 
    FORMAT:     equ 0x148E  ; 
    PUTQ:       equ 0x1492  ; 
    INITQ:      equ 0x14DA  ;
    LFTQ:       equ 0x14EB  ; 

    OUTDLP:     equ 0x1B63  ; 
    OUTDO:      equ 0x1B45  ; Output a char to the console or printer
    CGTABL:     equ 0x1BBF  ; Address of character generator table, \n to allow use of other character ROM

    GRPPRT:     equ 0x1510  ; Print a char on the graphic screen
    SCALXY:     equ 0x1599  ; Scale X Y coordinates
    MAPXYC:     equ 0x15DF  ; Map coordinate to physical address

    FETCHC:     equ 0x1639  ; Current physical address and mask pattern
    STOREC:     equ 0x1640  ; Current physical address and mask pattern
    READC:      equ 0x1647  ; Read attribute of current pixel
    SETATR:     equ 0x1676  ; Set the color attribute byte
    SETC:       equ 0x167E  ; Set current pixel to specified attribute
    RIGHTC:     equ 0x16C5  ; Moves one pixel right
    LEFTC:      equ 0x16EE  ; Moves one pixel left
    UPC:        equ 0x175D  ; Moves one pixel up
    TUPC:       equ 0x173C  ; Moves one pixel up
    DOWNC:      equ 0x172A  ; Moves one pixel down
    TDOWNC:     equ 0x170A  ; Moves one pixel down
    NSETCX:     equ 0x1809  ; Set pixel horizontally
    GTASPC:     equ 0x18C7  ; Return spect ratio
    PNTINI:     equ 0x18CF  ; Do paint initialization
    SCANR:      equ 0x18E4  ; Scan pixels to the right
    SCANL:      equ 0x197A  ; Scan pixels to the left

    TAPIOF:     equ 0x19E9  ; 
    TAPOON:     equ 0x19F1  ; 
    TAPOFF:     equ 0x19DD  ; 
    TAPION:     equ 0x1A63  ; 
    TAPIN:      equ 0x1ABC  ; 
    TAPOUT:     equ 0x1A19  ; 
    OUTDO:      equ 0x1B45  ; 
    CGTABL:     equ 0x1BBF  ; Address of character generator table to allow use of other character ROM

    PINLIN:     equ 0x23BF  ; Read line from keyboard to buffer
    QINLIN:     equ 0x23CC  ; Print a "?", then jump to INLIN
    INLIN:      equ 0x23D5  ; Same as above, except in case of AUTFLG is set

    INIT:       equ 0x2680  ;     
    SYNCHR:     equ 0x2683  ; Check byte following the RST 8, see \n if equal to the byte ponted by HL
    CHRGTR:     equ 0x2686  ; Fetch next char from BASIC text
    GETYPR:     equ 0x2689  ; Return the [FAC] type


;--------------------------- DOCSTRINGS -------------------------------
;
; Each docstring section begins with a comment line 
; that has the hexadecimal PC address in brackets to indicate
; where the docstring is to be inserted in the assembly code.
; The section ends with [esc] to escape so that usual comment lines in
; this file can we inserted that do not belong to the docstring section

;----------------------------------------------------------------------
; [BEGIN] 
; MSX BIOS
; ========
; 
; Symbol table by MSX.BIOS, ASCII Corp., 1983 (v3.44)
; 
;   file       : BIOHDR.MAC
;   use        : Restart calls and ROM entries table
;   written by : Jey Suzuki, Rick Yamashita
;                ASCII Corporation, Japan
; 
;   edit       : January, 1985
;   reason     : Zilog Z80 Mneumonic version and cleanup
;   edited by  : Steven M. Ting
; 
; Disassembled by Ximenes R. Resende (xresende@gmail.com)
;
;   file       : EXPERT10.ROM
;
;
; The following RST\'s (RST 0 thru RST 5) are reserved for BASIC
; interpreter, RST 6 for inter-slot calls, and RST 7 for
; hardware interrupt
;
;
; [esc]

;----------------------------------------------------------------------
; [0x0004]
; 
; ** VDP Information **
;
; Any program that access the VDP hardware directly
; should read the I/O port address found here, to be certain
; the software is compatible with future versions of the VDP
;
; [esc]

;----------------------------------------------------------------------
; [0x0008]
; 
; Hook BIOS Functions
;
; [esc]

;----------------------------------------------------------------------
; [0x0038]
; 
; Following are used for I/O initializations
;
; [esc]

;----------------------------------------------------------------------
; [0x0041]
; The following entry points provide control of the
; VDP's registers, screen mode settings, and memory block
; move between DRAM and VRAM.
;
; [esc]

;----------------------------------------------------------------------
; [0x0090]
;
; The following entry points are used for PSG initialization,
; read and write PSG registers, and PLAY statement execution.
;
; [esc]

;----------------------------------------------------------------------
; [0x009C]
;
; General INPUT and PRINT utilities.
;
; [esc]

;----------------------------------------------------------------------
; [0x00D5]
;
; Following are used to read the value from joysticks,
; graphic pad (tablet), and paddles.
;
; [esc]

;----------------------------------------------------------------------
; [0x00E1]
;
; Following are used to access the cassette tape,
; data read/write, and motor on/off
;
; [esc]

;----------------------------------------------------------------------
; [0x00F6]
;
; BASIC queues
;
; [esc]

;----------------------------------------------------------------------
; [0x00FC]
;
; For BASIC interpreter's GENGRP and ADVGRP modules use
;
; [esc]

;----------------------------------------------------------------------
; [0x015C]
; 
; RESERVED FOR EXPANSION
; 0x015C - 0x01B5 (90 bytes)
;
; [esc]

;----------------------------------------------------------------------
; [0x01B6]
;
; SLOTS
;
; Every cartridge located at 0000-3FFFH must contain codes in
; this module which are entered via following addresses.
;
; .   0x000C RDSLT
; .   0x0014 WRSLT
; .   0x001C CALSLT
; .   0x0024 ENASLT
;
;
;
; ===== RDSLT =====
;
; Select the appropriate slot according to the value given
; through registers, and read the content of memory from the
; slot.
;
; Input parameters:
;
; .  A  - FxxxSSPP
; .       |   ||||
; .       |   ||++-- primary slot # (0-3)
; .       |   ++---- secondary slot # (0-3)
; .       +--------- 1 if secondary slot # specified
;
; .  HL - address of target memory'
;
; Returned value'
;
; .  A - content of memory
;
; Note: Interrupts are disabled automatically but never enabled
; .     by this routine.
;
; [esc]

;----------------------------------------------------------------------
; [0x0217]
;
; ===== CALSLT =====
;
; Perform inter-slot call to specified address
;
; Input parameters:
;
; .  IY - FxxxSSPP
; .       |   ||||
; .       |   ||++-- primary slot # (0-3)
; .       |   ++---- secondary slot # (0-3)
; .       +--------- 1 if secondary slot # specified
;
; .  IX - address to call
;
; Returned value'
;
; Note: Interrupts are disabled automatically but never enabled
; .     by this routine. You can never pass arguments via alternate
; .     registers of Z80.
;
; [esc]

;----------------------------------------------------------------------
; [0x025E]
;
; ===== ENASLT =====
;
; Select the appropriate slot according yo the value given
; trough registers, and permanently enables the slot.
;
; Input parameters:
;
; .  A  - FxxxSSPP
; .       |   ||||
; .       |   ||++-- primary slot # (0-3)
; .       |   ++---- secondary slot # (0-3)
; .       +--------- 1 if secondary slot # specified
;
; .  HL - address of target memory
;
; Note: Interrupts are disabled automatically but never enabled
; .     by this routine. 
;
; [esc]

;----------------------------------------------------------------------
; [0x02D7]
;
; ===== CHKRAM =====
;
; [0x02FF]
;
; Start from expansion slot #0
;
; [0x33B]
;
; Check is done, select the biggest one
;
; [0x0346]
;
; Next, check 0xC000..0xFFFF
;
; [0x039E]
;
; Check is done, select the biggest one
;
; [0x03AA]
;
; Clear work area with zero
;
; [0x03B7]
;
; Set EXPTBL
;
; [0x03C6]
;
; Set SSLTLP
;
; [esc]

;----------------------------------------------------------------------
; [0x03FB]
;
; ===== ISCNTC =====
;
; [0x0410]
;
; Pause until next STOP is pressed
;
; [esc]

;----------------------------------------------------------------------
; [0x046F]
;
; ===== BREAKX =====
;
; Check if stop key pressed. If pressed, return with carry set.
;
; [esc]

;----------------------------------------------------------------------
; [0x049D]
;
; ===== INITIO =====
;
; Initialize I/O
;
; [esc]

;----------------------------------------------------------------------
; [0x04BD]
;
; ===== GICINI =====
;
; Initialize GI sound chip, queues, and static data.
;
; Entry - Interrupts must be disabled
; Exit - All registers preserved.
;
; [esc]

;----------------------------------------------------------------------
; [0x0508]
;
; table of default values for music variables
;
; [esc]



