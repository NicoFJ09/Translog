:- encoding(utf8).

% ===============================================
% TRANSLOG MAIN ENTRY POINT
% ===============================================

% Load all logic modules
:- consult('logic/logic_loader.pl').

% Load interface
:- consult('BNF/user_interface.pl').

% Load utilities
:- consult('utils/helpers.pl').

% Main program entry point
start :-
    write('==================================================='), nl,
    write('             ¡Bienvenido a TransLogCE!             '), nl,
    write('==================================================='), nl, nl,
    write('Seleccione modo de traducción:'), nl, nl,
    write('1. Español a Inglés'), nl,
    write('2. Inglés a Español'), nl, nl,
    read(Opcion),
    skip(10),
    procesar_opcion(Opcion).

% Procesamiento de Modo de Traduccion

procesar_opcion(1) :-
    Modo = ei,
    nl, write('>>>>>   TransLogCE Modo: Español - Inglés   <<<<<<'), nl,
    pedir_oracion(Modo).

procesar_opcion(2) :-
    Modo = ie,
    nl, write('>>>>>   TransLogCE Modo: Inglés - Español   <<<<<'), nl, 
    ask_for_sentence(Modo).

procesar_opcion(_) :-
    nl, write('Opción no válida. Inténtelo de nuevo.'), nl, nl,
    start. 

% ====================================
% PASAR LUEGO A INPUT HANDLER - TESTING IN MAIN
% ====================================

% --------------------------------------------------
% Convierte una cadena en una lista de palabras/tokens
% --------------------------------------------------
string_to_word_list(String, WordList) :-
    string_lower(String, LowerCase),
    remove_accents(LowerCase, NoAccents),
    split_string(NoAccents, " ", " \t\n", Parts),  % separa por espacios
    maplist(split_punctuation, Parts, NestedTokens),
    flatten(NestedTokens, FlatTokens),
    maplist(atom_string, WordList, FlatTokens).

% --------------------------------------------------
% Divide cada palabra si tiene puntuación adjunta
% Ej: "big." -> ["big", "."]
% --------------------------------------------------
split_punctuation(Word, Tokens) :-
    string_chars(Word, Chars),
    (   append(WordChars, [Last], Chars),
        member(Last, ['.', ',', '?', '!', ';', ':'])
    ->  string_chars(Stem, WordChars),
        Tokens = [Stem, Last]
    ;   Tokens = [Word]
    ).

% --------------------------------------------------
% Elimina tildes y acentos
% --------------------------------------------------
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

% Pedir oracion a traducir

pedir_oracion(ei) :-
    nl,
    write('Ingrese la frase que desea traducir:'), nl,
    flush_output,
    read_line_to_string(user_input, Oracion_string),
    string_lower(Oracion_string, String_minuscula),
    string_to_word_list(String_minuscula, Input),         % INPUT is to be iterated and classified
    write('Input: '), write(Input), nl, continuar(ei).

ask_for_sentence(ie) :-
    nl,
    write('Write what you wish to translate here:'), nl,
    flush_output,
    read_line_to_string(user_input, Sentence_string),
    string_lower(Sentence_string, String_lowercase),
    string_to_word_list(String_lowercase, Input),         % INPUT is to be iterated and classified
    write('Input: '), write(Input), nl, continuar(ie).

% Preguntar si se quiere seguir traduciendo

continuar(ei) :-
    nl,
    write('¿Desea traducir otra frase? (si/no)'), nl,
    flush_output,
    read_line_to_string(user_input, Respuesta),
    string_lower(Respuesta, ResMinusc),
    (
        member(ResMinusc, ["si", "yes", "y"])
        -> pedir_oracion(ei)
        ;  nl, write('Gracias por usar TransLogCE.'), nl, halt
    ).

continuar(ie) :-
    nl,
    write('Translate another sentence? (yes/no)'), nl,
    flush_output,
    read_line_to_string(user_input, Response),
    string_lower(Response, ResLowercase),
    (
        member(ResLowercase, ["si", "yes", "y"])
        -> ask_for_sentence(ie)
        ;  nl, write('Thank you for using TransLogCE.'), nl, halt
    ).

% Auto-start when loaded
:- initialization(start).