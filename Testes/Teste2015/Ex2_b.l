%{

int total = 0;

%}

%option noyywrap
%option yylineno

%x MUL ADD

%%

<INITIAL,MUL,ADD>"acc off"   { printf("%d\n", total);
                               total = 0; 
                               BEGIN(INITIAL);  }

<INITIAL,MUL,ADD>"mul on"    { BEGIN(MUL);           }
<INITIAL,MUL,ADD>"add on"    { BEGIN(ADD);           }


<ADD>[0-9]+                  { total += atoi(yytext); }
<MUL>[0-9]+                  { total *= atoi(yytext); }

.|\n                         { ; }

%%

int main(){

    yylex();

}
