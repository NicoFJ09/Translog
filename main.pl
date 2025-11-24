:- encoding(utf8).

% ===============================================
% TRANSLOG - MAIN ENTRY POINT
% ===============================================

% Cargar en orden
:- consult('src/database/DB.pl').
:- consult('src/logic/sintagmas.pl').
:- consult('src/logic/conjugador.pl').
:- consult('src/logic/traductor.pl').
:- consult('src/BNF/numeros.pl').
:- consult('src/logic/text_utils.pl').
:- consult('src/BNF/BNF.pl').

% Iniciar automáticamente
:- initialization(start).