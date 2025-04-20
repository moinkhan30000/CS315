%option yylineno
%option noyywrap

%{
#include "y.tab.h"
#include <stdio.h>
%}

%option noyywrap

%%

"start" {  return START; }
"end"   {  return END; }

"if"              { return IF; }
"elseif"          { return ELSEIF; }
"else"            { return ELSE; }
"for"             { return FOR; }
"while"           { return WHILE; }
"return"          { return RETURN; }
"print"           { return PRINT; }
"input"           { return INPUT; }
"real"            { return REAL; }
"bool"            { return BOOL_TYPE; }
"list"            { return LIST; }
"function"        { return FUNCTION; }
"void"            { return VOID; }

"000"|"001"       { return BOOL_LITERAL; }

"="               { return ASSIGN_OP; }
"+"               { return PLUS_SIGN; }
"-"               { return MINUS_SIGN; }
"*"               { return MULT_SIGN; }
"/"               { return DIV_SIGN; }
"%"               { return MOD_SIGN; }
"^"               { return POW_SIGN; }

"<"               { return LESS; }
"<="              { return LESS_EQ; }
">"               { return GREATER; }
">="              { return GREATER_EQ; }
"=="              { return EQ; }
"!="              { return NOT_EQ; }

"||"              { return OR; }
"&&"              { return AND; }
"!"               { return NOT; }

"{"               { return L_Bracket; }
"}"               { return R_Bracket; }
"["               { return S_L_Bracket; }
"]"               { return S_R_Bracket; }
"("               { return LP; }
")"               { return RP; }
";"               { return END_LINE; }
","               { return COMMA; }

"++"              { return INCREMENT; }
"--"              { return DECREMENT; }

"::"              { return FOR_SEPARATOR; }

\/\/.*    		  { return COMMENT; }
"/*"([^*]|\*+[^*/])*\*+"/" { return MLCS; }  

-?[0-9]+\.[0-9]+   { return REAL_NUMBER; }
[0-9]+           { return NUMBERS; }      

[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
\".*\"            { return STRING_LITERAL; }

[ \t\n\r]+        { /* Ignore whitespace */ }

.                 { printf("UNKNOWN CHARACTER\n"); }

%%


