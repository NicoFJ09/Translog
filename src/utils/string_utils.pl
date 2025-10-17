% ===============================================
% STRING UTILS - Conversión de string a lista de palabras
% ===============================================

% Convierte una cadena en una lista de palabras/tokens
string_to_word_list(String, WordList) :-
    string_lower(String, LowerCase),
    remove_accents(LowerCase, NoAccents),
    split_string(NoAccents, " ", " \t\n", Parts),  % separa por espacios
    maplist(split_punctuation, Parts, NestedTokens),
    flatten(NestedTokens, FlatTokens),
    maplist(atom_string, WordList, FlatTokens).

% Divide cada palabra si tiene puntuación adjunta al inicio o final, y elimina tokens vacíos
split_punctuation(Word, Tokens) :-
    string_chars(Word, Chars),
    split_punct_helper(Chars, RawTokens),
    exclude(string_empty, RawTokens, Tokens).

% Helper: separa todos los signos de puntuación al inicio y final, y nunca agrega tokens vacíos
split_punct_helper([], []).
split_punct_helper([C|Rest], [Punct|Tokens]) :-
    is_punct(C),
    atom_string(C, Punct),
    split_punct_helper(Rest, Tokens).
split_punct_helper(Chars, [WordAtom|Tokens]) :-
    take_word(Chars, WordChars, Rest),
    WordChars \= [],
    string_chars(Word, WordChars),
    Word \= "", % nunca agregar token vacío
    WordAtom = Word,
    split_punct_helper(Rest, Tokens).

% Toma una secuencia de letras (no puntuación) del inicio de la lista
take_word([], [], []).
take_word([C|Rest], [], [C|Rest]) :- is_punct(C), !.
take_word([C|Rest], [C|Word], Resto) :- \+ is_punct(C), take_word(Rest, Word, Resto).

is_punct(C) :- member(C, ['.', ',', '?', '!', ';', ':', '¿', '¡', '"', '\'', '(', ')']).

string_empty(S) :- S = "" ; S = '' ; S = [] ; S = " ".

% Elimina tildes y acentos
remove_accents(Str, Clean) :-
    string_chars(Str, Chars),
    maplist(replace_accent, Chars, CleanChars),
    string_chars(Clean, CleanChars).

replace_accent('á','a').
replace_accent('é','e').
replace_accent('í','i').
replace_accent('ó','o').
replace_accent('ú','u').
replace_accent('ñ','n').
replace_accent('Á','a').
replace_accent('É','e').
replace_accent('Í','i').
replace_accent('Ó','o').
replace_accent('Ú','u').
replace_accent('Ñ','n').
replace_accent(C,C).