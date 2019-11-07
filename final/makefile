all: 
	yacc CS315f19_group10.yacc
	lex CS315f19_group10.lex
	gcc -o parser y.tab.c
	rm lex.yy.c 
	rm y.tab.c
also:
	./parser < CS315f19_group10.test
