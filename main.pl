:- encoding(utf8).

% ===============================================
% TRANSLOG MAIN ENTRY POINT
% ===============================================


% Load all logic modules
:- consult('src/logic/logic_loader.pl').

% Load interface (ajusta la ruta si BNF está en otra carpeta)
% :- consult('src/BNF/user_interface.pl').

% Load utilities
:- consult('src/utils/helpers.pl').

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
    SourceLang = spanish,
    TargetLang = english,
    nl, write('>>>>>   TransLogCE Modo: Español - Inglés   <<<<<<'), nl,
    pedir_oracion(SourceLang, TargetLang).

procesar_opcion(2) :-
    SourceLang = english,
    TargetLang = spanish,
    nl, write('>>>>>   TransLogCE Modo: Inglés - Español   <<<<<'), nl,
    pedir_oracion(SourceLang, TargetLang).

procesar_opcion(_) :-
    nl, write('Opción no válida. Inténtelo de nuevo.'), nl, nl,
    start. 

% ====================================
% PASAR LUEGO A INPUT HANDLER - TESTING IN MAIN
% ====================================


% Importar utilidades de string
:- consult('src/utils/string_utils.pl').

% Pedir oracion a traducir


pedir_oracion(SourceLang, TargetLang) :-
    nl,
    (SourceLang = spanish -> write('Ingrese la frase que desea traducir:') ; write('Write what you wish to translate here:')), nl,
    flush_output,
    read_line_to_string(user_input, InputString),
    string_lower(InputString, StringLower),
    string_to_word_list(StringLower, Input),
    write('Input: '), write(Input), nl,
    classify(Input, Classification),
    (SourceLang = spanish -> write('Clasificación: ') ; write('Classification: ')), write(Classification), nl,
    translate(Classification, SourceLang, TargetLang, Output),
    (SourceLang = spanish -> write('Traducción: ') ; write('Translation: ')), write(Output), nl,
    continuar(SourceLang, TargetLang).

% Preguntar si se quiere seguir traduciendo


continuar(SourceLang, TargetLang) :-
    nl,
    (SourceLang = spanish -> write('¿Desea traducir otra frase? (si/no)') ; write('Translate another sentence? (yes/no)')), nl,
    flush_output,
    read_line_to_string(user_input, Resp),
    string_lower(Resp, RespLower),
    ( member(RespLower, ["si", "yes", "y"])
      -> pedir_oracion(SourceLang, TargetLang)
      ;  (SourceLang = spanish -> (nl, write('Gracias por usar TransLogCE.'), nl, halt)
         ; (nl, write('Thank you for using TransLogCE.'), nl, halt)
        )
    ).

% Auto-start when loaded
:- initialization(start).