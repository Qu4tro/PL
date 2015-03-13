#define id 0
#define CAMINHOS 1

int prox_simb;

void error();

int yylex();

void recTem(int simb){

    if (prox_simb == simb){
        prox_simb = yylex();
    } else {
        error();
    }


}

int recX();
int recY();

int recPonto(){

    recTem(id);
    recTem('(');
    recX();
    recTem(',');
    recY();
    recTem(')');

}

int recPS(){

    switch (prox_simb) {
        case id:
                    recPonto();
                    recPS();
                    break;
        case CAMINHOS:
                    break;
        default:
                    error();
            
    }
}

int recPontos(){

    recPonto();
    recPS();
}

