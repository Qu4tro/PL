BEGIN               { FS=":" }
$1 ~ "pagina"       {   
                        split($2, palavras, ",")
                        split($1,prefix," ")

                        for (palavra in palavras) {
                            indice[palavras[palavra]][length(indice[palavras[palavra]]) + 1] = prefix[2] 
                        }
                          
                    }

END                 { 
                        for (palavra in indice) {
                        printf("%s: ", palavra)
                        for (pagina in indice[palavra]) {
                            printf("%d, ", indice[palavra][pagina])
                        }
                        printf("\n")
                      }
                    }
