### C3W4 - Regular expressions

## Regular expressions
# Can be thought of as a combination of literals and metacharacters
# literal = language(words), metacharacters = laguage(grammar)

# Literals: words that match exactly
# Metacharacters: 
#   - ^ represents the start word of the line > ^i think
#   - $ represents the last word at the end of the line  > morning$
#   - [] Character classes: List a set of characters we will accept
#     > [Bb] [Uu] [Ss] [Hh] (Look for BUSH/bush)
#   - Combination: ^[Ii] am
#   - Range of letters or numbers: ^[0-9][a-zA-Z]
#   - Characters that not appear: [^?.]$
#   - . can be any character: > 9.11
#   - | OR: flood|fire search for flood or fire
#   - Combination: ^[Gg]ood|[Bb]ad
#   - (and) ^([Gg]ood|[Bb]ad) both words at the beggining of the line
#   - ? optional expression: > [Gg]eorge( [Ww]\.)? [Bb]ush = W/w is optional
#   - */+ repeat any/(at least one) of the item: (.*)/[0-9]+(.*)[0-9]+
#   - {and} interval quantifiers, min/max number of matches: [Bb]ush( +[^ ]+ +){1,5} debate
#   - and m,n at least m but not more than n matches
#         m = m matches
#         m, = at least m matches
#   - \1,\2 reference to the matched text: +([a-zA-Z]+) +\1
#   - * matches the longest possible string: ^s(.*)s$  or ^s(.*?)s$

# Text processing via regular expressions is very powerfull way to extract
# data from unfriendly sources
# Used with grep, grepl, sub, gsub that involve searching for text strings
