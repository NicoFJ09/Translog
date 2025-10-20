% ===============================================
% TEST SUITE: ARTICLES & ADJECTIVES MODULE
% ===============================================
% Persona 2: David
% Fecha: 17 de Octubre 2025
%
% PROPÓSITO:
% Validar el funcionamiento del modulo de artículos y adjetivos
% Prueba concordancia, traducciones y reordenamientos
% ===============================================

:- consult('src/database/DB.pl').
:- consult('src/logic/articles_adjectives.pl').

% =============================================================================
% UTILIDADES DE PRUEBA
% =============================================================================

% Contador de pruebas
:- dynamic(test_count/1).
:- dynamic(test_passed/1).
:- dynamic(test_failed/1).

inicializar_contadores :-
    retractall(test_count(_)),
    retractall(test_passed(_)),
    retractall(test_failed(_)),
    assert(test_count(0)),
    assert(test_passed(0)),
    assert(test_failed(0)).

incrementar_contador :-
    retract(test_count(N)),
    N1 is N + 1,
    assert(test_count(N1)).

incrementar_pasados :-
    retract(test_passed(N)),
    N1 is N + 1,
    assert(test_passed(N1)).

incrementar_fallados :-
    retract(test_failed(N)),
    N1 is N + 1,
    assert(test_failed(N1)).

% test(+Nombre, +Goal)
% Ejecuta una prueba y reporta el resultado
test(Nombre, Goal) :-
    incrementar_contador,
    write('  TEST: '), write(Nombre), write(' ... '),
    ( call(Goal) ->
        write('✓ PASSED'), nl,
        incrementar_pasados
    ;
        write('✗ FAILED'), nl,
        incrementar_fallados
    ).

mostrar_resultados :-
    nl,
    write('======================'), nl,
    write('  RESUMEN DE PRUEBAS'), nl,
    write('======================'), nl,
    test_count(Total),
    test_passed(Pasadas),
    test_failed(Falladas),
    write('Total:    '), write(Total), nl,
    write('Pasadas:  '), write(Pasadas), nl,
    write('Falladas: '), write(Falladas), nl,
    ( Falladas = 0 ->
        write('¡TODAS LAS PRUEBAS PASARON! ✓'), nl
    ;
        write('Hay pruebas fallidas. Revisar.'), nl
    ),
    write('======================'), nl.


% =============================================================================
% SUITE 1: CONCORDANCIA BÁSICA
% =============================================================================

test_suite_concordancia :-
    nl,
    write('========================================'), nl,
    write('  SUITE 1: CONCORDANCIA DE GÉNERO/NÚMERO'), nl,
    write('========================================'), nl, nl,
    
    % Pruebas positivas (deben pasar)
    test('Concordancia: el gato pequeño (masc. sing.)',
         verificar_concordancia(el, gato, pequeno)),
    
    test('Concordancia: la casa grande (fem. sing.)',
         verificar_concordancia(la, casa, grande)),
    
    test('Concordancia: los gatos pequeños (masc. plur.)',
         verificar_concordancia(los, gatos, pequenos)),
    
    test('Concordancia: las casas grandes (fem. plur.)',
         verificar_concordancia(las, casas, grandes)),
    
    % Pruebas con adjetivos invariables
    test('Concordancia con invariable: el gato grande',
         verificar_concordancia(el, gato, grande)),
    
    test('Concordancia con invariable: la casa feliz',
         verificar_concordancia(la, casa, feliz)),
    
    % Concordancia simple (sin adjetivo)
    test('Concordancia simple: el gato',
         verificar_concordancia_simple(el, gato)),
    
    test('Concordancia simple: la casa',
         verificar_concordancia_simple(la, casa)),
    
    % Pruebas negativas (deben fallar)
    test('Debe fallar: la gato (género incorrecto)',
         \+ verificar_concordancia_simple(la, gato)),
    
    test('Debe fallar: el casa (género incorrecto)',
         \+ verificar_concordancia_simple(el, casa)).


% =============================================================================
% SUITE 2: SELECCIÓN DE ARTÍCULOS
% =============================================================================

test_suite_seleccion :-
    nl,
    write('========================================'), nl,
    write('  SUITE 2: SELECCIÓN DE ARTÍCULOS'), nl,
    write('========================================'), nl, nl,
    
    % Artículos españoles definidos
    test('Seleccionar artículo español: gato → el',
         seleccionar_articulo_espanol(gato, definido, el)),
    
    test('Seleccionar artículo español: casa → la',
         seleccionar_articulo_espanol(casa, definido, la)),
    
    % Artículos españoles indefinidos
    test('Seleccionar artículo español: gato → un',
         seleccionar_articulo_espanol(gato, indefinido, un)),
    
    test('Seleccionar artículo español: casa → una',
         seleccionar_articulo_espanol(casa, indefinido, una)),
    
    % Artículos ingleses (a/an)
    test('Seleccionar a/an: apple → an',
         seleccionar_articulo_ingles(apple, indefinido, an)),
    
    test('Seleccionar a/an: cat → a',
         seleccionar_articulo_ingles(cat, indefinido, a)),
    
    test('Seleccionar a/an: orange → an',
         seleccionar_articulo_ingles(orange, indefinido, an)),
    
    test('Seleccionar a/an: dog → a',
         seleccionar_articulo_ingles(dog, indefinido, a)),
    
    % Artículo definido siempre es "the"
    test('Seleccionar artículo inglés: the',
         seleccionar_articulo_ingles(cat, definido, the)).


