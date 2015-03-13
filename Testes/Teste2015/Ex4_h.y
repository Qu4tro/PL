%{

int existeConta(char* id);
int balancoConta(char* id);

int yylex();

int creditos = 0;
int debitos = 0;

%}

%union {
    int    vali;
    char*  vals;
}

%token <vals> id
%token <vali> num
%token <vals> str
%token <vals> data

%token ETASK BTASK

%token CREDITO DEBITO

%type <num> Sinal

%%

transacoes        : Cabec Movimentos ETASK
                   {code = add_instr(code, "START");}                              

                  ;

Cabec             : BTASK data
                  ;


Movimentos        : Move '.'
                  | Movimentos Move '.'
                  ;


Move              : id ';' Sinal ';' num ';' id ';' str 
                        {if ($3 < 0){
                            if (existeConta($1)){
                                if (balancoConta($1) >= $3){
                                    ;  /* Valido */
                                } else {
                                    fprintf(stderr, "Balanço insuficiente!");
                                }
                            } else {
                                fprintf(stderr, "Conta não existe!") 
                            }
                        } 
                        }
                  ;

Sinal             : CREDITO                 {creditos++; $$ = 1;}
                  | DEBITO                  {debitos++; $$ = -1;}
                  ;

%%

#include "lex.yy.c"


int main(int argc, char* argv[]){
    yyparse();
    return 0;
}
