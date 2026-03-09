%{
/* calculadora.y - analizador sintactico */
#include <stdio.h>
#include <math.h>

void yyerror(const char *s);
int yylex();

double newton_raphson(double n) {
    if (n < 0) {
        printf("Error: no se puede sacar raiz de numero negativo\n");
        return -1;
    }
    if (n == 0) return 0;

    double x = n / 2.0;
    double tolerancia = 1e-10;
    int max_iter = 1000;
    int i;

    for (i = 0; i < max_iter; i++) {
        double x_nuevo = 0.5 * (x + n / x);

        if (fabs(x_nuevo - x) < tolerancia) {
            return x_nuevo;
        }

        x = x_nuevo;
    }

    return x;
}
%}

%union {
    double dval;
}

%token <dval> NUMERO
%token SQRT LPAREN RPAREN
%left MAS MENOS
%left POR DIV
%type <dval> expr

%%

programa:
    programa expr '\n'  { printf("resultado: %f\n", $2); }
  | programa expr       { printf("resultado: %f\n", $2); }
  | /* vacio */
  ;

expr:
    expr MAS expr       { $$ = $1 + $3; }
  | expr MENOS expr     { $$ = $1 - $3; }
  | expr POR expr       { $$ = $1 * $3; }
  | expr DIV expr       {
        if ($3 == 0) { printf("Error: division por cero\n"); $$ = 0; }
        else $$ = $1 / $3;
    }
  | SQRT LPAREN expr RPAREN  { $$ = newton_raphson($3); }
  | LPAREN expr RPAREN  { $$ = $2; }
  | NUMERO              { $$ = $1; }
  ;

%%

void yyerror(const char *s) {
    printf("Error sintactico: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("uso: ./calculadora archivo.txt\n");
        return 1;
    }

    extern FILE *yyin;
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("No se pudo abrir el archivo: %s\n", argv[1]);
        return 1;
    }

    printf(" Calculadora con Newton-Raphson \n");
    yyparse();
    fclose(yyin);
    return 0;
}


