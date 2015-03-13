Ficha 1  -  Processamento de linguagens
=====================

1. **Pesquisa de Padrões em Texto**
------------------

Invoque o comando **egrep**:
        
    egrep PADRAO pltesteER.txt

primeiro, para ver o resultado de usar os padrões descritos pelas ER seguintes:

**R:**

>        egrep "pedro" pltesteER.txt
>    Retorna todas as linhas que contêm a string "pedro".
>    
>        egrep "[Pp]edro" pltesteER.txt
>    Retorna todas as linhas que contêm a string "pedro" começando ou não com letra maiúsculas.
>
>        egrep "[Pp]edro|[Dd][Aa]niela" pltesteER.txt
>    Retorna todas as linhas que contêm a string "pedro" começando ou não com letra maiúsculas ou que contêm a string "daniela" em que a primeira ou segunda letra podem ser tanto maiúsculas como minúsculas.
>
>        egrep "[Pp]edro|[Dd][Aa][a-zA-Z]+" pltesteER.txt
>    Retorna todas as linhas que contêm a string "pedro" começando ou não com letra maiúsculas e que contêm uma string que começa por um "d" ou "D" seguido por um "a" ou "A", e que em seguida tem outra letra do alfabeto, maiúsculas ou minúsculas.
>
>        egrep "[Pp]edro|[Dd][Aa][a-zA-Z]+" pltesteER.txt
>    Retorna todas as linhas que contêm a string "pedro" começando ou não com letra maiúsculas e que contêm uma string que começa por um "d" ou "D" seguido por um "a" ou "A", e que em seguida pode ou não ter outra letra do alfabeto, maiúsculas ou minúsculas.
>
>        egrep "[Dd][Aa]?[a-zA-Z]*" pltesteER.txt
>    Retorna todas as linhas que contêm uma string que começa por um "d" ou "D", seguido ou não, por um "a" ou "A", e que em seguida pode ou não ter outras letra do alfabeto, maiúsculas ou minúsculas.
>

e depois, para procurar em "pltesteER.txt":

*  com a marca concreta 'HTML' e só essas linhas; incluia também a marca de fecho '/HTML'; note que a marca 'HTML' ou 'html' devem ser ambas encontradas;

        egrep "html|HTML" pltesteER.txt

* todas as linhas com qualquer marca do dialeto HTML (palavra entre os sinais '<' e '>'); altere a sua procura de modo a encontrar também as marcas que contêm atributos além do nome do elemento;

        egrep "</?[a-zA-Z]+> pltesteER.txt"
        egrep "</?[a-zA-Z ]+[a-zA-Z=\":/\.~ ]*>" pltesteER.txt

* todas as linhas com a palavra 'linha' encostadas ao início de uma linha; só as que contenham 'linha' sem ser no início da linha;

        egrep "^linha" pltesteER.txt
        egrep "linha" pltesteER.txt

* todas as linhas terminadas em '1' (o algarismo um no fim da linha);

        egrep "1$" pltesteER.txt

* todas as linhas que contenham números; imponha que os números tenham 2 ou mais dígitos;

        egrep "[0-9]" pltesteER.txt
        egrep "[0-9]{2,}" pltesteER.txt

* por fim, procure todas as linhas que contenham os sinais de pontuação ':' ou ';' em todos os ficheiros de texto da sua diretoria de trabalho.

        egrep ":|;" *


2. Desenvolvimento de filtros de texto com o gawk
-------------------------

Execute os comandos abaixo e analise com cuidado o seu resultado:

**R:**

>        gawk '{ print $1 }' utilizadores.txt
>
>    Imprime tudo até ao primeiro whitespace. Podemos verificar isso ao procurar por espaços com ***grep " " utilizadores.txt*** e verificar que essas linhas estão de facto cortadas a partir do primeiro whitespace.
>
>        gawk '{ print $1 }' pltesteER.txt
>
>    Como acima, imprime tudo até ao primeiro whitespace. Neste exemplo podemos verificar que ignora também qualquer whitespace que tenha no inicio da linha.
>
>        gawk '{ print $2 }' pltesteER.txt
>
>    Imprime do primeiro whitespace até ao segundo whitespace. Ignora whitespace no inicio da linha e se não houver mais texto depois do primeiro whitespace imprime uma linha vazia.
>
>        gawk -F: '{ print $1 }' utilizadores.txt
>
>    Usando a flag ***-F***, que permite indicar o separador que queremos utilizar(em vez de utilizar o whitespace), separamos o ficheiro *utilizadores.txt* pelo carácter **":"**. Ai imprimos a primera coluna delimitada pelos dois pontos. Neste caso como o ficheiro dado é uma cópia do ficheiro /etc/passwd, o que estamos a fazer com este comando é extrair os utilizadores do sistema.
>
>        gawk -F: '{ print $3 }' utilizadores.txt
>
>   Da mesma forma do exercicio anterior separamos os campos pelo carácter **":"** que delimita o ficheiro, e imprimimos a 3º coluna, que representa o *User Id* dos utilizadores especificados no ficheiro.
>
>        gawk -F: '$1=="prh" { print $1 "->" $6 }' utilizadores.txt
>
>    Esta expressão imprime o utilizador (1º coluna) e o seu respectivo *path* para a *home folder* (6ºcoluna), se o utilizador for igual a *"prh"*.
>
>        gawk -F: '$1=="prh"||$1=="jcr" { print }' utilizadores.txt<>
>
>    Esta expressão imprime a linha toda do ficheiro, se o utilizador (1º coluna), for igual a *"prh"* ou igual a *"jcr"*.
>
    
    e depois disso execute repetidamente o comando:

        gawk -f FILE.gawk utilizadores.txt 

