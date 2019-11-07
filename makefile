all: 
	yacc parser.y
	lex scanner.l
	gcc -o parser y.tab.c
	./parser<boring.swb