all:
	lex m.l 
	cc *.c 
	./a.out < boring.kp
	cls