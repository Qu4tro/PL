%{

int n_grupo = 0;
int n_elementos;
int grupo_activo;

ll_alunos* alunos = NULL;

typedef struct aluno_s {

    char* nome;
    char* num;
    char* estatuto;
    int grupo;

} *Aluno;

Aluno aluno;

void print_warning(char* s){
    fprintf(stderr, "Waning: %s\n", s);
}
void print_error(char* s){
    fprintf(stderr, "Error: %s\n", s);
    exit(1);
}

void insert_by_name(ll_alunos* alunos, Aluno aluno);

void print_alunos(ll_alunos* alunos);

%}

%option noyywrap

wss               [ ]*
digit             [0-9]+
all_until_dot     [^\.]"."
all_until_newline [^\n]\n

%x GRUPO NOME NUM STATUS

%%

^"GRUPO" wss ":" wss        {
                                n_grupo++;
                                n_elementos = 0;
                                BEGIN(GRUPO);
                            }

^"NOME" wss "=" wss         { 
                                aluno = malloc(sizeof(struct aluno_s));
                                n_elementos++;
                                aluno -> grupo = grupo_activo;

                                if (n_elementos > 3){
                                    print_error("More than 3 students in a group.");
                                    exit(1);
                                }

                                BEGIN(NOME);
                            }

^"NUM" wss "=" wss          { 
                                BEGIN(NUM);
                            }

^"STATUS" wss "=" wss       { 
                                BEGIN(STATUS);
                                insert_by_name(aluno);
                            }

<GRUPO>all_until_newline $  {
                                grupo_activo = atoi(yytext);
                                BEGIN(INITIAL);
                            }

<NOME>all_until_dot $       {
                                aluno -> nome = strdup(yytext);
                                aluno -> nome[yyleng - 1] = '\0'
                                BEGIN(INITIAL);
                            }
<NUM>all_until_dot $        {
                                aluno -> num = strdup(yytext);
                                aluno -> num[yyleng - 1] = '\0'
                                BEGIN(INITIAL);
                            }
<STATUS>all_until_dot $     {
                                aluno -> status = strdup(yytext);
                                aluno -> status[yyleng - 1] = '\0'
                                BEGIN(INITIAL);
                            }

%%

int main(){

    yylex();
    printf("Nº de grupos: %d\n", n_grupo);
    
    if (n_elementos < 3){
        print_warning("Less than 3 students in a group");
    }

    print_alunos(alunos);
    

}

