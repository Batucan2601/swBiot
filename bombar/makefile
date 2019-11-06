parser: y.tab.c
	gcc -o parser y.tab.c
y.tab.c: bombar.y lex.yy.c
	yacc bombar.y
lex.yy.c: bombar.l
	lex bombar.l