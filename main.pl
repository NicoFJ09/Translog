:- encoding(utf8).

% ===============================================
% TRANSLOG - MAIN ENTRY POINT
% ===============================================

% Cargar módulos en orden
:- consult('DB.pl').
:- consult('logic/sintagmas.pl').
:- consult('logic/conjugador.pl').
:- consult('logic/traductor.pl').
:- consult('BNF/BNF.pl').