em que FILE vai sendo 'expusers1' e 'expusers2', observando com cuidado o resultado produzido em cada caso, sendo:

expusers1.gawk

    BEGIN             { FS=":"; conta=0 }
    NR==1             { print "A processar o ficheiro: " FILENAME }
    NR>=1 && NR<=10   { print $1 }
                      { conta+=NF }
    END               { print conta " - " NR  }

expusers2.gawk

    BEGIN              { FS=":"; conta=0 }
    /rita/             { conta++; print $1 " -> " $6 }
    /prh|jcr/          { conta++; print $1 " -> " $6 }
    /uucp/,/rpm/       { conta++; print }
    /x.*sbin/ && $3>40 { conta++; print "Em sbin: " $0 }
    $1 ~ "nuno"        { conta++; print $1 " = " $NF }
    END                { print conta " - " NR " = " conta/NR }


**R:**

> Correndo e analisando os dois ficheiros, concluimos que:

> *expusers1.gawk* usa ***":"*** como delimitadores, como nos exercicios acima. Começa por imprimir a string dada e a variável global FILENAME(que contêm o ficheiro que está a ser analisado). Posteriormente o programa, imprime os primeiros 10 utilizadores do ficheiro e ao finalizar imprime, o número de campos(NF) e linhas(NR) analisadas respectivamente.

> *expusers2.gawk"* também usa o delimitador do ficheiro acima. Ao percorrer o ficheiro, imprime o utilizador e a respectiva *home folder*, se a linha corresponder ao regex "rita" ou "prh|jcr". Imprime todas as linhas entre as linhas que correspondem ao regex "uucp" e "rpm" respectivamente. Se a 3ºcoluna (*uid*) for maior que 40 e a linha corresponder ao regex "x.\*sbin\*" então imprime a linha toda. Se "nuno" pertencer ao primeiro campo, imprimir o primeiro campo (utilizador) e o último campo (shell). Por fim imprime, quantas linhas foram impressas, o número de linhas processados, e a razão entre as impressas e as processadas.

Com base nos exemplos anteriores, escreva um ficheiro 'exppltesteER.gawk' para processar o ficheiro de texto 'pltesteER.txt' conforme os requisitos solicitados nas alíneas seguintes:

1. Contar todas as linhas começadas pela palavra 'linha';
2. Contar todas as linhas que contenham marcas HTML (só de abertura e depois de abertura e fecho), imprimindo a respetiva linha;
3. Detetar todas as linhas que tenham ancoras HTML (marcas '< A' com atributo 'HREF') e imprimir o respetivo URL;
4. Detetar todas as linhas que tenham ancoras HTML e imprimir o respetivo texto associado.



**R:**

    BEGIN                 {IGNORECASE = 1}
    /^linha/              {linha++}
    /<\/?[a-z]+[^>]*>/    {print}
    /\<A HREF/            {split($0, bocados, /\"/); print bocados[2];}
    /\<A HREF/            {split($0, bocados2, /[<>]/); print bocados2[3];}
    END                   {print linha}


3. **Desenvolvimento de filtros de texto com o gawk: inscritos.txt**
------------------

Faça um exercício semelhante ao anterior, construindo agora um ficheiro 'expinscr.gawk' para processar o texto 'inscritos.txt' conforme solicitado nas alíneas seguintes:

1. Imprimir o nome e o email dos concorrentes inscritos entre a 5ª e a 15ª posições;
2. Imprimir o nome dos concorrentes que se inscrevem como 'Individuais' e são de 'Valongo';
3. Imprimir o telemóvel e a prova em que está inscrito cada concorrente cujo nome seja 'Paulo' ou 'Ricardo' e cuja operadora seja a Vodafone;
4. Imprimir os 20 primeiros registos com os nomes convertidos para minúsculas.


**R:**

        BEGIN                                       { FS="\t" }
        NR>=5 && NR<=15                             { print $1 " -> " $NF}
        NR>=3 && NR<=22                             { $1 = tolower($1); print}
        $10 ~ /Individual/  && $12 ~ /Valongo/      { print $1}
        $1 ~ /^Ricardo|^Paulo/ && $11 ~ /^91/       { print $11 " -> " $5 }


4. **Desenvolvimento de filtros de texto com o gawk: processos.txt**
------------------
Neste exercício vais calcular algumas frequências de alguns elementos, a ideia é utilizares arrays associativos para o efeito.

TODO

1. Calcula a frequência de processos por ano (primeiro elemento da data);
2. Calcula a frequência de nomes (considera um nome uma palavra e propaga o cálculo por todos os campos que contenham nomes);
3. Calcula a frequência dos vários tipos de relação: irmão, sobrinho, etc.

**R:**

5. **Desenvolvimento de filtros de texto com o gawk: arq-son.txt**
------------------

TODO

Especifica scripts em awk para responder às seguintes questões:

1. Quais os títulos das canções alentejanas?
2. Quantas músicas estão catalogadas por distrito/área geográfica?
3. Quais os títulos das músicas com áudio disponível em MP3?
4. Quais os títulos das músicas e quantas são que têm a palavra 'Jesus' no título?

**R:**
