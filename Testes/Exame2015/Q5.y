%{

int n = 0;

int yylex();

typedef struct {
    Value array;
    int size;
} *Array;

typedef struct {
    int isNum;
    int num;
    char* pal;
} *Value;

int isID(Array a, int ind);
int isNum(Array a, int ind);

Array single(int x);

Array insert(Array a, int x);

%}


%union {
    int    integer;
    char*  string;
    Array  array;
    Value  value;

}

%token <integer> num
%token <string> pal

%type <array> Args
%type <Value> Arg

%%

Listas            : Lst             {n += 1;}
                  | Listas Lst      {n += 1;}
                  ;

Lst               : '(' Args ')'        {if (isID($2, 0)){
                                            if (isNum($2, 1) ||
                                                isNum($2, 2) ||
                                                isNum($2, 3)){
                                                    printf("Not nums after id.")
                                               }
                                        } else {
                                            if ($2 -> array[0] -> num != $2 -> size){
                                                printf("Not %d numbers after first number", $2 -> array[0] -> num);
                                            }
                                        }
                                        printf("Lista nº: %d", n);
                                        printf("Tamanho: %d", $2 -> size);
                                        }
                  ;

Args              : Arg                 {$$ = single($1);}
                  | Args ',' Arg        {$$ = insert($1, $3);}
                  ;

Arg               : num                 {$$ -> num = atoi(num); $$ -> isNum = 1;}
                  | pal                 {$$ -> pal = strdup(yytext); $$ -> isNum = 0;}
                  ;

%%

#include "lex.yy.c"


int main(int argc, char* argv[]){
    yyparse();
    return 0;
}
