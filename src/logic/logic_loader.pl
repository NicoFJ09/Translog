% Cargar módulos de oraciones y traducción
:- consult('sentences/classifier.pl').
:- consult('sentences/structure.pl').
:- consult('sentences/translator.pl').
startLL :-
    write('================================='), nl,
    write('  This is logic loader     '), nl,
    write('  starting              '), nl,
    write('================================='), nl, nl.

% Auto-start when loaded
:- initialization(startLL).