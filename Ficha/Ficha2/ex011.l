%{
%}


whitespace [ \t]
%%

^(?i:Eu):{whitespace}*     {;}
^(?i:Ele):{whitespace}*    {;}

%%

int yywrap(){ 
    return(1);
}


int main(){

    yylex();
    return 0;
}
