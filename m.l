%{
    #include <stdlib.h>
    #include <stdio.h>
%}
space                               [ /t]+
digit                               [0-9]
sign                                [-+]
letter                              [A-Za-z]+?

string_literal 			            "\""[^\"]*"\""
url_literal                         "'"[^']*"'"

identifier                          {letter}({letter}|{digit})*

type                                "INT"|"BOOL"|"SENSOR"|"URL"|"FLOAT"|"STRING"
switches                            "SW1"|"SW2"|"SW3"|"SW4"|"SW5"|"SW6"|"SW7"|"SW8"|"SW9"|"SW10"
sensors                             "HUM"|"TEMP"|"AIRPRES"|"AIRQUAL"|"LIGHT"|"SOUND"

float_literal                       {sign}?{digit}*(\.)?{digit}+
int_literal                         {sign}?{digit}+

kw_nonstop                         "nonstop"
time_func                           "time"

if                                  "if"
while                               "while"
else                                "else"
for                                 "for"

lp                                  "("
rp                                  ")"
lcb                                 "{"
rcb                                 "}"
lsb                                 "["
rsb                                 "]"

plus                                "+"
minus                               "-"
asterix                             "*"
division                            "/"
equal                               "="
colon                               ";"

lt                                  "<"
gt                                  ">"
lte                                 "<="
gte                                 ">="

logic_equal                         "=="
logic_not                           "!"
logic_and                           "&&"
logic_or                            "||"

input_oper                          "<<"
output_oper                         ">>"

%%
{string_literal} 				    {printf(" STRING_LITERAL ");}
{url_literal}                       {printf(" URLSTRING ");}
{int_literal}					    {printf(" INT_LITERAL ");}
{float_literal}                     {printf(" FLOAT_LITERAL ");}

{kw_nonstop}                        {printf(" NONSTOP ");}
{time_func}                         {printf(" TIME_FUNC ");}

{switches}                          {printf(" SWITCH ");}
{type}                              {printf(" TYPE ");}
{if}                                {printf(" IF ");}
{else}                              {printf(" ELSE ");}
{for}                               {printf(" FOR ");}
{while}                             {printf(" WHILE ");}

{rp}							    {printf(" RP ");}
{lp}                          		{printf(" LP ");}
{lcb}                               {printf(" LCB ");}
{rcb}                               {printf(" RCP ");}
{lsb}                               {printf(" LSB ");}
{rsb}                               {printf(" RSP ");}

{logic_equal}                       {printf(" LEQ ");}
{logic_not}                         {printf(" LNOT ");}
{logic_and}                         {printf(" LAND ");}
{logic_or}                          {printf(" LOR ");}

{lt}                                {printf(" LT ");}
{gt}                                {printf(" GT ");}
{lte}                               {printf(" LTE ");}
{gte}                               {printf(" GTE ");}

{input_oper}                        {printf(" INN ");}
{output_oper}                       {printf(" OUT ");}

{plus}								{printf(" PLUS ");}
{minus}								{printf(" MINUS ");}
{asterix}							{printf(" MUL ");}
{division}						    {printf(" DIV ");}
{equal}								{printf(" = ");}
{colon}                             {printf(" SEMICOLON ");}

{identifier}                        {printf(" IDENTIFIER<"); ECHO; printf(">");}
{space}                             {;}
.                                   {perror("Could not parse this thing!");}
%%

int main() {
    yylex();

    return 0;
}

int yywrap() {
    return 0;
}

void yyerror(const char* text) {
    printf("%s", text);
}