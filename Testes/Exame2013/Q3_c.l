%{

%}
%option noyywrap
%%


[,-.]                { return yytext[0];}
"FAMILIA"            { return (FAMILIA);}
"Pai:"               { return (PAI);}
"Mae:"               { return (MAE);}
"Casamento:"         { return (CASAMENTO);}
"Filhos:"            { return (FILHOS);}

[0-9]+               { yylval.vali = atoi(yytext);   return(integer); }
\"[^"]*\"            { yylval.vals = strdup(yytext); return(string); }

.|\n                 { ; }

%%
