%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();
extern int yylineno;
%}

%union {
    char* str;
}

%token START END IF ELSEIF ELSE FOR WHILE RETURN PRINT INPUT NUMBERS REAL BOOL_TYPE LIST FUNCTION VOID
%token BOOL_LITERAL REAL_NUMBER IDENTIFIER STRING_LITERAL

%token ASSIGN_OP PLUS_SIGN MINUS_SIGN MULT_SIGN DIV_SIGN MOD_SIGN POW_SIGN
%token LESS LESS_EQ GREATER GREATER_EQ EQ NOT_EQ
%token OR AND NOT
%token L_Bracket R_Bracket S_L_Bracket S_R_Bracket LP RP END_LINE COMMA
%token INCREMENT DECREMENT FOR_SEPARATOR
%token MLCS COMMENT

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
%left OR
%left AND
%nonassoc EQ NOT_EQ
%nonassoc LESS LESS_EQ GREATER GREATER_EQ
%left PLUS_SIGN MINUS_SIGN
%left MULT_SIGN DIV_SIGN MOD_SIGN
%right POW_SIGN
%right NOT

%%

program:
    START block END_LINE END
    ;

block:
    L_Bracket statement_list R_Bracket
    ;

statement_list:
      /* empty */
    | statement_list statement
    ;

statement:
      assignment_statement
    | expression_statement
    | if_statement
    | loop_statement
    | function_definition
    | print_statement
    | input_statement
    | variable_declaration
    | MLCS
    | COMMENT
    | return_statement
    | increment_decrement_statement
    ;

lvalue:
     IDENTIFIER S_L_Bracket l_index S_R_Bracket 
    ;

l_index:
    IDENTIFIER
    | NUMBERS
    ;
assignment_statement:
      IDENTIFIER ASSIGN_OP expression END_LINE  
    | lvalue ASSIGN_OP expression END_LINE       
    ;


expression_statement:
    expression END_LINE
    ;

expression:
    logical_or_expr
    ;

logical_or_expr:
    logical_or_expr OR logical_and_expr
    | logical_and_expr
    ;

logical_and_expr:
    logical_and_expr AND equality_expr
    | equality_expr
    ;

equality_expr:
    equality_expr EQ relational_expr
    | equality_expr NOT_EQ relational_expr
    | relational_expr
    ;

relational_expr:
    relational_expr LESS additive_expr
    | relational_expr LESS_EQ additive_expr
    | relational_expr GREATER additive_expr
    | relational_expr GREATER_EQ additive_expr
    | additive_expr
    ;

additive_expr:
    additive_expr PLUS_SIGN mult_expr
    | additive_expr MINUS_SIGN mult_expr
    | mult_expr
    ;

mult_expr:
    mult_expr MULT_SIGN pow_expr
    | mult_expr DIV_SIGN pow_expr
    | mult_expr MOD_SIGN pow_expr
    | pow_expr
    ;

pow_expr:
    primary POW_SIGN pow_expr
    | primary
    ;

primary:
      IDENTIFIER
    | REAL_NUMBER
    | BOOL_LITERAL
    | LP expression RP
    | list_literal
    | NUMBERS
    |function_call
    |lvalue
    |MINUS_SIGN primary
    ;

list_literal:
    S_L_Bracket real_list S_R_Bracket
    ;

real_list:
      number_value  
    | number_value COMMA real_list  
    ;

number_value:
      REAL_NUMBER  
    | NUMBERS      
    ;

if_statement:
      IF LP expression RP block END_LINE
    | IF LP expression RP block else_part END_LINE  
    ;

else_part:
      ELSEIF LP expression RP block else_part   
    | ELSEIF LP expression RP block             
    | ELSE block                                
    ;



loop_statement:
      WHILE LP expression RP block END_LINE
    | FOR LP optional_init FOR_SEPARATOR expression FOR_SEPARATOR optional_inc RP block END_LINE
    ;

optional_init:
      /* empty */
    | init_for
    ;

init_for:
      IDENTIFIER ASSIGN_OP expression
    | REAL IDENTIFIER ASSIGN_OP expression
    ;

optional_inc:
      /* empty */
    | inc_for
    ;

inc_for:
    IDENTIFIER ASSIGN_OP expression
    ;

function_definition:
    FUNCTION IDENTIFIER LP opt_param_list RP function_block END_LINE
    ;

function_block:
    L_Bracket statement_list R_Bracket
    ;

function_call:
    IDENTIFIER LP opt_argument_list RP
    ;

opt_argument_list:
      /* empty */  
    | argument_list
    ;

argument_list:
      expression
    | expression COMMA argument_list
    ;
opt_param_list:
      /* empty */
    | param_list
    ;

param_list:
      parameter
    | parameter COMMA param_list
    ;

parameter:
    var_type IDENTIFIER
    ;

var_type:
      BOOL_TYPE
    | REAL
    | LIST
    ;

return_statement:
      RETURN expression END_LINE
    | RETURN END_LINE
    ;


print_statement:
    PRINT LP print_list RP END_LINE
    ;

print_list:
      print_item
    | print_item COMMA print_list
    ;

print_item:
      STRING_LITERAL
    | expression
    ;

input_statement:
    INPUT LP IDENTIFIER RP END_LINE
    ;

variable_declaration:
      REAL IDENTIFIER END_LINE
    | REAL IDENTIFIER ASSIGN_OP expression END_LINE
    | BOOL_TYPE IDENTIFIER END_LINE
    | BOOL_TYPE IDENTIFIER ASSIGN_OP expression END_LINE
    | LIST IDENTIFIER END_LINE
    | LIST IDENTIFIER ASSIGN_OP list_init END_LINE
    ;

list_init:
      list_literal
    | IDENTIFIER
    ;

increment_decrement_statement:
      IDENTIFIER INCREMENT END_LINE
    | IDENTIFIER DECREMENT END_LINE
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error on line %d!\n", yylineno);
}



int main() {
    if (yyparse() == 0) {  
        printf("Input program is valid.\n");
    }
    return 0;
}
