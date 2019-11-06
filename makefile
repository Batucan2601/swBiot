parser: y.tab.c
	gcc -o parser y.tab.c
y.tab.c: parser.y lex.yy.c
	yacc parser.y
lex.yy.c: scanner.l
	lex scanner.l