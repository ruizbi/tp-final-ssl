/********************************************
Grupo 3                                     *
        Alumnos                 Legajo      *
        Bramuglia Santiago      166854-7    *
        Carucci Juan Manuel     143657-0    *
        Ruiz Bruno              163163-9    *
                                            *
*********************************************/


#include <stdio.h>
#include "parser.h"
#include "scanner.h"
#include "semantic.h"
#include "symbol.h"

extern int yysintxerrs;
extern int errsem;
int yylexerrs;

int main() {
        
        switch( yyparse() ){
	case 0:
		puts("Compilacion terminada con exito"); 
        printf("Errores sintácticos: %d - Errores léxicos: %d - Errores semanticos: %d\n",yysintxerrs,yylexerrs, errsem);
        return 0;
	case 1:
		puts("Compilacion no terminada con exito"); 
        printf("Errores sintácticos: %d - Errores léxicos: %d - Errores semanticos: %d\n",yysintxerrs,yylexerrs, errsem);
        return 1;
	case 2:
		puts("Memoria insuficiente"); 
        return 2;
	}
   return 0;
}


