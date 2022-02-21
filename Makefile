.PHONY: clean

prog: prog.pas
	fpc prog.pas
clean:
	rm prog.o
