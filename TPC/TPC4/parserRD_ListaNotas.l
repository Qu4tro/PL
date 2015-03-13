%{
/*--- Analisador Léxico (AL) para a linguagem das "Lista de Notas" ---*/
/* 
   Definicao do Codigo dos Simbolos Terminais a ser devolvido ao Parser
   cada vez que o AL encontra um símbolo no texto-fonte a reconhecer
 */
#define PONTO 1
#define NOTAS 2
#define PVIRG 3
#define PE 4
#define PD 5
#define pal 6
#define VIRG 7
#define num 8
%}


%%
(?i:NOTAS) {return(NOTAS);}
"."        {return(PONTO); }
";"        {return(PVIRG);}
"("        {return(PE);}
")"        {return(PD);}
","        {return(VIRG);}
[a-zA-Z]+  {return(pal);}
[0-9]+     {return(num);}
.|\n       { ; } 
%%

int yywrap()
{ return(1); }