% =============================================================================
% SUITE 3: TRADUCCIÓN DE ARTÍCULOS CON CONTEXTO
% =============================================================================

test_suite_traduccion_articulos :-
    nl,
    write('========================================'), nl,
    write('  SUITE 3: TRADUCCIÓN DE ARTÍCULOS'), nl,
    write('========================================'), nl, nl,
    
    % Inglés → Español (the necesita contexto)
    test('Traducir: the + gato → el',
         traducir_articulo_en_a_es(the, gato, el)),
    
    test('Traducir: the + casa → la',
         traducir_articulo_en_a_es(the, casa, la)),
    
    test('Traducir: a + gato → un',
         traducir_articulo_en_a_es(a, gato, un)),
    
    test('Traducir: a + casa → una',
         traducir_articulo_en_a_es(a, casa, una)),
    
    % Español → Inglés (mas directo)
    test('Traducir: el → the',
         traducir_articulo_es_a_en(el, cat, the)),
    
    test('Traducir: la → the',
         traducir_articulo_es_a_en(la, house, the)),
    
    test('Traducir: un → a/an (según palabra)',
         traducir_articulo_es_a_en(un, cat, a)).


% =============================================================================
% SUITE 4: AJUSTE DE ADJETIVOS POR GÉNERO
% =============================================================================

test_suite_ajuste_adjetivos :-
    nl,
    write('========================================'), nl,
    write('  SUITE 4: AJUSTE DE ADJETIVOS'), nl,
    write('========================================'), nl, nl,
    
    % Ajustar adjetivos al género del sustantivo
    test('Ajustar: small + gato → pequeño',
         ajustar_adjetivo_genero(small, gato, pequeno)),
    
    test('Ajustar: small + casa → pequeña',
         ajustar_adjetivo_genero(small, casa, pequena)),
    
    test('Ajustar: beautiful + gato → hermoso',
         ajustar_adjetivo_genero(beautiful, gato, hermoso)),
    
    test('Ajustar: beautiful + casa → hermosa',
         ajustar_adjetivo_genero(beautiful, casa, hermosa)),
    
    % Adjetivos invariables no cambian
    test('Invariable: big + gato → grande',
         ajustar_adjetivo_genero(big, gato, grande)),
    
    test('Invariable: big + casa → grande',
         ajustar_adjetivo_genero(big, casa, grande)),
    
    % Plurales
    test('Ajustar plural: small + gatos → pequeños',
         ajustar_adjetivo_genero(small, gatos, pequenos)),
    
    test('Ajustar plural: small + casas → pequeñas',
         ajustar_adjetivo_genero(small, casas, pequenas)).


% =============================================================================
% SUITE 5: REORDENAMIENTO DE SINTAGMAS NOMINALES
% =============================================================================

test_suite_reordenamiento :-
    nl,
    write('========================================'), nl,
    write('  SUITE 5: REORDENAMIENTO DE SINTAGMAS'), nl,
    write('========================================'), nl, nl,
    
    % Español → Inglés (Art-Sust-Adj → Art-Adj-Sust)
    test('Reordenar ES→EN: [el, gato, pequeño] → [the, small, cat]',
         reordenar_sintagma_nominal_es_a_en([el, gato, pequeno], [the, small, cat])),
    
    test('Reordenar ES→EN: [la, casa, grande] → [the, big, house]',
         reordenar_sintagma_nominal_es_a_en([la, casa, grande], [the, big, house])),
    
    test('Reordenar ES→EN: [un, perro, bonito] → [a, pretty, dog]',
         reordenar_sintagma_nominal_es_a_en([un, perro, bonito], [a, pretty, dog])),
    
    % Sin adjetivo
    test('Reordenar ES→EN sin adj: [el, gato] → [the, cat]',
         reordenar_sintagma_nominal_es_a_en([el, gato], [the, cat])),
    
    % Inglés → Español (Art-Adj-Sust → Art-Sust-Adj)
    test('Reordenar EN→ES: [the, small, cat] → [el, gato, pequeño]',
         reordenar_sintagma_nominal_en_a_es([the, small, cat], [el, gato, pequeno])),
    
    test('Reordenar EN→ES: [the, big, house] → [la, casa, grande]',
         reordenar_sintagma_nominal_en_a_es([the, big, house], [la, casa, grande])),
    
    test('Reordenar EN→ES: [a, beautiful, house] → [una, casa, hermosa]',
         reordenar_sintagma_nominal_en_a_es([a, beautiful, house], [una, casa, hermosa])),
    
    % Sin adjetivo
    test('Reordenar EN→ES sin adj: [the, cat] → [el, gato]',
         reordenar_sintagma_nominal_en_a_es([the, cat], [el, gato])),
    
    % Casos con a/an
    test('Reordenar EN→ES: [an, apple] → [una, manzana]',
         reordenar_sintagma_nominal_en_a_es([an, apple], [una, manzana])).


