%{
    int yylex();
    int yyerror(const char *s);
    #include <stdio.h>
%}


%start program 
%token LOGIC_IDENTIFIER                      
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
%token COMMA
%token SENSOR
%token BOOL_LITERAL
%token IDENTIFIER
%token LNEQ
%token CONNECT_FUNC
%token DISCONNECT_FUNC
%token RETURN


%nonassoc IF
%nonassoc ELSE


%left PLUS MINUS LAND LT GT
%left MUL DIV LOR LTE GTE
%left LEQ LNEQ

%%
    
    program  : stmt_list { printf( "is a valid swBiot Program\n");};


    stmt_list  :   stmt SEMICOLON
		              | stmt_list stmt SEMICOLON  ;


    stmt   : declaration_stmt
		| assign_stmt
		| init_stmt
		| if_stmt
		| loop_stmt
    | expr;

    
    declaration_stmt   : funct_declaration 
		| var_declaration;
    var_declaration_list   : var_declaration 
		| var_declaration_list COMMA var_declaration
    var_declaration   : TYPE  IDENTIFIER;

    funct_declaration   : FUNCTION IDENTIFIER LP var_declaration_list RP  TYPE LCB stmt_list RETURN expr SEMICOLON RCB
                          | FUNCTION IDENTIFIER LP var_declaration_list RP LCB stmt_list RCB;
    

     assign_stmt : SWITCH INN logic_expr
                | IDENTIFIER EQ expr
                | IDENTIFIER OUT IDENTIFIER
                | IDENTIFIER INN expr
                | sensor_expr OUT IDENTIFIER;


    init_stmt   : TYPE assign_stmt;


    if_stmt : IF LP logic_expr RP LCB stmt_list RCB
              | IF LP logic_expr RP LCB stmt_list RCB ELSE LCB stmt_list RCB;
   
   
    loop_stmt   : while_stmt 
		    | for_stmt; 
    while_stmt   : WHILE LP logic_expr RP   stmt 
		    |  WHILE LP logic_expr RP    LCB  stmt_list RCB  ; 
    for_stmt   : FOR LP init_stmt SEMICOLON  logic_expr SEMICOLON  stmt  RP LCB stmt_list RCB
    | FOR LP init_stmt SEMICOLON  logic_expr SEMICOLON  stmt  RP stmt;
      

    expr   : arithmetic_expr | url_expr;


    url_expr : URLSTRING;

    logic_expr :  logic_expr LAND logic_expr
          | logic_expr LOR logic_expr
          | logic_expr LEQ logic_expr
          | logic_expr LNEQ logic_expr

          | logic_expr LT logic_expr
          | logic_expr LTE logic_expr
          | logic_expr GT logic_expr
          | logic_expr GTE logic_expr

          | LNOT LP logic_expr RP
          | BOOL_LITERAL
              | INT_LITERAL
    | FLOAT_LITERAL
    | STRING_LITERAL
          | IDENTIFIER;

    arithmetic_expr   : arithmetic_expr PLUS arithmetic_expr
    | arithmetic_expr MINUS arithmetic_expr
    | arithmetic_expr DIV arithmetic_expr
    | arithmetic_expr MUL arithmetic_expr
    | logic_expr
    | func_call_expr
    | sensor_expr
    | LP arithmetic_expr RP;
  


    sensor_expr    : SENSOR LSB  arithmetic_expr RSB;



     func_call_expr    :  IDENTIFIER  LP  parameter_list  RP
                         | IDENTIFIER  LP  RP
                         | DISCONNECT_FUNC LP IDENTIFIER RP
                         | CONNECT_FUNC LP IDENTIFIER RP
                         | LOG_FUNC LP expr RP
                         | ERROR_FUNC LP expr RP
                         | TIME_FUNC LP RP;     
     
     parameter_list    :  expr
		 |   expr COMMA parameter_list;
    
    %%
#include "lex.yy.c"




int main() {
    return yyparse();
}
int yyerror( const char *s ) { printf("is not in swBiot error on line %d: %s\n",line, s); }
    