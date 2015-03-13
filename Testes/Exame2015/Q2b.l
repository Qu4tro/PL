%{

#include <strings.h>

int c = 1;
int ls = 0;
int rs = 0;

%}

%x CIT

%%

\\chapter\{[^}]]+       { yytext = toupper(yytext+9); printf("%d. %s", c++, yytext);}
\\part\{[^}]+\}         { ; }
\\label\{               { ls++; ECHO; }
\\cite\{                { printf("["); BEGIN CIT;}
\\ref\{                 { rs++; ECHO  }
<CIT>[a-zA-Z0-9]+       { printf("%s", geraChaves(yytext));}
<CIT>\}                 { printf("]"); BEGIN INITIAL; }

%%
int yywrap(){
    return 1;
}

int main(){
    yylex();
    if (ls != rs){
        printf("Aviso: ...\n") ;
    }

    return 0;
}

/* 
Input:

\part{Abertura} \label{cI}
\chapter{Inicio}
Aqui esta um exemplo interessante!
\Section{sec.1} \label{sum}
    \enum
        + primeiro caso: 2+3+1
    \ee
\part{Fecho}
\chapter{Conclusao} \label{sdois}
conclui-se que um Chapter{Exemplo} faz falta, bem como uma nova \section{Final}.
Este capitulo \ref{c1} fala de ... e por isso \cite{ar11} ou \cite{PRHas}.
Para terminar em beleza \cite{aa/1eum}.
*/

/* 
Output:

\part{Abertura} \label{cI}
\chapter{Inicio}
Aqui esta um exemplo interessante!
\Section{sec.1} \label{sum}
    \enum
        + primeiro caso: 2+3+1
    \ee
\part{Fecho}
\chapter{Conclusao} \label{sdois}
conclui-se que um Chapter{Exemplo} faz falta, bem como uma nova \section{Final}.
Este capitulo \ref{c1} fala de ... e por isso [KK] ou [KK.
Para terminar em beleza [KK].
Aviso: .....
*/

/*
Explicação:

No fundo este programa redacta um documento LaTeX. Transforma todas as citações (\cite) em "[KK]".
No fim avisa pois o número de labels e referências são diferentes.

*/





