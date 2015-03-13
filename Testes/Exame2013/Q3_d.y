%{

int yylex();

int yyerror(char *s) {
    fprintf(stderr, "%s, line %d\n", s, yylineno);
    return 0;
}

Familia 
NamesLL init();
NamesLL insert();

%}

%union {
    int    vali;
    char*  vals;
}

%token <vali> inteiro
%token <vals> str

%token FAMILIA PAI MAE CASAMENTO FILHOS

%start Z

%%

Z        : familias
         ;

familias  : familia
          | familias familia
          ;

familia   : FAMILIA pai mae casamento filhos
          ;

pai       : PAI str ',' str date
          ;

mae       : MAE str ',' str date
          ;

date      : inteiro '-' inteiro '-' inteiro
          ;

casamento : CASAMENTO str inteiro
          ;

filhos    : FILHOS filhos1 "."
          ;

filhos1   :
          | filho filhos2
          ;

filhos2   :
          | filhos2 ',' filho
          ;

filho     : str
          ;


%%

#include "lex.yy.c"


int main(int argc, char* argv[]){
    yyparse();
    return 0;
}
