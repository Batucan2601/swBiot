all:
	lex example.l
	yacc example.y
	gcc -o example y.tab.c
	./example
	cls
