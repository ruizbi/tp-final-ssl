#ifndef HEADER_FILE_SEMANTIC
#define HEADER_FILE_SEMANTIC

char* proxTemporal();
void Declarar(char* idPush);
void Guardar(char* idPush, char* idPop);
void Leer(char *id);
void Escribir(char *id);
void Cargar();
void Salir();
char* Invertir(char* idEntrada);
char* Sumar(char* idEntrada1, char *idEntrada2);
char* Multiplicar(char* idEntrada1, char* idEntrada2);
char* Dividir(char *idEntrada1, char *idSalida2);
char* Restar(char* idEntrada1, char* idEntrada2);

#endif
