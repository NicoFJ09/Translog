% Test para verificar que todo se carga correctamente

:- consult('src/database/DB.pl').
:- consult('src/logic/sentences/classifier.pl').
:- consult('src/logic/sentences/structure.pl').
:- consult('src/logic/sentences/translator.pl').

test_loading :-
    write('Testing if predicates are loaded...'), nl,
    
    % Test 1: classify/2 existe
    (current_predicate(classify/2) ->
        write('✓ classify/2 loaded'), nl
    ;
        write('✗ classify/2 NOT loaded'), nl
    ),
    
    % Test 2: structure/3 existe
    (current_predicate(structure/3) ->
        write('✓ structure/3 loaded'), nl
    ;
        write('✗ structure/3 NOT loaded'), nl
    ),
    
    % Test 3: translate/3 existe
    (current_predicate(translate/3) ->
        write('✓ translate/3 loaded'), nl
    ;
        write('✗ translate/3 NOT loaded'), nl
    ).

:- initialization(test_loading).