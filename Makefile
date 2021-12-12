install:
	python3 ./setup.py install

develop:
	python3 ./setup.py develop

test:
	msxdev-disasm-bios.py ./EXPERT10.ROM
