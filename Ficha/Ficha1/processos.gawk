/<data>/ {split($0, data, "[>-]"); anos[data[2]] += 1}
/<nome>/ {split($0, tag_nome, /[> ]/); nomes[tag_nome[6]] += 1}
/<pai>/ {split($0, tag_pai, /[> ]/); nomes[tag_pai[6]] += 1}
/<mae>/ {split($0, tag_mae, /[> ]/); nomes[tag_mae[6]] += 1}





