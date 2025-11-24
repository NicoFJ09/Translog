:- encoding(utf8).
:- consult('../BNF/numeros.pl').
:- consult('../logic/traductor.pl').
:- consult('../logic/text_utils.pl').

% ===============================================
% BNF.PL - Interfaz de Usuario
% ===============================================
% Dependencies loaded in order: numeros.pl -> traductor.pl -> text_utils.pl

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
    bucle(spanish, english, []).

procesar_opcion(2) :-
    nl, write('>>> Modo: Inglés → Español <<<'), nl,
    bucle(english, spanish, []).

procesar_opcion(3) :-
    nl, write('¡Adiós!'), nl, halt.

procesar_opcion(_) :-
    nl, write('Opción inválida'), nl, start.

bucle(LangOrigen, LangDestino, UltimaTraduccion) :-
    nl, write('Escribe la frase a traducir (o "salir" para terminar):'), nl,
    write('> '),
    read_line_to_string(user_input, InputStr),
    procesar_input(InputStr, LangOrigen, LangDestino, UltimaTraduccion).

procesar_input("salir", _, _, _) :- 
    start.

procesar_input("", LangOrigen, LangDestino, Ultima) :- 
    bucle(LangOrigen, LangDestino, Ultima).

procesar_input(Input, spanish, LangDestino, Ultima) :-
    member(Input, ["repetir", "repite", "de nuevo", "otra vez"]),
    Ultima \= [],
    !,
    mostrar_traduccion(Ultima),
    bucle(spanish, LangDestino, Ultima).

procesar_input(Input, english, LangDestino, Ultima) :-
    member(Input, ["repeat", "again", "one more time"]),
    Ultima \= [],
    !,
    mostrar_traduccion(Ultima),
    bucle(english, LangDestino, Ultima).

procesar_input(InputStr, LangOrigen, LangDestino, _) :-
    procesar_input_completo(InputStr, LangOrigen, LangDestino, Traduccion),
    mostrar_traduccion(Traduccion),
    bucle(LangOrigen, LangDestino, Traduccion).

mostrar_traduccion(Traduccion) :-
    atomic_list_concat(Traduccion, ' ', OracionFinal),
    write('Traducción: '), write(OracionFinal), nl.