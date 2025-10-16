% ===============================================
% TRANSLOG MAIN ENTRY POINT
% ===============================================

% Load all logic modules
:- consult('src/logic/logic_loader.pl').

% Load interface
:- consult('src/interface/user_interface.pl').

% Load utilities
:- consult('src/utils/helpers.pl').

% Main program entry point
start :-
    write('================================='), nl,
    write('  TransLog - Spanish/English     '), nl,
    write('  Translation System              '), nl,
    write('================================='), nl, nl.

% Auto-start when loaded
:- initialization(start).