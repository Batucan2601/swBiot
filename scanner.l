%{
    #include <stdlib.h>
    #include <stdio.h>
    int line = 1;
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

kw_function                         "function"
kw_return                           "return"

connect_func                        "connect"
disconnect_func                     "disconnect"
time_func                           "time"
log_func                            "print"
error_func                          "error"

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
division                            "./"
equal                               "="
semicolon                           ";"
comma                               ","
lt                                  "<"
gt                                  ">"
lte                                 "<="
gte                                 ">="

logic_equal                         "=="
logic_notequal                      "!="
logic_not                           "!"
logic_and                           "&&"
logic_or                            "||"

input_oper                          "<<"
output_oper                         ">>"

comment                             "%%"[^"%%"]*"%%"

    



%%
{string_literal} 				    {return STRING_LITERAL;}
{url_literal}                       {return URLSTRING;}
{int_literal}					    {return INT_LITERAL;}
{float_literal}                     {return FLOAT_LITERAL;}
{bool_literal}                      {return BOOL_LITERAL;}
{time_func}                         {return TIME_FUNC;}
{log_func}                          {return LOG_FUNC;}
{error_func}                        {return ERROR_FUNC;}
{connect_func}                      {return CONNECT_FUNC;}
{disconnect_func}                   {return DISCONNECT_FUNC;}

{kw_function}                       {return FUNCTION;}
{kw_return}                         {return RETURN;}
{switches}                          {return SWITCH;}
{type}                              {return TYPE;}
{if}                                {return IF;}
{else}                              {return ELSE;}
{for}                               {return FOR;}
{while}                             {return WHILE;}

{plus}								{return PLUS;}
{minus}								{return MINUS;}
{asterix}							{return MUL;}
{division}						    {printf("salama"); return DIV; }
{equal}								{return EQ;}
{semicolon}                         {return SEMICOLON;}
{comma}                             {return COMMA;}
{sensors}                           {return SENSOR;}

{rp}							    {return RP;}
{lp}                          		{return LP;}
{lcb}                               {return LCB;}
{rcb}                               {return RCB;}
{lsb}                               {return LSB;}
{rsb}                               {return RSB;}

{logic_notequal}                    {return LNEQ;}
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

{identifier}                        {return IDENTIFIER;}
{comment}                           {;}
{space}                             {;}
\n                                  {line++;}
.^\n                                {ECHO;}
%%

/* int main() {
    yylex();

    return 0;
} */

int yywrap() {
    return 1;
}

/* void yyerror(const char* text) {
    printf("%s", text);
} */
