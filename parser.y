%{
    int yylex();
    int yyerror(const char *s);
    #include <stdio.h>
%}


%start program                       
%token STRING_LITERAL
%token URLSTRING 
%token INT_LITERAL 
%token FLOAT_LITERAL
%token EMPTY 
%token LOGIC
%token NONSTOP
%token TIME_FUNC
%token LOG_FUNC
%token ERROR_FUNC
%token FUNCTION
%token SWITCH 
%token TYPE
%token IF
%token ELSE
%token FOR
%token WHILE 
%token RP
%token LP
%token LCB
%token RCB
%token LSB
%token RSB
%token LEQ
%token LNOT
%token LAND
%token LOR
%token LT
%token GT
%token LTE
%token GTE
%token INN
%token OUT
%token PLUS
%token MINUS
%token MUL
%token DIV
%token EQ
%token SEMICOLON
%token COLON
%token SENSOR
%token BOOL_LITERAL
%token IDENTIFIER
%token URL_LITERAL


%nonassoc IF
%nonassoc ELSE



%left  PLUS  MINUS
%left  MUL  DIV
%left LOR  LAND
%left LNOT 

/* %union{
	int IntVal;
	double DoubleVal;
	char CharVal;
}
%type <CharVal> stmt_list;
%type <CharVal> stmt;  
 {identifier}                        {LOG(" IDENTIFIER "); ECHO; LOG(">");}
{comment}                           {;}
{space}                             {;}
.^/n                                {LOG("WHAt/n");} */
%%
    
    program  : stmt_list { printf( "is a valid swBiot Program\n");};


    stmt_list  : stmt SEMICOLON
		| stmt_list stmt SEMICOLON;
    stmt   : declaration_stmt 
		| assign_stmt
		| init_stmt 
		| if_stmt 
		| loop_stmt;
    
    declaration_stmt   : funct_declaration 
		| var_declaration;
    var_declaration_list   : var_declaration 
		| var_declaration_list var_declaration
    var_declaration   : TYPE  IDENTIFIER;

    funct_declaration   : FUNCTION IDENTIFIER LP var_declaration_list RP  TYPE RCB stmt_list LCB;

    /* assign_stmt   : special_assign 
		| conventional_assign;
    special_assign   : input_assign 
		| output_assign;
    input_assign   : IDENTIFIER INN IDENTIFIER 
		| IDENTIFIER INN sensor_expr 
		| NONSTOP IDENTIFIER INN IDENTIFIER;
    output_assign   : IDENTIFIER OUT expr 
		| SWITCH OUT logic_expr;
    conventional_assign   : IDENTIFIER EQ expr; */
    

     assign_stmt : SWITCH assign_op BOOL_LITERAL
    |   IDENTIFIER assign_op expr

    assign_op : EQ | INN | OUT;

    init_stmt   : TYPE assign_stmt;


    if_stmt : IF LP logic_expr RP LCB stmt_list RCB
              | IF LP logic_expr RP LCB stmt_list RCB ELSE LCB stmt_list RCB;
   
   
    loop_stmt   : while_stmt 
		    | for_stmt; 
    while_stmt   : WHILE LP logic_expr RP   stmt 
		    |  WHILE LP logic_expr RP    LCB  stmt_list RCB  ; 
    for_stmt   : FOR LP init_stmt SEMICOLON  logic_expr SEMICOLON  arithmetic_expr SEMICOLON  RP   stmt;
      

    expr   : logic_expr 
		| arithmetic_expr
		| url_expr 
		| sensor_expr  
		| time_expr 
		| func_call_expr;


    url_expr : URL_LITERAL

    logic_expr :  BOOL_LITERAL
    | LOGIC IDENTIFIER 
    | LNOT LP logic_expr RP
    | LP logic_expr logic_operand logic_expr RP;
    

    logic_operand :  LEQ | LOR | LAND;
    
    /* logic_operand binlog_operator logic_operand 
		| unilog_operator  |  logic_operand 
    binlog_operator   :  LEQ 
		| LAND
		| LOR;
    unilog_operator   :  LNOT
    logic_operand    : logic_expr 
		| IDENTIFIER 
		| BOOL_LITERAL; */


    arithmetic_expr   : LP art_operand operations art_operand RP
		| art_operand;
  
    operations : PLUS | MINUS | MUL | DIV;

    art_operand   :  INT_LITERAL  
		|  FLOAT_LITERAL  
		|  STRING_LITERAL  
		|  IDENTIFIER;

    sensor_expr    : SENSOR LP  arithmetic_expr RP;
 
     /* sign    : MINUS | PLUS; */

     time_expr    : TIME_FUNC LP  RP  ;

     func_call_expr    :  IDENTIFIER  LP  parameter_list  RP;
     
     parameter_list    :  IDENTIFIER  
		 |  parameter_list   IDENTIFIER  COLON
     |  EMPTY;
    
    %%
#include "lex.yy.c"




int main() {
    return yyparse();
}
int yyerror( const char *s ) { printf("is not in swBiot: %s\n", s); }
    