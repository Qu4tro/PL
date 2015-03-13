%{
#include <stdio.h>

#define INIC 5
#define FIM 6
#define Virg 7
#define pal 8
#define num 9

%}

%%

(?i:inicio)    {return (INIC);}
(?i:fim)       {return (FIM);}
","            {return (Virg);}
[a-zA-Z]+      {return (pal);}
[0-9]+         {return (num);}
.|\n           {;}

%%


int yywrap()
{ return(1); }

int main(){ 
    int s;
    while (s = yylex()){
        printf("%d ", s);
    }
    putchar('\n');
    return 0;
}
