%{
    #include <stdlib.h>

    int number;
%}

%token operator

letter                  [A-Za-z]+
digit                   [0-9]+
s                       [ \t]*
urlstring               "\""[^\"]*"\""

variable                {letter}({letter}|{digit})*
operator                "+"|"-"
%%
{variable}{s}"="{s}{variable}{s}{operator}{s}{variable}{s}";"       {printf("This is a valid expression!");}
{urlstring}                                                         {printf("This is a valid string literal");}
"URL("{urlstring}")"                                                {printf("This is a valid url constructor");}
"URL"                                                               {printf("This is a valid url type"); return operator;}
%%

int main() {
    yylex();

    return 0;
}

int yywrap() {
    return 0;
}