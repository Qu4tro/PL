%{

#include <stdio.h>

char* eu;
char* ele;

%}

whitespace [ \t]

%%

^(?i:Eu)=[^\n]*            {eu = strdup(yytext + 3);}
^(?i:Ele)=[^\n]*           {ele = strdup(yytext + 4);}

^(?i:Eu):{whitespace}*     {printf("%s:\t", eu);}
^(?i:Ele):{whitespace}*    {printf("%s:\t", ele);}

\n\n                       {;}

%%

int yywrap(){ 
    return(1);
}


int main(int argc, char *argv[]){

    yylex();

    return 0;
}
