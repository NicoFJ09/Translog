:- encoding(utf8).
:- consult('../logic/traductor.pl').
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

bucle(LangOrigen, LangDestino) :-
    nl, write('Escribe la frase a traducir (o "salir" para terminar):'), nl,
    write('> '),
    read_line_to_string(user_input, InputStr),
    ( InputStr = "salir" ->
        start
    ; InputStr = "" ->
        bucle(LangOrigen, LangDestino)
    ;
        split_string(InputStr, " ", " ", TokensStr),
        maplist(atom_string, Tokens, TokensStr),
        traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion),
        atomic_list_concat(Traduccion, ' ', OracionFinal),
        write('Traducción: '), write(OracionFinal), nl,
        bucle(LangOrigen, LangDestino)
    ).