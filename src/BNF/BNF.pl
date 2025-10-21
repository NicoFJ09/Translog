:- encoding(utf8).

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
    read(Opcion),
    procesar_opcion(Opcion).

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
    nl, write('Oración (lista de átomos, o salir):'), nl,
    write('> '),
    read(Input),
    (Input = salir ->
        start
    ;
        traducir_lista(Input, LangOrigen, LangDestino, Traduccion),
        write('Traducción: '), write(Traduccion), nl,
        bucle(LangOrigen, LangDestino)
    ).