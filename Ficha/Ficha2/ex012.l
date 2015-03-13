%{

#include <stdio.h>

char* eu;
char* ele;

%}

whitespace [ \t]

%%

^(?i:Eu):{whitespace}*     {puts("Entrevistador:\t");}
^(?i:Ele):{whitespace}*    {puts("Entrevistado:\t");}

%%

int yywrap(){ 
    return(1);
}


int main(int argc, char *argv[]){

    yylex();

    return 0;
}
