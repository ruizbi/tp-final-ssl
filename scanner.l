%top{
    #include <stdio.h>
    #include <strings.h>   
    #include "parser.h"
    int yylexerrs;
    void yyerror(const char *);
    void mostrarError(char *id, int e); // xxsfsdjgk
    char pantalla[100] ;
}

%option outfile=     "scanner.c"
%option header-file= "scanner.h"
%option nounput
%option noinput
%option yylineno


Letra       [[:alpha:]]
Digito      [0-9]
LetraDigito [[:alnum:]]
Asignacion  <-
Espacio     [[:space:]]
Otros       [[:punct:]]{-}[(),+\-*/;]
Comentario  ##.*

%%

programa                return PROGRAMA;
fin-prog                return FIN;
escribir                return escribir;
leer                    return leer;
{Asignacion}            return ASIGNACION;
declarar                return declarar;
"("						return '(';
")"						return ')';
";"						return ';';
","						return ',';
"+"						return '+';
"-"						return '-';
"*"						return '*';
"/"						return '/';

{Letra}{LetraDigito}*   {yylval = strdup(yytext);return IDENTIFICADOR;}
{Digito}+               {yylval = strdup(yytext);return CONSTANTE;}
{Otros}+                                                {yylexerrs++;sprintf(pantalla, "Error léxico: cadena desconocida: %s", yytext);yyerror(pantalla);}
{Letra}{LetraDigito}*{Otros}+({LetraDigito}|{Otros}+)*  {yylexerrs++;sprintf(pantalla, "Error léxico: identificador inválido: %s",yytext);yyerror(pantalla);}
{Digito}+({Letra}|{Otros}+)*({LetraDigito}|{Otros}+)*   {yylexerrs++;sprintf(pantalla, "Error léxico: constante inválida: %s",yytext);yyerror(pantalla);}
{Comentario}+                                           // ; o Probar también con {}
{Espacio}+  	                                        // ; o Probar también con {}

%%
