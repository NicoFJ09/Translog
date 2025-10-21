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
% CONCORDANCIA Y VERIFICACIÓN
% =============================================================================

% Verificar concordancia género/número entre artículo, sustantivo y adjetivo
verificar_concordancia(Articulo, Sustantivo, Adjetivo) :-
    article(_, Articulo, GeneroArt, NumeroArt),
    noun(_, Sustantivo, GeneroSus, NumeroSus),
    adjective(_, Adjetivo, GeneroAdj, NumeroAdj),
    GeneroArt = GeneroSus,
    GeneroSus = GeneroAdj,
    NumeroArt = NumeroSus,
    NumeroSus = NumeroAdj.

% Verificar concordancia artículo-sustantivo
verificar_concordancia_art_sust(Articulo, Sustantivo) :-
    article(_, Articulo, GeneroArt, NumeroArt),
    noun(_, Sustantivo, GeneroSus, NumeroSus),
    GeneroArt = GeneroSus,
    NumeroArt = NumeroSus.

% Verificar concordancia sustantivo-adjetivo
verificar_concordancia_sust_adj(Sustantivo, Adjetivo) :-
    noun(_, Sustantivo, GeneroSus, NumeroSus),
    adjective(_, Adjetivo, GeneroAdj, NumeroAdj),
    GeneroSus = GeneroAdj,
    NumeroSus = NumeroAdj.

% =============================================================================
% SELECCIÓN DE ARTÍCULOS EN INGLÉS (a/an)
% =============================================================================

% Verificar si una palabra comienza con vocal (para a/an)
empieza_con_vocal(Palabra) :-
    atom_chars(Palabra, [PrimeraLetra|_]),
    char_type(PrimeraLetra, lower),
    member(PrimeraLetra, [a, e, i, o, u]).

empieza_con_vocal(Palabra) :-
    atom_chars(Palabra, [PrimeraLetra|_]),
    char_type(PrimeraLetra, upper),
    downcase_atom(PrimeraLetra, LetraMin),
    member(LetraMin, [a, e, i, o, u]).

% Seleccionar artículo indefinido correcto (a/an)
seleccionar_articulo_ingles(Sustantivo, singular, a) :-
    \+ empieza_con_vocal(Sustantivo).

seleccionar_articulo_ingles(Sustantivo, singular, an) :-
    empieza_con_vocal(Sustantivo).

seleccionar_articulo_ingles(_, plural, some).

% =============================================================================
% TRADUCCIÓN CONTEXTUAL DE ARTÍCULOS
% =============================================================================

% Traducir artículo inglés → español (usando género del sustantivo)
traducir_articulo_en_a_es(the, Sustantivo, ArticuloEspanol) :-
    noun(_, Sustantivo, Genero, Numero),
    article(the, ArticuloEspanol, Genero, Numero).

traducir_articulo_en_a_es(a, Sustantivo, ArticuloEspanol) :-
    noun(_, Sustantivo, Genero, singular),
    article(a, ArticuloEspanol, Genero, singular).

traducir_articulo_en_a_es(an, Sustantivo, ArticuloEspanol) :-
    noun(_, Sustantivo, Genero, singular),
    article(a, ArticuloEspanol, Genero, singular).

traducir_articulo_en_a_es(some, Sustantivo, ArticuloEspanol) :-
    noun(_, Sustantivo, Genero, plural),
    article(some, ArticuloEspanol, Genero, plural).

% Traducir artículo español → inglés
traducir_articulo_es_a_en(ArticuloEspanol, SustantivoIngles, ArticuloIngles) :-
    article(ArticuloIngles, ArticuloEspanol, Genero, Numero),
    noun(SustantivoIngles, _, Genero, Numero),
    % Si es indefinido singular, ajustar a/an
    ( (ArticuloIngles = a, Numero = singular) ->
        seleccionar_articulo_ingles(SustantivoIngles, singular, _)
    ; true
    ).

% =============================================================================
% AJUSTE DE GÉNERO Y NÚMERO
% =============================================================================

% Ajustar artículo: article(English, Spanish, Gender, Number)
ajustar_articulo(ArticuloIngles, SustantivoEspanol, ArticuloEspanol) :-
    noun(_, SustantivoEspanol, Genero, Numero),
    article(ArticuloIngles, ArticuloEspanol, Genero, Numero).

% Ajustar adjetivo español basado en sustantivo español
ajustar_adjetivo_genero(AdjetivoIngles, SustantivoEspanol, AdjetivoEspanol) :-
    noun(_, SustantivoEspanol, Genero, Numero),
    adjective(AdjetivoIngles, AdjetivoEspanol, Genero, Numero).

% Ajustar adjetivo inglés basado en sustantivo inglés (no cambia forma)
ajustar_adjetivo_genero_ingles(AdjetivoIngles, _, AdjetivoIngles).

% =============================================================================
% REORDENAMIENTO DE SINTAGMAS NOMINALES
% =============================================================================

% --- Reordenar español → inglés ---

% Con adjetivo: [art, sust, adj] → [art, adj, sust]
reordenar_sintagma_nominal_es_a_en([Articulo, Sustantivo, Adjetivo], [ArticuloEn, AdjetivoEn, SustantivoEn]) :-
    article(ArticuloEn, Articulo, Genero, Numero),
    noun(SustantivoEn, Sustantivo, Genero, Numero),
    adjective(AdjetivoEn, Adjetivo, Genero, Numero),
    % Ajustar a/an si es necesario
    ( (ArticuloEn = a, Numero = singular) ->
        seleccionar_articulo_ingles(SustantivoEn, singular, ArticuloFinal),
        ArticuloEn = ArticuloFinal
    ; true
    ).

% Sin adjetivo: [art, sust] → [art, sust]
reordenar_sintagma_nominal_es_a_en([Articulo, Sustantivo], [ArticuloEn, SustantivoEn]) :-
    article(ArticuloEn, Articulo, Genero, Numero),
    noun(SustantivoEn, Sustantivo, Genero, Numero).

% Una sola palabra
reordenar_sintagma_nominal_es_a_en([Palabra], [Traduccion]) :-
    traducir_palabra(Palabra, spanish, english, Traduccion).

% --- Reordenar inglés → español ---

% Con adjetivo: [art, adj, sust] → [art, sust, adj]
reordenar_sintagma_nominal_en_a_es([Articulo, Adjetivo, Sustantivo], [ArticuloEs, SustantivoEs, AdjetivoEs]) :-
    noun(Sustantivo, SustantivoEs, Genero, Numero),
    article(Articulo, ArticuloEs, Genero, Numero),
    adjective(Adjetivo, AdjetivoEs, Genero, Numero).

% Sin adjetivo: [art, sust] → [art, sust]
reordenar_sintagma_nominal_en_a_es([Articulo, Sustantivo], [ArticuloEs, SustantivoEs]) :-
    noun(Sustantivo, SustantivoEs, Genero, Numero),
    article(Articulo, ArticuloEs, Genero, Numero).

% Una sola palabra
reordenar_sintagma_nominal_en_a_es([Palabra], [Traduccion]) :-
    traducir_palabra(Palabra, english, spanish, Traduccion).

% =============================================================================
% HELPERS PARA REORDENAMIENTO (compatibilidad con código existente)
% =============================================================================

reordenar_sn([Det, Adj, Noun], english, spanish, [Det, Noun, Adj]).
reordenar_sn([Det, Noun, Adj], spanish, english, [Det, Adj, Noun]).
reordenar_sn([Det, Noun], _, _, [Det, Noun]).
reordenar_sn([Pronombre], _, _, [Pronombre]).