all:
	lex m.l 
	cc *.c 
	./a.out < boring.l
	cls