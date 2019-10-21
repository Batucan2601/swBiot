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
identifier                {letter}({letter}|{digit})*
operator                "+"|"-"
type                    "INT"|"BOOL"|"SENSOR"|"URL"|"FLOAT"|"STRING"
switches                "SW1"|"SW2"|"SW3"|"SW4"|"SW5"|"SW6"|"SW7"|"SW8"|"SW9"|"SW10"
if                      "if"
float                   {sign}?{digit}*(\.)?{digit}+

time_func               "time()"
while                   "while"
else                    "else"
for                     "for"

%%
{time_func}                         {printf(" TIMEFUNC ");}
{urlstring}                         {printf(" URLSTRING ");}
{switches}                          {printf(" SWITCH ");}
{type}                              {printf(" TYPE ");}
{if}                                {printf(" IF ");}
{else}                              {printf(" ELSE ");}
{for}                               {printf(" FOR ");}
{while}                             {printf(" WHILE ");}
{sign}?{digit}+					    {printf(" INT ");}
{float}                         	{printf(" FLOAT ");}
")"								    {printf(" RP ");}
"("                          		{printf(" LP ");}
"{"                                 {printf(" LSB ");}
"}"                                 {printf(" RSP ");}
"+"								    {printf(" PLUS ");}
"-"								    {printf(" MINUS ");}
"*"								    {printf(" MUL ");}
"/"								    {printf(" DIV ");}
"="								    {printf(" EQ ");}
{string} 						    {printf(" STRING_LITERAL ");}	
{identifier}                        {printf(" IDENTIFIER<"); ECHO; printf(">");}	
.                                   {yyerror(yytext);}
%%

int main() {
    yylex();

    return 0;
}

int yywrap() {
    return 0;
}

void yyerror(char* text) {
    printf("%s", text);
}