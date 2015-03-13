BEGIN                                       { FS="\t" }
NR>=5 && NR<=15                             { print $1 " -> " $NF}
NR>=3 && NR<=22                             { $1 = tolower($1); print}
$10 ~ /Individual/  && $12 ~ /Valongo/      { print $1}
$1 ~ /^Ricardo|^Paulo/ && $11 ~ /^91/       { print $11 " -> " $5 }
