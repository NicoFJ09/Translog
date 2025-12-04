:- encoding(utf8).
:- consult('../BNF/numeros.pl').
:- consult('../logic/traductor.pl').
:- consult('../logic/text_utils.pl').

% ===============================================
% BNF.PL - Interfaz de Usuario
% ===============================================
% Dependencies loaded in order: numeros.pl -> traductor.pl -> text_utils.pl

/*
 * start/0
 * 
 * Summary: Punto de entrada principal del programa.
 * Muestra el menú inicial con opciones de traducción y comienza el bucle de interacción.
 * 
 * @return - Inicia el programa interactivo
 * 
 * Ejemplos:
 *   ?- start.
 *   ===================================================
 *           TransLog - Traductor Simple
 *   ===================================================
 *   
 *   1. Español → Inglés
 *   2. Inglés → Español
 *   3. Salir
 */
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

/*
 * procesar_opcion(+Opcion)
 * 
 * Summary: Procesa la opción seleccionada del menú principal.
 * Opción 1: Inicia modo Español→Inglés
 * Opción 2: Inicia modo Inglés→Español
 * Opción 3: Salir
 * Otro: Opción inválida, volver a menú
 * 
 * @param Opcion - Número de opción (1, 2, 3)
 * 
 * Ejemplos:
 *   ?- procesar_opcion(1).
 *   >>> Modo: Español → Inglés <<<
 */
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

/*
 * bucle(+LangOrigen, +LangDestino, +UltimaTraduccion)
 * 
 * Summary: Bucle principal de traducción. Solicita entrada del usuario y procesa comandos.
 * Mantiene historial de última traducción para comando "repetir".
 * 
 * @param LangOrigen          - Idioma de origen (spanish, english)
 * @param LangDestino         - Idioma destino (spanish, english)
 * @param UltimaTraduccion    - Última traducción realizada (para "repetir")
 * 
 * Comandos especiales:
 *   - "salir"     → Volver a menú principal
 *   - "repetir"   → Mostrar última traducción
 *   - "" (vacío)  → Continuar sin hacer nada
 */
bucle(LangOrigen, LangDestino, UltimaTraduccion) :-
    nl, write('Escribe la frase a traducir (o "salir" para terminar):'), nl,
    write('> '),
    read_line_to_string(user_input, InputStr),
    procesar_input(InputStr, LangOrigen, LangDestino, UltimaTraduccion).

/*
 * procesar_input(+InputStr, +LangOrigen, +LangDestino, +UltimaTraduccion)
 * 
 * Summary: Procesa la entrada del usuario.
 * Detecta comandos especiales ("salir", "repetir", "") o traduce la frase.
 * 
 * @param InputStr            - String de entrada del usuario
 * @param LangOrigen          - Idioma origen
 * @param LangDestino         - Idioma destino
 * @param UltimaTraduccion    - Última traducción realizada
 * 
 * Ejemplos:
 *   ?- procesar_input("hello", english, spanish, []).
 *   (Traduce "hello")
 */
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

/*
 * mostrar_traduccion(+Traduccion)
 * 
 * Summary: Formatea y muestra la traducción en pantalla.
 * Convierte lista de palabras a string con espacios.
 * 
 * @param Traduccion - Lista de palabras traducidas [the, cat, eats, fish]
 * 
 * Ejemplos:
 *   ?- mostrar_traduccion([the, cat, eats]).
 *   Traducción: the cat eats
 */
mostrar_traduccion(Traduccion) :-
    % Extract unknown words and clean them from output
    findall(PalabraDesconocida, 
            (member(Palabra, Traduccion), 
             atom_concat('__UNKNOWN__', PalabraDesconocida, Palabra)), 
            PalabrasDesconocidas),
    % Clean the translation by removing __UNKNOWN__ markers
    findall(PalabraLimpia,
            (member(Palabra, Traduccion),
             (atom_concat('__UNKNOWN__', P, Palabra) -> PalabraLimpia = P ; PalabraLimpia = Palabra)),
            TraduccionLimpia),
    atomic_list_concat(TraduccionLimpia, ' ', OracionFinal),
    write('Traducción: '), write(OracionFinal), nl,
    % Show warning if there were unknown words
    (PalabrasDesconocidas \= [] ->
        write('⚠️  Palabras no reconocidas: '),
        atomic_list_concat(PalabrasDesconocidas, ', ', ListaPalabras),
        write(ListaPalabras), nl
    ;
        true
    ).