%code top{
#include <stdio.h>
#include "scanner.h"
#include "semantic.h"
#include "symbol.h"

int yysintxerrs;
char *error_inicio[] = {"Error semantico: identificador ", "Error semantico: identificador "};
char *error_fin[] = {" ya declarado", " NO declarado"};
int errsem = 0;
}

%code provides{

extern int yylexerrs;

}

%define api.value.type {char *}


%defines "parser.h"
%output  "parser.c"
%token PROGRAMA FIN IDENTIFICADOR CONSTANTE leer declarar escribir
%token ASIGNACION "<-"
%start todo
%define parse.error verbose

%left  '-'  '+'
%left  '*'  '/'
%precedence NEG

%%
todo	: PROGRAMA {Cargar();} bloquePrograma FIN {Salir(); if (yynerrs || yylexerrs || errsem) YYABORT;} ;
bloquePrograma : %empty
	           | bloquePrograma bloque
	           ;
bloque	: declarar  IDENTIFICADOR ';'   {if(!existeVariable($3)){
                                                Agregar($3);
                                                Declarar($3);}
                                        else {mostrarError($3, 0);
                                            YYERROR;}
                                        } 
	    | leer '('listaIdentificadores')' ';'  
        | escribir '('listaExpresiones')' ';'  
        | IDENTIFICADOR "<-" expresion ';'     {Guardar($3,$1);}
	    | error ';'
	    ;
listaIdentificadores: IDENTIFICADOR                         {if(existeVariable($1)) Leer($1); else {mostrarError($1, 1); YYERROR;}}
	                | listaIdentificadores ',' IDENTIFICADOR {if(existeVariable($3)) Leer($3); else {mostrarError($3, 1); YYERROR;}}
                    ;
listaExpresiones : expresion                        {Escribir($1);}
                 | expresion',' listaExpresiones    {Escribir($1);}
                 ;

expresion : secundaria                  {$$=$1;}
           | '-'secundaria %prec NEG    {$$ = Invertir($2);}
           | '('expresion')'            {$$ = $2;}
          | expresion '+' expresion     {$$ = Sumar($1, $3);}
          | expresion '-' expresion     {$$ = Restar($1, $3);}
          | expresion '*' expresion     {$$ = Multiplicar($1, $3);}
          | expresion '/' expresion     {$$ = Dividir($1, $3);}
          | '('error')'  
          ;

secundaria : IDENTIFICADOR {if(!existeVariable($1)){
                                    mostrarError($1,1); YYERROR;
                                }else 
                                    $$ = $1;
                            };
           | CONSTANTE 
           ;
%%


/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
    if (yychar == YYEMPTY){
        printf("línea #%d: %s\n", yylineno, s);
    }
    else {
        yysintxerrs++;
        printf("línea #%d: %s\n", yylineno, s);
    }
	return;
}

void mostrarError(char *id, int e){
	char *buffer = malloc(strlen(error_inicio[e])+strlen(error_fin[e]) + strlen(id) + 1);
	sprintf(buffer, "%s%s%s", error_inicio[e], id,error_fin[e]);
	yyerror(buffer);
	errsem++;
	free(buffer);
}