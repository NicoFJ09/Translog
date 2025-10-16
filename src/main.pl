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

% Pedir oracion a traducir

pedir_oracion(ei) :-
    nl,
    write('Ingrese la frase que desea traducir:'), nl,
    flush_output,
    read_line_to_string(user_input, Oracion_string),
    string_lower(Oracion_string, String_minuscula),
    (
        member(String_minuscula, ["yes", "ok", "y", "ja", "oui"])   % aqui llamar revision de estructura de oracion
        -> format(">> Inserte aqui traduccion.~n"), continuar(ei)
        ;  nl, write('Ha ocurrido un error, por favor pruebe insertar una diferente estructura para la frase que desea traducir.'), 
           nl, continuar(ei)
    ).

ask_for_sentence(ie) :-
    nl,
    write('Write what you wish to translate here:'), nl,
    flush_output,
    read_line_to_string(user_input, Sentence_string),
    string_lower(Sentence_string, String_lowercase),
    (
        member(String_lowercase, ["yes", "ok", "y", "ja", "oui"]) % Aqui llamar revision de estructura de oracion
        -> format(">> Translation goes here~n"), continuar(ie)
        ;  nl, write('Something has gone wrong while processing your sentence, please try again with different wording.'), 
           nl, continuar(ie)
    ).

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