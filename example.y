
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
    var_declaration   : type identifier;

    funct_declaration   : FUNCTION identifier LP var_declaration_list RP  type RCB stmt_list LCB;

    assign_stmt   : special_assign 
		| conventional_assign;
    special_assign   : input_assign 
		| output_assign;
    input_assign   : identifier INN identifier 
		| identifier INN sensor_expr 
		| NONSTOP identifier INN identifier;
    output_assign   : identifier OUT expr 
		| switch_type OUT logic_expr;
    conventional_assign   : identifier EQ expr;

    init_stmt   : type assign_stmt;

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
		| literal_expr 
		| time_expr 
		| func_call_expr;

    logic_expr   : logic_operand binlog_operator logic_operand 
		| unilog_operator  |  logic_operand
    binlog_operator   :  LEQ 
		| LAND
		| LOR;
    unilog_operator   :  LNOT
    logic_operand    : logic_expr 
		| identifier 
		| BOOL_LITERAL;
    arithmetic_expr   : art_operand add_sub term_operand 
		| term_operand;
    term_operand   : term_operand mul_div factor_operand 
		| factor_operand;
    factor_operand   : LP  arithmetic_expr RP 
		| identifier;
    add_sub   : PLUS | MINUS;
    mul_div   : MUL | DIV;

    art_operand   :  integer_literal  
		|  float_literal  
		|  string_literal  
		|  identifier;

     url_expr    : URLSTRING;

     sensor_expr    : SENSOR LP  arithmetic_expr RP;

     
 
      sign    : MINUS | PLUS;

     time_expr    : TIME_FUNC LP  RP  ;

     func_call_expr    :  identifier  LP  parameter_list  |  RP  ;
     parameter_list    :  parameter  
		|  parameter_list   parameter COLON ;
     parameter    :  identifier;


    identifier   : IDENTIFIER;  


 type    : TYPE;
 switch_type    : SWITCH;
    %%
    #include "lex.yy.c"

    main() {
      return yyparse();
    }
    int yyerror( char *s { fprintf( stderr, "%s\n", s); }
    