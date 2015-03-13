
/*--- Parser Recursivo Descendente (RD) para a linguagem das "Lista de Notas" ---*/

/*--- Gramática Independente de Contexto (GIC) para a linguagem das "Lista de Notas" ---

1-  Pauta    -> Cabeca Corpo "."
2-  Cabeca   -> NOTAS
3-  Corpo    -> Aluno Alunos
4-  Aluno    -> IdAl "(" Notas ")
5-  Alunos   -> &
6-            | ";" Corpo
7-  IdAl     -> pal
8-  Notas    -> Nota LstNotas
9-  Nota     -> num
10- LstNotas -> &
11-           | "," Notas
*/

/*--- 2 frases corretas da linguagem das "Lista de Notas" ---
  NOTAS  ana(12) .
  Notas  ana(10,12,14); luis(15); joana(16,14).
*/

#include <stdio.h>
#include <string.h>
#include "lex.yy.c"

int proxSimb;

void erro (int codErro) {
	switch (codErro) {
		case 1: printf("Erro sintatico ao reconhecer Pauta.\n Esperavamos 'NOTAS' e foi lido (%d).\n", proxSimb);
				break;
		case 2: printf("Simbolo lido (%d) diferente do esperado\n", proxSimb);
				break;
		case 3: printf("Erro sintatico ao reconhecer Cabeçalho.\n Esperavamos 'NOTAS' e foi lido (%d).\n", proxSimb);
				break;
		case 4: // estas mensagens (casos 4 a 11) devem seguir a filosofia das anteriores,
		case 5: // indicando com precisão, o símbolo esperado e o realmente lido! 
		case 6: 
		case 7: // por questões de tempo optou-se por usar para todos estes casos
		case 8: // a mensagem correta, mas simplificada, que está abaixo.
		case 9:
		case 10: // mensagem genérica para absorver todos os casos anteriores
		case 11: printf("Erro sintatico\n");
				 break;
	}
}

/*+++ Reconhecedor Genérico para os Símbolos Terminais +++*/
void recT (int codTerminal) {
	if (proxSimb == codTerminal){
		proxSimb = yylex();
	} else {
		erro(2);
		exit(1);
	}
}

/*+++ Reconhecedores Específicos para cada Símbolo Não-Terminal +++*/
void recNotas();

void recLstNotas () {
	if (proxSimb == PD) {
		;
	} else if (proxSimb == VIRG) {
		recT(VIRG);
		recNotas();
	    } else {
		    erro(10);
		    exit(1);
	    }
}

void recNota () {
	if (proxSimb == num) {
		recT(num);
	} else {
		erro(9);
		exit(1);
	}
}

void recNotas () {
	if (proxSimb == num) {
		recNota();
		recLstNotas();
	} else {
		erro(8);
		exit(1);
	}
}

void recIdAl () {
	if (proxSimb == pal) {
		recT(pal);
	} else {
		erro(6);
		exit(1);
	}
}

void recCorpo();

void recAlunos () {
	if (proxSimb == PONTO) {
		;
	} else if (proxSimb == PVIRG){
		recT(PVIRG);
		recCorpo();
	    } else {
		    erro(7);
		    exit(1);
	    }
}

void recAluno () {
	if (proxSimb == pal) {
		recIdAl();
		recT(PE);
		recNotas();
		recT(PD);
	} else {
		erro(5);
		exit(1);
	}
}

void recCorpo () {
	if (proxSimb == pal) {
		recAluno();
		recAlunos();
	} else {
		erro(4);
		exit(1);
	}
}

void recCabeca () {
	if (proxSimb == NOTAS) {
		recT(NOTAS);
	} else {
		erro(3);
		exit(1);
	}
}

void recPauta () {
	if (proxSimb == NOTAS) {
		recCabeca();
		recCorpo();
		recT(PONTO);
	} else {
		erro(1);
		exit(1);
	}
}

/*+++ Programa Principal que só tem de mandar reconhecer o Axioma +++*/
int main () {
	printf("Vai iniciar o parsing\n");
    proxSimb = yylex();
	recPauta();
	printf("Terminou o parsing\n");
	return 0;
}
