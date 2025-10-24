:- encoding(utf8).
:- consult('../logic/traductor.pl').
:- consult('../BNF/numeros.pl').
% ===============================================
% BNF.PL - Interfaz
% ===============================================

start :-
    write('==================================================='), nl,
    write('          TransLog - Traductor Simple              '), nl,
    write('==================================================='), nl, nl,
    write('1. Español → Inglés'), nl,
    write('2. Inglés → Español'), nl,
    write('3. Salir'), nl, nl,
    write('Opción: '),
    read_line_to_string(user_input, OpcionStr),
    normalize_space(string(OpcionTrim), OpcionStr),
    ( number_string(OpcionNum, OpcionTrim) ->
        procesar_opcion(OpcionNum)
    ;
        procesar_opcion(_)
    ).

procesar_opcion(1) :-
    nl, write('>>> Modo: Español → Inglés <<<'), nl,
    bucle(spanish, english).

procesar_opcion(2) :-
    nl, write('>>> Modo: Inglés → Español <<<'), nl,
    bucle(english, spanish).

procesar_opcion(3) :-
    nl, write('¡Adiós!'), nl, halt.

procesar_opcion(_) :-
    nl, write('Opción inválida'), nl, start.

% Pasar input a lista de strings
string_to_word_list(String, WordList) :-
    string_lower(String, LowerCase),
    remove_accents(LowerCase, NoAccents),
    split_string(NoAccents, " ", " \t\n", Parts),  % separa por espacios
    maplist(split_punctuation, Parts, NestedTokens),
    flatten(NestedTokens, FlatTokens),
    maplist(atom_string, WordList, FlatTokens).

% Separar puntuacion
split_punctuation(Word, Tokens) :-
    string_chars(Word, Chars),
    (   append(WordChars, [Last], Chars),
        member(Last, ['.', ',', '?', '!', ';', ':'])
    ->  string_chars(Stem, WordChars),
        Tokens = [Stem, Last]
    ;   Tokens = [Word]
    ).

% Eliminar tildes
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


bucle(LangOrigen, LangDestino) :-
    nl, write('Escribe la frase a traducir (o "salir" para terminar):'), nl,
    write('> '),
    read_line_to_string(user_input, InputStr),
    ( InputStr = "salir" ->
        start
    ; InputStr = "" ->
        bucle(LangOrigen, LangDestino)
    ;
        string_lower(InputStr, StringLower),
        string_to_word_list(StringLower, Input),
        preprocesar(LangOrigen, Input, Preprocesado),
        traducir_oracion(Preprocesado, LangOrigen, LangDestino, Traduccion),
        % Verificar si hay palabras no reconocidas
        ( tiene_palabras_no_reconocidas(Preprocesado, Traduccion) ->
            mostrar_error_palabra_desconocida(LangOrigen),
            bucle(LangOrigen, LangDestino)
        ;
            atomic_list_concat(Traduccion, ' ', OracionFinal),
            write('Traducción: '), write(OracionFinal), nl,
            bucle(LangOrigen, LangDestino)
        )
    ).

% Verificar si hay palabras no reconocidas (palabras que se quedaron iguales)
tiene_palabras_no_reconocidas([], []).
tiene_palabras_no_reconocidas([P|Resto1], [T|Resto2]) :-
    ( P = T ->
        % Si la palabra original es igual a la traducida, no se reconoce
        % EXCEPTO puntuación
        \+ member(P, ['.', ',', '?', '!', ';', ':'])
    ;
        tiene_palabras_no_reconocidas(Resto1, Resto2)
    ).
tiene_palabras_no_reconocidas([_|Resto1], [_|Resto2]) :-
    tiene_palabras_no_reconocidas(Resto1, Resto2).

% Mostrar mensaje de error según el idioma de origen
mostrar_error_palabra_desconocida(spanish) :-
    nl, write('Lo siento, no reconozco alguna palabra. ¿Puedes repetir eso de nuevo?'), nl.
mostrar_error_palabra_desconocida(english) :-
    nl, write('Sorry, I don\'t recognize some word. Can you repeat that again?'), nl.