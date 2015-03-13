Ficha 2  -  Processamento de linguagens
=====================

#### Exercício Nº 1: Processador de Questionários

Suponha que ao fim de cada entrevista um Repórter produz um texto com as perguntas e respostas, distinguindo umas das outras porque as perguntas começam com 'EU:', no início da linha, e as respostas começam com 'ELE:', também no início da linha.

Nesse contexto, pretende-se desenvolver um FT para processar os questinários que:

* Simplesmente retire do texto original as tais marcas 'EU:' e 'ELE:', devolvendo todo o resto da entrevista sem qualquer alteraão. Melhore o filtro, de modo a tratar as marcas, quer estejam escritas em maiúsculas, quer em minsculas;

    **Resolução**

    Um ficheiro flex é separado em três partes: As definições (em C), as regras (um par regra-acção), e o código do utilizador.
    Nesta primeira alinea, a única coisa que fazemos é detectar as marcas pedidas e não fazer nada com elas. Fazer o filtro *case-insensitive* é uma questão de usar o operador (?i:).

        (?i:Eu):[ \t]     {;}
        (?i:Ele):[ \t]    {;}


* Substituia a marca 'EU' pela palavra 'Entrevistador' e a marca 'ELE' por 'Entrevistado';

    **Resolução**

    Neste caso, em vez de fazer nada, imprimimos o que nos é pedido, quando encontramos o "Eu" e o "Ele", para os substituir.

        (?i:Eu):[ \t]     {printf("Entrevistador:\t");}
        (?i:Ele):[ \t]    {printf("Entrevistado:\t");}

* Substituia a marca 'EU' pelo nome do entrevistador e a marca 'ELE' pelo nome do entrevistado, supondo que no incio encontrará as respectivas definiçes (ordem irrelevante) na forma 'EU=nome.' ou 'ELE=nome.'

    **Resolução**
