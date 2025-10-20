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
:- consult('src/BNF/user_interface.pl').

% Auto-start when loaded
:- initialization(start).