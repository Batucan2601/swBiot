%{
    #include <stdlib.h>
    #include <stdio.h>

    //    /*
    #define _AMGUARD 
    // */

    #ifdef _AMGUARD 
        #define PRINT
    #else  
        #define TOKEN
    #endif

    #ifdef PRINT 
        #define LOG(x) printf(x)
    #else  
        #define LOG(x) return x
    #endif

    #ifdef TOKEN 
        #define LOG(x) return x
    #endif
%}
space                               [ /t/n]+
digit                               [0-9]
sign                                [-+]
letter                              [A-Za-z]+?

string_literal 			            "\""[^\"]*"\""
url_literal                         "'"[^']*"'"

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

comment                             "%%"[^"/n"]*"/n"

%%
{string_literal} 				    {LOG(" STRING_LITERAL ");}
{url_literal}                       {LOG(" URLSTRING ");}
{int_literal}					    {LOG(" INT_LITERAL ");}
{float_literal}                     {LOG(" FLOAT_LITERAL ");}

{kw_nonstop}                        {LOG(" NONSTOP ");}
{time_func}                         {LOG(" TIME_FUNC ");}
{log_func}                          {LOG(" LOG_FUNC ");}
{error_func}                        {LOG(" ERROR_FUNC ");}

{kw_function}                       {LOG(" KW_FUNCTION ");}
{switches}                          {LOG(" SWITCH ");}
{type}                              {LOG(" TYPE ");}
{if}                                {LOG(" IF ");}
{else}                              {LOG(" ELSE ");}
{for}                               {LOG(" FOR ");}
{while}                             {LOG(" WHILE ");}

{rp}							    {LOG(" RP ");}
{lp}                          		{LOG(" LP ");}
{lcb}                               {LOG(" LCB ");}
{rcb}                               {LOG(" RCP ");}
{lsb}                               {LOG(" LSB ");}
{rsb}                               {LOG(" RSP ");}

{logic_equal}                       {LOG(" LEQ ");}
{logic_not}                         {LOG(" LNOT ");}
{logic_and}                         {LOG(" LAND ");}
{logic_or}                          {LOG(" LOR ");}

{lt}                                {LOG(" LT ");}
{gt}                                {LOG(" GT ");}
{lte}                               {LOG(" LTE ");}
{gte}                               {LOG(" GTE ");}

{input_oper}                        {LOG(" INN ");}
{output_oper}                       {LOG(" OUT ");}

{plus}								{LOG(" PLUS ");}
{minus}								{LOG(" MINUS ");}
{asterix}							{LOG(" MUL ");}
{division}						    {LOG(" DIV ");}
{equal}								{LOG(" EQ ");}
{colon}                             {LOG(" SEMICOLON ");}

{identifier}                        {LOG(" IDENTIFIER<"); ECHO; LOG(">");}
{comment}                           {;}
{space}                             {;}
.^/n                                {LOG("WHAt/n");}
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
