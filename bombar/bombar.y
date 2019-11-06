/*anbn0.y */
%{
    int yylex();
    int yyerror(const char *s);
    #include <stdio.h>
%}

%token A B
%%
start:   program {printf("  is in anbn\n"); return 0;}

program: A | B;

%%
#include "lex.yy.c"




int main() {
    return yyparse();
}
int yyerror( const char *s ) { printf("%s, it is not in anbn\n", s); }