#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "symbol.h"
#include "semantic.h"

int temporales;
const int id_max = 20;

char* proxTemporal(){
	char nuevoTemporal[id_max];
	temporales++;
	sprintf(nuevoTemporal, "Temp#%d", temporales);
	Declarar(nuevoTemporal);
	return strdup(nuevoTemporal);
}
void Declarar(char* idPush) {
    printf("Reserve %s,4\n", idPush);
}
void Guardar(char* idPush, char* idPop) {
    printf("Store %s, %s\n", idPush, idPop);
}
void Leer(char *id) {
    printf("Read %s, Integer\n", id);
}
void Escribir(char *id) {
    printf("Write %s, Integer\n", id);
}
void Cargar() {
    printf("Load rtlib, \n");
}
void Salir() {
    printf("Exit,\n");
}
char* Invertir(char* idEntrada) {
  	char *idSalida;
	idSalida = proxTemporal();
	printf("NEG %s, %s\n", idEntrada, idSalida);
	return idSalida;
}
char* Sumar(char* idEntrada1, char *idEntrada2) {
    char *idSalida;
	idSalida = proxTemporal();
	printf("ADD %s,%s,%s\n", idEntrada1, idEntrada2, idSalida);
	return idSalida;
}
char* Multiplicar(char* idEntrada1, char* idEntrada2) {
    char *idSalida;
	idSalida = proxTemporal();
	printf("MUL %s,%s,%s\n", idEntrada1, idEntrada2, idSalida);
	return idSalida;
}
char* Dividir(char *idEntrada1, char *idEntrada2) {
    char *idSalida;
	idSalida = proxTemporal();
	printf("DIV %s,%s,%s\n", idEntrada1, idEntrada2, idSalida);
	return idSalida;
}
char* Restar(char* idEntrada1, char* idEntrada2) {
    char *idSalida;
	idSalida = proxTemporal();
	printf("SUBS %s,%s,%s\n", idEntrada1, idEntrada2, idSalida);
	return idSalida;
}
