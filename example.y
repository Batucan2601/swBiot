
%token letter                             
%token STRING_LITERAL
%token URLSTRING 
%start program
%nonassoc IF
%nonassoc ELSE
%token INT_LITERAL 
%token FLOAT_LITERAL 
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
    
    program  : stmt_list;
    stmt_list  : stmt 
		| stmt_list stmt;
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

    assign_stmt   : special_assign 
		| conventional_assign;
    special_assign   : input_assign 
		| output_assign;
    input_assign   : IDENTIFIER INN IDENTIFIER 
		| IDENTIFIER INN sensor_expr 
		| NONSTOP IDENTIFIER INN IDENTIFIER;
    output_assign   : IDENTIFIER OUT expr 
		| switch_type OUT logic_expr;
    conventional_assign   : IDENTIFIER EQ expr;

    init_stmt   : TYPE assign_stmt;

    if_stmt : IF LP logic_expr RP LCB stmt_list RCB
              | IF LP logic_expr RP LCB stmt_list RCB ELSE LCB stmt_list RCB;
   
   
    loop_stmt   : WHILE_stmt 
		    | for_stmt; 
    WHILE_stmt   : WHILE LP logic_expr RP   stmt 
		    |  WHILE LP logic_expr RP    LCB  stmt_list RCB  ; 
    for_stmt   : FOR LP init_stmt SEMICOLON  logic_expr SEMICOLON  arithmetic_expr SEMICOLON  RP   stmt;
      

    expr   : logic_expr 
		| arithmetic_expr
		| url_expr 
		| sensor_expr  
		| time_expr 
		| func_call_expr;

    logic_expr   : 
    
    logic_operand binlog_operator logic_operand 
		| unilog_operator  |  logic_operand 
    binlog_operator   :  LEQ 
		| LAND
		| LOR;
    unilog_operator   :  LNOT
    logic_operand    : logic_expr 
		| IDENTIFIER 
		| BOOL_LITERAL;


    arithmetic_expr   : art_operand operations term_operand 
		| term_operand;
    factor_operand   : LP  arithmetic_expr RP 
		| IDENTIFIER;
    operations   : PLUS | MINUS | MUL | DIV;

    art_operand   :  INT_LITERAL  
		|  FLOAT_LITERAL  
		|  STRING_LITERAL  
		|  IDENTIFIER;

     url_expr    : URLSTRING;

     sensor_expr    : SENSOR LP  arithmetic_expr RP;
 
      sign    : MINUS | PLUS;

     time_expr    : TIME_FUNC LP  RP  ;

     func_call_expr    :  IDENTIFIER  LP  parameter_list  |  RP  ;
     parameter_list    :  parameter  
		|  parameter_list   parameter COLON ;
     parameter    :  IDENTIFIER;


     switch_type    : SWITCH;
    %%
    #include "lex.yy.c"

    main() {
      return yyparse();
    }
    int yyerror( char *s { fprintf( stderr, "%s\n", s); }
    