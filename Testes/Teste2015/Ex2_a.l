%{

char* day;
char* month;
char* year;


%}

%option noyywrap
%option yylineno
%%

Jan                 { month = "01";}
Feb                 { month = "02";}
Mar                 { month = "03";}
Apr                 { month = "04";}
May                 { month = "05";}
Jun                 { month = "06";}
Jul                 { month = "07";}
Aug                 { month = "08";}
Sep                 { month = "09";}
Out                 { month = "10";}
Nov                 { month = "11";}
Dez                 { month = "12";}

[0-9]+","           { sprintf(day, "%02d", atoi(yytext));}

[0-9]{4}            { year = strdup(yytext); 
                      printf("%s-%s-%s\n", year, month, day);}

.|\n                { ; }

%%

int main(){

    day = malloc(sizeof(char) * 3);
    month = malloc(sizeof(char) * 3);
    year = malloc(sizeof(char) * 5);

    yylex();

}

