all:
	lex m.l 
	cc *.c 
	./a.out
	cls