%{
    #include <stdlib.h>

    int number;
%}

digit  [0-9]
sign   [-+]
letter                  [A-Za-z]+
string 			        "\""[^\"]*"\""
s                       [ \t]*
urlstring               "'"[^']*"'"
variable                {letter}({letter}|{digit})*
operator                "+"|"-"
type                    "INT"|"BOOL"|"SENSOR"|"URL"|"FLOAT"|"STRING"
switches                "SW1"|"SW2"|"SW3"|"SW4"|"SW5"|"SW6"|"SW7"|"SW8"|"SW9"|"SW10"

%%
{urlstring}                         {printf("URLSTRING");}
{switches}                          {printf("SWITCH");}
{type}                              {printf("TYPE");}
"if"                                {printf("IF");}
"else"                              {printf("ELSE");}
"for"                               {printf("FOR");}
"while"                             {printf("WHILE");}
{sign}?{digit}+					    {printf("INT");}
{sign}?{digit}*(\.)?{digit}+    	{printf(" FLOAT ");}
")"								    {printf(" RP ");}
"("                          		{printf(" LP ");}
"{"                                 {printf(" LSB ");}
"}"                                 {printf(" RSP ");}
"+"								    {printf(" + ");}
"-"								    {printf(" - ");}
"*"								    {printf(" * ");}
"/"								    {printf(" / ");}
"="								    {printf(" = ");}
{string} 						    {printf(" String ");}	

%%

int main() {
    yylex();

    return 0;
}

int yywrap() {
    return 0;
}
