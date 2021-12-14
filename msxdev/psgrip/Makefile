rom:
	pasmo rom.asm rom.rom

run-openmsx-rom:
	openmsx rom.rom

run-openmsx-game:
	openmsx BOXING.rom

run-msxpy-game:
	@python3 ../../Emulators/pymsx/msx.py -H 1 -W 1 -L 50 -b msxbiosbasic.rom -R 1:0:/home/ximenes/xamd/MSX/Games\ ROMS/konami/BOXING~1.rom 2>&1 | grep out | grep -v ALSA
	
run-msxpy-rom:
	@python3 ../../Emulators/pymsx/msx.py -H 1 -W 1 -L 50 -b msxbiosbasic.rom -R 1:0:./rom.rom 2>&1 | grep out | grep -v ALSA

asm:
	./readdata.py > rom.asm
