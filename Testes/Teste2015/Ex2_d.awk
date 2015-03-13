# No inicio do processamento: 
#    Meter o field seperator (o caractér pela qual o awk separa os campos (ex: Como o FS é ";", os campos de "A;B" vão ser "A" e "B")
#    Inicializar uma variável conta a 0.
BEGIN                   { FS=";"; conta = 0}

# Na primeira linha (NR é uma global com a linha que está a ser processada) imprimir o ficheiro que está a ser processado (FILENAME é uma global que tem o nome do ficheiro a ser prcessado)
NR==1                   { print "A processar: " FILENAME}

# Entre linhas as linhas 10 e 100 (inclusive) criar um counter para o 1º campo
# Exemplo:
        # ABC;1;2
        # JKL;1;2
        # CDE;1;2
        # ABC;1;2
# Vai criar um array associativo ["ABC": 2, "JKL", 1, "CDE", 1]
NR>=10 && NR<=100      { cont[$1]++ }

# Em todas as linhas (como não tem regra), incrementar o conta pelo número de campos.
                        { conta += NF }

# Se a linha corresponder na expressão regular "/ana.*salana.*costa/" imprimir o 1º campo, a string " -> " e o 6º campo
/ana.*salana.*costa/    { print $1 " -> " $6 }


# Se o 1º campo corresponder na expressão regular "rui" e o 2º campo for diferente de 40 imprimir o 2º campo, a string " => " e o nº de campos da linha
$1 ~ "rui" && $2!=40    { print $2 " => " $NF }


# No final do processamento imprimir "....." e a média de campos por linha.
# A média foi feita com:
#    (conta (que é o somatório dos campos do ficheiro todo, como definimos acima com a regra "conta += NF 
# a dividir por 
# NR, que é o número de records neste são neste caso linhas. 
END                     { print "....." conta/NR }
