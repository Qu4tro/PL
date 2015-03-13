#include <stdio.h>

#define CREDITO 1
#define DEBIT 2
#define MOVIMENTOS 3
#define id 3

int simb;
int proximoSimbolo();

int recMove();

int recTerm(int simbolo){

    if (simb == simbolo){
        simb = proximoSimbolo();
        return 1;
    } else {
        return 0;
    }


}

int recMovimentos(){

    /* Feito com a versão corrigida como pedido na pergunta alinea c */

    if (recTerm(MOVIMENTOS)){
        recMove();
        recTerm('.');
    } else if (recTerm(id)){
        recMovimentos();
        recMove();
        recTerm('.');
    } else {
        fprintf(stderr, "%s\n", "Erro."); 
    }

}

int recSinais(int simbolo){

    if (recTerm(CREDITO)){
        ; 
    } else if (recTerm(DEBIT)){
        ; 
    } else {
        fprintf(stderr, "%s\n", "Erro."); 
    }

}
