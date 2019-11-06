%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "y.tab.c"
%}
space                               [ /t/n]+
digit                               [0-9]
sign                                [-+]
letter                              [A-Za-z]+?

string_literal 			            "\""[^\"]*"\""
url_literal                         "'"[^']*"'"
bool_literal                        "true"|"false"
identifier                          {letter}({letter}|{digit}|"_")*

type                                "INT"|"BOOL"|"SENSOR"|"URL"|"FLOAT"|"STRING"
switches                            "SW1"|"SW2"|"SW3"|"SW4"|"SW5"|"SW6"|"SW7"|"SW8"|"SW9"|"SW10"
sensors                             "HUM"|"TEMP"|"AIRPRES"|"AIRQUAL"|"LIGHT"|"SOUND"

float_literal                       {sign}?{digit}*(\.)?{digit}+
int_literal                         {sign}?{digit}+

kw_nonstop                          "nonstop"
kw_function                         "function"
time_func                           "time"
log_func                            "doit"
error_func                          "hollycow"

if                                  "if"
while                               "while"
else                                "else"
for                                 "for"
function                            "function"
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
semicolon                           ";"
colon                               ","
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

comment                             "%%"[^"/n"]*"/n"

    



%%
{string_literal} 				    {return STRING_LITERAL;}
{url_literal}                       {return URLSTRING;}
{int_literal}					    {return INT_LITERAL;}
{float_literal}                     {return FLOAT_LITERAL;}
{bool_literal}                      {return BOOL_LITERAL;}
{kw_nonstop}                        {return NONSTOP;}
{time_func}                         {return TIME_FUNC;}
{log_func}                          {return LOG_FUNC;}
{error_func}                        {return ERROR_FUNC;}

{kw_function}                       {return FUNCTION;}
{switches}                          {return SWITCH;}
{type}                              {return TYPE;}
{if}                                {return IF;}
{else}                              {return ELSE;}
{for}                               {return FOR;}
{while}                             {return WHILE;}

{rp}							    {return RP;}
{lp}                          		{return LP;}
{lcb}                               {return LCB;}
{rcb}                               {return RCB;}
{lsb}                               {return LSB;}
{rsb}                               {return RSB;}

{logic_equal}                       {return LEQ;}
{logic_not}                         {return LNOT;}
{logic_and}                         {return LAND;}
{logic_or}                          {return LOR;}

{lt}                                {return LT;}
{gt}                                {return GT;}
{lte}                               {return LTE;}
{gte}                               {return GTE;}

{input_oper}                        {return INN;}
{output_oper}                       {return OUT;}

{plus}								{return PLUS;}
{minus}								{return MINUS;}
{asterix}							{return MUL;}
{division}						    {return DIV;}
{equal}								{return EQ;}
{semicolon}                         {return SEMICOLON;}
{colon}                             {return COLON;}
{sensors}                           {return SENSOR;}

{identifier}                        {return IDENTIFIER;}
{comment}                           {;}
{space}                             {;}
.^\n                                {ECHO;}
%%

/* int main() {
    yylex();

    return 0;
} */

int yywrap() {
    return 0;
}

/* void yyerror(const char* text) {
    printf("%s", text);
} */
