grammar Fibo;

// regla principal: acepta FIBO(numero)
programa : 'FIBO' '(' NUMERO ')' EOF ;

NUMERO  : [0-9]+ ;
WS      : [ \t\n\r]+ -> skip ;


