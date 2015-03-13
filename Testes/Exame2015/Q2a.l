/*
BEGIN               { FS=" "; RS="," }

                    {   abreviatura = substr($1, 1, length($0) - 1)
                        split(abreviatura, chars, "")
                        printf("%s: ", $1)

                        for (char in chars) {
                            printf("[%c%c]", tolower(chars[char]), toupper(chars[char]))
                        }
                        printf("\n")
                    }

*/

%{

char toupper(char c){
    if (c >= 'a' && c <= 'z'){
        return c - 32; 
    }
    return c;
}

char tolower(char c){
    if (c >= 'A' && c <= 'Z'){
        return c + 32; 
    }
    return c;
}

void print_regex(char* text){

    char* abreviatura, temp;

    abreviatura = text;

    while (abreviatura[0] != '('){
        abreviatura += 1; 
    }
    abreviatura += 1;
    temp = abreviatura
    while (temp[0] != ')'){
        temp += 1; 
    }
    temp[0] = '\0';

    printf("%s:", abreviatura);

    for(;text != ' '; text++){
        printf("[%c%c]", tolower(text[0], toupper[text[0]]));
    }
}


%}



%%

[^\ ]+" ("[^")"]+")[\ ]*,"          {print_regex(yytext);} 

. | \n                              {;}





%%

int main(){

    yylex();

    return 0;
}
