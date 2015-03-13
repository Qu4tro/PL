
BEGIN               { FS=" "; RS="," }

                    {   abreviatura = substr($1, 1, length($0) - 1)
                        split(abreviatura, chars, "")
                        printf("%s: ", $1)

                        for (char in chars) {
                            printf("[%c%c]", tolower(chars[char]), toupper(chars[char]))
                        }
                        printf("\n")
                    }
