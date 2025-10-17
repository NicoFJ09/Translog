% ===============================================
% TEST COMPLETO DE TRADUCCIÓN
% ===============================================

:- consult('src/database/DB.pl').
:- consult('src/logic/sentences/classifier.pl').
:- consult('src/logic/sentences/structure.pl').
:- consult('src/logic/sentences/translator.pl').

% =============================================================================
% TESTS - ENGLISH TO SPANISH
% =============================================================================

test1 :-
    write('=== TEST 1: Simple Statement EN->ES ==='), nl,
    Input = [the, cat, is, big, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    write('Classified: '), write(Classification), nl,
    
    translate(Classification, english, spanish, Output),
    write('Output: '), write(Output), nl, nl.

test2 :-
    write('=== TEST 2: Adjective Reordering EN->ES ==='), nl,
    Input = [the, big, house, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, english, spanish, Output),
    write('Output: '), write(Output), nl, nl.

test3 :-
    write('=== TEST 3: WH-Question EN->ES ==='), nl,
    Input = [where, is, the, dog, '?'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, english, spanish, Output),
    write('Output: '), write(Output), nl, nl.

test4 :-
    write('=== TEST 4: Negative EN->ES ==='), nl,
    Input = [i, do, not, like, cats, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, english, spanish, Output),
    write('Output: '), write(Output), nl, nl.

test5 :-
    write('=== TEST 5: Common Phrase EN->ES ==='), nl,
    Input = [hello, '!'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, english, spanish, Output),
    write('Output: '), write(Output), nl, nl.

% =============================================================================
% TESTS - SPANISH TO ENGLISH
% =============================================================================

test6 :-
    write('=== TEST 6: Spanish to English ==='), nl,
    Input = [el, gato, grande, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    write('Classified: '), write(Classification), nl,
    
    translate(Classification, spanish, english, Output),
    write('Output: '), write(Output), nl, nl.

test7 :-
    write('=== TEST 7: Spanish Simple ES->EN ==='), nl,
    Input = [el, perro, es, grande, '.'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, spanish, english, Output),
    write('Output: '), write(Output), nl, nl.

test8 :-
    write('=== TEST 8: Spanish Question ES->EN ==='), nl,
    Input = ['¿', donde, esta, el, gato, '?'],
    write('Input: '), write(Input), nl,
    
    classify(Input, Classification),
    translate(Classification, spanish, english, Output),
    write('Output: '), write(Output), nl, nl.

% =============================================================================
% DETAILED TESTS
% =============================================================================

test_detailed :-
    write(''), nl,
    write('==================================='), nl,
    write('  DETAILED TEST EN->ES'), nl,
    write('==================================='), nl, nl,
    
    Input = [the, big, cat, '.'],
    write('INPUT: '), write(Input), nl, nl,
    
    write('>>> STEP 1: CLASSIFY <<<'), nl,
    classify(Input, Classification),
    write(Classification), nl, nl,
    
    write('>>> STEP 2: STRUCTURE <<<'), nl,
    structure(Classification, english, spanish, Structured),
    write(Structured), nl, nl,
    
    write('>>> STEP 3: TRANSLATE <<<'), nl,
    translate(Classification, english, spanish, Output),
    write(Output), nl, nl.

test_detailed_reverse :-
    write(''), nl,
    write('==================================='), nl,
    write('  DETAILED TEST ES->EN'), nl,
    write('==================================='), nl, nl,
    
    Input = [el, gato, grande, '.'],
    write('INPUT: '), write(Input), nl, nl,
    
    write('>>> STEP 1: CLASSIFY <<<'), nl,
    classify(Input, Classification),
    write(Classification), nl, nl,
    
    write('>>> STEP 2: STRUCTURE <<<'), nl,
    structure(Classification, spanish, english, Structured),
    write(Structured), nl, nl,
    
    write('>>> STEP 3: TRANSLATE <<<'), nl,
    translate(Classification, spanish, english, Output),
    write(Output), nl, nl.

% =============================================================================
% BATCH TEST
% =============================================================================

test_batch :-
    write(''), nl,
    write('==================================='), nl,
    write('  BATCH TRANSLATION TEST'), nl,
    write('==================================='), nl, nl,
    
    write('--- English to Spanish ---'), nl,
    classify([the, cat, '.'], C1),
    translate(C1, english, spanish, O1),
    write('1. [the, cat, .] -> '), write(O1), nl,
    
    classify([the, big, cat, '.'], C2),
    translate(C2, english, spanish, O2),
    write('2. [the, big, cat, .] -> '), write(O2), nl,
    
    classify([where, is, he, '?'], C3),
    translate(C3, english, spanish, O3),
    write('3. [where, is, he, ?] -> '), write(O3), nl,
    
    classify([hello, '!'], C4),
    translate(C4, english, spanish, O4),
    write('4. [hello, !] -> '), write(O4), nl, nl,
    
    write('--- Spanish to English ---'), nl,
    classify([el, gato, '.'], C5),
    translate(C5, spanish, english, O5),
    write('5. [el, gato, .] -> '), write(O5), nl,
    
    classify([el, gato, grande, '.'], C6),
    translate(C6, spanish, english, O6),
    write('6. [el, gato, grande, .] -> '), write(O6), nl,
    
    classify([la, casa, pequena, '.'], C7),
    translate(C7, spanish, english, O7),
    write('7. [la, casa, pequena, .] -> '), write(O7), nl,
    
    classify([hola, '!'], C8),
    translate(C8, spanish, english, O8),
    write('8. [hola, !] -> '), write(O8), nl, nl.

% =============================================================================
% RUN ALL
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
    test7,
    test8,
    write(''), nl,
    write('###############################'), nl,
    write('#   ALL TESTS COMPLETED       #'), nl,
    write('###############################'), nl.

% =============================================================================
% SHORTCUTS
% =============================================================================

t1 :- test1.
t2 :- test2.
t3 :- test3.
t4 :- test4.
t5 :- test5.
t6 :- test6.
t7 :- test7.
t8 :- test8.
td :- test_detailed.
tdr :- test_detailed_reverse.
tb :- test_batch.
t :- run_all.