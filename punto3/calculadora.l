%{
/* calculadora.l - analizador lexico */
#include "calculadora.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+(\.[0-9]+)?   { yylval.dval = atof(yytext); return NUMERO; }
"sqrt"              { return SQRT; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"+"                 { return MAS; }
"-"                 { return MENOS; }
"*"                 { return POR; }
"/"                 { return DIV; }
[ \t\n]             { /* ignorar espacios */ }
.                   { printf("caracter desconocido: %s\n", yytext); }

%%

int yywrap() { return 1; }


