:- encoding(utf8).
:- consult('../database/DB.pl').
% ===============================================
% TRADUCTOR.PL - Traducción unidireccional
% ===============================================

% =============================================================================
% TRADUCIR UNA PALABRA
% =============================================================================

% ESPAÑOL → INGLÉS: buscar en posición 2 → retornar posición 1
traducir_palabra(Palabra, spanish, english, Traduccion) :-
    pronoun(Traduccion, Palabra, _).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    article(Traduccion, Palabra, _, _).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    noun(Traduccion, Palabra, _, _).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    adjective(Traduccion, Palabra, _, _).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    verb_infinitive(Traduccion, Palabra, _).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    adverb(Traduccion, Palabra).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    preposition(Traduccion, Palabra).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    question_word(Traduccion, Palabra).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    negative(Traduccion, Palabra).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    common_phrase(Traduccion, Palabra).

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    conjunction(Traduccion, Palabra).

% INGLÉS → ESPAÑOL: buscar en posición 1 → retornar posición 2
traducir_palabra(Palabra, english, spanish, Traduccion) :-
    pronoun(Palabra, Traduccion, _).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    article(Palabra, Traduccion, _, _).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    noun(Palabra, Traduccion, _, _).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    adjective(Palabra, Traduccion, _, _).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    verb_infinitive(Palabra, Traduccion, _).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    adverb(Palabra, Traduccion).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    preposition(Palabra, Traduccion).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    question_word(Palabra, Traduccion).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    negative(Palabra, Traduccion).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    common_phrase(Palabra, Traduccion).

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    conjunction(Palabra, Traduccion).

% Si no hay traducción, dejar igual
traducir_palabra(Palabra, _, _, Palabra).

% =============================================================================
% TRADUCIR LISTA
% =============================================================================

traducir_lista([], _, _, []).

traducir_lista([Palabra|Resto], LangOrigen, LangDestino, [Traducida|RestoTraducido]) :-
    traducir_palabra(Palabra, LangOrigen, LangDestino, Traducida),
    traducir_lista(Resto, LangOrigen, LangDestino, RestoTraducido).

% =============================================================================
% CONCORDANCIA
% =============================================================================

% Ajustar artículo: article(English, Spanish, Gender, Number)
ajustar_articulo(ArticuloIngles, SustantivoEspanol, ArticuloEspanol) :-
    noun(_, SustantivoEspanol, Genero, Numero),
    article(ArticuloIngles, ArticuloEspanol, Genero, Numero).

% Ajustar adjetivo: adjective(English, Spanish, Gender, Number)
ajustar_adjetivo(AdjetivoIngles, SustantivoEspanol, AdjetivoEspanol) :-
    noun(_, SustantivoEspanol, Genero, Numero),
    adjective(AdjetivoIngles, AdjetivoEspanol, Genero, Numero).

% =============================================================================
% REORDENAMIENTO
% =============================================================================

reordenar_sn([Det, Adj, Noun], english, spanish, [Det, Noun, Adj]).
reordenar_sn([Det, Noun, Adj], spanish, english, [Det, Adj, Noun]).
reordenar_sn([Det, Noun], _, _, [Det, Noun]).
reordenar_sn([Pronombre], _, _, [Pronombre]).