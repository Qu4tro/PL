BEGIN                 {IGNORECASE = 1}
/^linha/              {linha++}
/<\/?[a-z]+[^>]*>/    {print}
/\<A HREF/            {split($0, bocados, /\"/); print bocados[2];}
/\<A HREF/            {split($0, bocados2, /[<>]/); print bocados2[3];}
END                   {print linha}