% =============================================================================
% SUITE 6: CASOS COMPLEJOS
% =============================================================================

test_suite_casos_complejos :-
    nl,
    write('========================================'), nl,
    write('  SUITE 6: CASOS COMPLEJOS'), nl,
    write('========================================'), nl, nl,
    
    % Múltiples traducciones del mismo adjetivo
    test('Adjetivo con múltiples géneros: pequeño (masc)',
         adjective(small, pequeno, masculine, singular)),
    
    test('Adjetivo con múltiples géneros: pequeña (fem)',
         adjective(small, pequena, feminine, singular)),
    
    % Verificar que empieza_con_vocal funciona
    test('Vocal detection: apple empieza con vocal',
         empieza_con_vocal(apple)),
    
    test('Vocal detection: cat NO empieza con vocal',
         \+ empieza_con_vocal(cat)),
    
    % Obtener género de sustantivos
    test('Obtener género: gato es masculino singular',
         obtener_genero_sustantivo(gato, masculine, singular)),
    
    test('Obtener género: casa es femenino singular',
         obtener_genero_sustantivo(casa, feminine, singular)),
    
    % Verificar que adjetivos invariables son detectados
    test('Detectar invariable: grande es invariable',
         es_adjetivo_invariable(grande)),
    
    test('Detectar NO invariable: pequeño NO es invariable',
         \+ es_adjetivo_invariable(pequeno)).


% =============================================================================
% EJECUTAR TODAS LAS SUITES
% =============================================================================

run_all_tests :-
    inicializar_contadores,
    
    write(''), nl,
    write('################################################'), nl,
    write('#                                              #'), nl,
    write('#   TRANSLOG - TEST SUITE                     #'), nl,
    write('#   Artículos y Adjetivos                     #'), nl,
    write('#   Persona 2: David                          #'), nl,
    write('#                                              #'), nl,
    write('################################################'), nl,
    
    test_suite_concordancia,
    test_suite_seleccion,
    test_suite_traduccion_articulos,
    test_suite_ajuste_adjetivos,
    test_suite_reordenamiento,
    test_suite_casos_complejos,
    
    mostrar_resultados,
    
    nl,
    write('################################################'), nl,
    write('#   FIN DE PRUEBAS                            #'), nl,
    write('################################################'), nl, nl.


% =============================================================================
% PRUEBAS INDIVIDUALES RÁPIDAS
% =============================================================================

% Ejecutar una suite específica
t1 :- inicializar_contadores, test_suite_concordancia, mostrar_resultados.
t2 :- inicializar_contadores, test_suite_seleccion, mostrar_resultados.
t3 :- inicializar_contadores, test_suite_traduccion_articulos, mostrar_resultados.
t4 :- inicializar_contadores, test_suite_ajuste_adjetivos, mostrar_resultados.
t5 :- inicializar_contadores, test_suite_reordenamiento, mostrar_resultados.
t6 :- inicializar_contadores, test_suite_casos_complejos, mostrar_resultados.

% Ejecutar todo
t :- run_all_tests.


% =============================================================================
% PRUEBAS INTERACTIVAS PARA DEBUGGING
% =============================================================================

% probar_concordancia(+Art, +Sust, +Adj)
% Prueba interactiva para verificar concordancia
probar_concordancia(Art, Sust, Adj) :-
    write('Verificando: '), write(Art), write(' '), write(Sust), write(' '), write(Adj), nl,
    ( verificar_concordancia(Art, Sust, Adj) ->
        write('✓ Concordancia correcta'), nl
    ;
        write('✗ Concordancia incorrecta'), nl,
        write('  Razón: '),
        ( \+ article(_, Art, _, _) -> write('Artículo no existe'), nl
        ; \+ noun(Sust, _, _, _) -> write('Sustantivo no existe'), nl
        ; \+ (adjective(Adj, _, _, _) ; adjective(Adj, _)) -> write('Adjetivo no existe'), nl
        ; write('Género/número no coinciden'), nl
        )
    ).

% probar_traduccion(+ListaES)
% Traduce un sintagma nominal de español a inglés
probar_traduccion(ListaES) :-
    write('Entrada (ES): '), write(ListaES), nl,
    ( reordenar_sintagma_nominal_es_a_en(ListaES, ListaEN) ->
        write('Salida (EN):  '), write(ListaEN), nl
    ;
        write('✗ Error en traducción'), nl
    ).

% probar_traduccion_inversa(+ListaEN)
% Traduce un sintagma nominal de inglés a español
probar_traduccion_inversa(ListaEN) :-
    write('Entrada (EN): '), write(ListaEN), nl,
    ( reordenar_sintagma_nominal_en_a_es(ListaEN, ListaES) ->
        write('Salida (ES):  '), write(ListaES), nl
    ;
        write('✗ Error en traducción'), nl
    ).
