%option main

%%

"start"           { printf("START\n"); }
"end"             { printf("END\n"); }
"if"              { printf("IF\t"); }
"elseif"          { printf("ELSE_IF\t"); }
"else"            { printf("ELSE\t"); }
"for"             { printf("FOR\t"); }
"while"           { printf("WHILE\t"); }
"return"          { printf("RETURN\t"); }
"print"           { printf("PRINT\t"); }
"input"           { printf("INPUT\t"); }
"real"            { printf("REAL\t"); }
"bool"            { printf("BOOL_TYPE\t"); }
"list"            { printf("LIST\t"); }
"function"        { printf("FUNCTION\t"); }
"void"            { printf("VOID\t"); }

"000"|"001"            { printf("BOOL_LITERAL\t"); }


"="               { printf("ASSIGN_OP\t"); }
"+"               { printf("PLUS_SIGN\t"); }
"-"               { printf("MINUS_SIGN\t"); }
"*"               { printf("MULT_SIGN\t"); }
"/"               { printf("DIV_SIGN\t"); }
"%"               { printf("MOD_SIGN\t"); }
"^"               { printf("POW_SIGN\t"); }

"<"               { printf("LESS\t"); }
"<="              { printf("LESS_EQ\t"); }
">"               { printf("GREATER\t"); }
">="              { printf("GREATER_EQ\t"); }
"=="              { printf("EQ\t"); }
"!="              { printf("NOT_EQ\t"); }

"||"              { printf("OR\t"); }
"&&"              { printf("AND\t"); }
"!"               { printf("NOT\t"); }

"{"               { printf("L_Bracket\n"); }
"}"               { printf("R_Bracket\n"); }
"["               { printf("S_L_Bracket\t"); }
"]"               { printf("S_R_Bracket\t"); }
"("               { printf("LP\t"); }
")"               { printf("RP\t"); }
";"               { printf("END_LINE\n"); }
","               { printf("COMMA\t"); }

"++"              { printf("INCREMENT\t"); }
"--"              { printf("DECREMENT\t"); }

"::"              { printf("FOR_SEPARATOR\t"); }

"//".*            { printf("SLC\n"); }  // Single-line comment
"/*"([^*]|\*+[^*/])*\*+"/" { printf("MLCS MLCE\n"); }  // Multi-line comment

[0-9]+(\.[0-9]+)? { printf("REAL_NUMBER\t"); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("IDENTIFIER\t"); }
\".*\"            { printf("STRING_LITERAL\t"); }
[ \t\n\r]+        { /* Ignore whitespace */ }

.                 { printf("UNKNOWN\n"); }

%%










