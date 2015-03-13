BEGIN               {FS=";"; count = 1;}

                    {printf("%d;", count) ; count++; }
                    {

                        split($1, chars, "")
                        for (char in chars) {
                            if (char ~ /[0-9]/) {
                                printf("%c", chars[char]);
                            }
                        }

                        if ($2 == "nada"){
                            printf("%s;", $3);
                        } else if ($3 == "nada"){
                            printf("%s;", $2);
                        } else {
                            printf(";%s;%s;", $2, $3)
                        }

                        for (i = 5; i <= NF; i++) {
                            if ($i != "nada"){
                                printf("%s;", $i);
                            }
                        }
                        printf("\n")
                    }


