% ===============================================
% TEST COMPLETO DE TRADUCCIÓN
% ===============================================

:- consult('src/database/DB.pl').
:- consult('src/logic/sentences/classifier.pl').
:- consult('src/logic/sentences/structure.pl').
:- consult('src/logic/sentences/translator.pl').

% =============================================================================
% TEST SIMPLE - TRADUCCIÓN BÁSICA
% =============================================================================

test1 :-
    write('=== TEST 1: Simple Statement EN->ES ==='), nl,
    Input = [the, cat, is, big, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    write('Classified: '), write(Classification), nl,
    
    translate(Classification, spanish, Output),
    write('Output: '), write(Output), nl, nl.


test2 :-
    write('=== TEST 2: Adjective Reordering ==='), nl,
    Input = [the, big, house, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, spanish, Output),
    write('Output: '), write(Output), nl, nl.


test3 :-
    write('=== TEST 3: WH-Question ==='), nl,
    Input = [where, is, the, dog, '?'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, spanish, Output),
    write('Output: '), write(Output), nl, nl.


test4 :-
    write('=== TEST 4: Negative ==='), nl,
    Input = [i, do, not, like, cats, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, spanish, Output),
    write('Output: '), write(Output), nl, nl.


test5 :-
    write('=== TEST 5: Common Phrase ==='), nl,
    Input = [hello, '!'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, spanish, Output),
    write('Output: '), write(Output), nl, nl.


test6 :-
    write('=== TEST 6: Spanish to English ==='), nl,
    Input = [el, gato, grande, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, english, Output),
    write('Output: '), write(Output), nl, nl.


% =============================================================================
% TEST DETALLADO - VER PASO A PASO
% =============================================================================

test_detailed :-
    write(''), nl,
    write('==================================='), nl,
    write('  DETAILED TEST - STEP BY STEP'), nl,
    write('==================================='), nl, nl,
    
    Input = [the, big, cat, '.'],
    write('INPUT: '), write(Input), nl, nl,
    
    write('>>> STEP 1: CLASSIFY <<<'), nl,
    classify(Input, Classification),
    write(Classification), nl, nl,
    
    write('>>> STEP 2: STRUCTURE <<<'), nl,
    structure(Classification, spanish, Structured),
    write(Structured), nl, nl,
    
    write('>>> STEP 3: TRANSLATE <<<'), nl,
    translate(Classification, spanish, Output),
    write(Output), nl, nl.


% =============================================================================
% TEST RÁPIDO - MÚLTIPLES ORACIONES
% =============================================================================

test_batch :-
    write(''), nl,
    write('==================================='), nl,
    write('  BATCH TRANSLATION TEST'), nl,
    write('==================================='), nl, nl,
    
    % 1
    classify([the, cat, '.'], C1),
    translate(C1, spanish, O1),
    write('1. [the, cat, .] -> '), write(O1), nl,
    
    % 2
    classify([the, big, cat, '.'], C2),
    translate(C2, spanish, O2),
    write('2. [the, big, cat, .] -> '), write(O2), nl,
    
    % 3
    classify([where, is, he, '?'], C3),
    translate(C3, spanish, O3),
    write('3. [where, is, he, ?] -> '), write(O3), nl,
    
    % 4
    classify([i, like, dogs, '.'], C4),
    translate(C4, spanish, O4),
    write('4. [i, like, dogs, .] -> '), write(O4), nl,
    
    % 5
    classify([hello, '!'], C5),
    translate(C5, spanish, O5),
    write('5. [hello, !] -> '), write(O5), nl, nl.


% =============================================================================
% EJECUTAR TODOS
% =============================================================================

run_all :-
    write(''), nl,
    write('###############################'), nl,
    write('#   TRANSLOG TESTS            #'), nl,
    write('###############################'), nl, nl,
    
    test1,
    test2,
    test3,
    test4,
    test5,
    test6,
    write(''), nl,
    write('###############################'), nl,
    write('#   ALL TESTS COMPLETED       #'), nl,
    write('###############################'), nl.


% Shortcuts
t1 :- test1.
t2 :- test2.
t3 :- test3.
t4 :- test4.
t5 :- test5.
t6 :- test6.
td :- test_detailed.
tb :- test_batch.
t :- run_all.