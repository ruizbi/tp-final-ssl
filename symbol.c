#include "stdio.h"
#include "stdlib.h"
#include "string.h"

#define TAMANIO 200

struct simbolos {
    char *buffer[TAMANIO];
    int indice;
} diccionario = {.indice = 0};

void Agregar(char *var) {
    diccionario.buffer[diccionario.indice] = var;
    diccionario.indice ++;
}

int existeVariable(char *var) {
    for(int i = 0; i < diccionario.indice; i++) {
        if(strcmp(diccionario.buffer[i], var) == 0) return 1; 
    }
    return 0;
}