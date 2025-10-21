:- encoding(utf8).

% ===============================================
% TRANSLOG - MAIN ENTRY POINT
% ===============================================

% Cargar módulos en orden
:- consult('src/database/DB.pl').
:- consult('src/logic/sintagmas.pl').
:- consult('src/logic/conjugador.pl').
:- consult('src/logic/traductor.pl').
:- consult('src/BNF/BNF.pl').