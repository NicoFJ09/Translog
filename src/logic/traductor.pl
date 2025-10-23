:- encoding(utf8).
:- consult('../database/DB.pl').
:- consult('./conjugador.pl').

% =============================================================================
% TRADUCIR UNA PALABRA
% =============================================================================

% ESPAÑOL → INGLÉS: buscar en posición 2 → retornar posición 1
% IMPORTANTE: Artículo ANTES de pronombre para evitar "el" artículo → "he" 
traducir_palabra(Palabra, spanish, english, Traduccion) :-
    article(Traduccion, Palabra, _, _), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    pronoun(Traduccion, Palabra, _), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    noun(Traduccion, Palabra, _, _), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    adjective(Traduccion, Palabra, _, _), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    traducir_verbo(Palabra, spanish, english, Traduccion), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    adverb(Traduccion, Palabra), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    preposition(Traduccion, Palabra), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    question_word(Traduccion, Palabra), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    negative(Traduccion, Palabra), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    common_phrase(Traduccion, Palabra), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    conjunction(Traduccion, Palabra), !.

% INGLÉS → ESPAÑOL: buscar en posición 1 → retornar posición 2
traducir_palabra(Palabra, english, spanish, Traduccion) :-
    pronoun(Palabra, Traduccion, _), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    article(Palabra, Traduccion, _, _), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    noun(Palabra, Traduccion, _, _), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    adjective(Palabra, Traduccion, _, _), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    traducir_verbo(Palabra, english, spanish, Traduccion), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    adverb(Palabra, Traduccion), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    preposition(Palabra, Traduccion), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    question_word(Palabra, Traduccion), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    negative(Palabra, Traduccion), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    common_phrase(Palabra, Traduccion), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    conjunction(Palabra, Traduccion), !.
    
% Si no hay traducción, dejar igual
traducir_palabra(Palabra, _, _, Palabra).

% =============================================================================
% TRADUCIR VERBO
% =============================================================================

traducir_verbo(PalabraEspanol, spanish, english, Traduccion) :-
    base_espanol(PalabraEspanol, InfinitivoEspanol, Persona),
    traducir_infinitivo(InfinitivoEspanol, spanish, english, InfinitivoIngles),
    mapear_persona(Persona, spanish, english, Pronombre),
    conjugar_ingles(InfinitivoIngles, Pronombre, Traduccion).

traducir_verbo(PalabraIngles, english, spanish, Traduccion) :-
    base_ingles(PalabraIngles, InfinitivoIngles, Pronombre),
    traducir_infinitivo(InfinitivoIngles, english, spanish, InfinitivoEspanol),
    mapear_persona(Pronombre, english, spanish, Persona),
    conjugar_espanol(InfinitivoEspanol, Persona, Traduccion).

% =============================================================================
% TRADUCIR INFINITIVO
% =============================================================================

traducir_infinitivo(Infinitivo, spanish, english, Traduccion) :-
    (   mapeo_irregular_espanol_ingles(Infinitivo, Traduccion)
    ;   verb_infinitive(Traduccion, Infinitivo, _)
    ), !.

traducir_infinitivo(Infinitivo, english, spanish, Traduccion) :-
    (   mapeo_irregular_ingles_espanol(Infinitivo, Traduccion)
    ;   verb_infinitive(Infinitivo, Traduccion, _)
    ), !.

% =============================================================================
% MAPEO DE IRREGULARES (usando DB.pl)
% =============================================================================

% Obtener el infinitivo inglés de un irregular español
mapeo_irregular_espanol_ingles(InfinitivoEspanol, InfinitivoIngles) :-
    irregular_verb_pair(InfinitivoEspanol, InfinitivoIngles).

% Obtener el infinitivo español de un irregular inglés
mapeo_irregular_ingles_espanol(InfinitivoIngles, InfinitivoEspanol) :-
    irregular_verb_pair(InfinitivoEspanol, InfinitivoIngles).

% =============================================================================
% MAPEO DE PERSONAS con pronombres - para los verbos 
% =============================================================================

% Mapear persona de español a pronombre en inglés
mapear_persona(PersonaEspanol, spanish, english, PronombreIngles) :-
    pronoun(PronombreIngles, PersonaEspanol, _).

% Mapear pronombre en ingles inglés a persona en español 
    mapear_persona(PronombreIngles, english, spanish, PersonaEspanol) :-
        pronoun(PronombreIngles, PersonaEspanol, _).

% =============================================================================
% TRADUCIR LISTA
% =============================================================================

traducir_lista([], _, _, []).

traducir_lista([Palabra|Resto], LangOrigen, LangDestino, [Traducida|RestoTraducido]) :-
    traducir_palabra(Palabra, LangOrigen, LangDestino, Traducida),
    traducir_lista(Resto, LangOrigen, LangDestino, RestoTraducido).

% =============================================================================
% TRADUCIR LISTA CON CONTEXTO (para resolver ambigüedades)
% =============================================================================

% Versión con contexto que mira el siguiente token
traducir_lista_contextual([], _, _, []).

% Caso especial: "el" en español seguido de sustantivo → artículo "the"
traducir_lista_contextual([el|[Siguiente|Resto]], spanish, english, [the|RestoTrad]) :-
    es_nombre_token(Siguiente, spanish),
    traducir_lista_contextual([Siguiente|Resto], spanish, english, RestoTrad), !.

% Caso especial: "el" en español seguido de verbo → pronombre "he"
traducir_lista_contextual([el|[Siguiente|Resto]], spanish, english, [he|RestoTrad]) :-
    es_verbo_token(Siguiente, spanish),
    traducir_lista_contextual([Siguiente|Resto], spanish, english, RestoTrad), !.

% Caso especial: "el" en español seguido de adjetivo → pronombre "he"
traducir_lista_contextual([el|[Siguiente|Resto]], spanish, english, [he|RestoTrad]) :-
    es_adjetivo_token(Siguiente, spanish),
    traducir_lista_contextual([Siguiente|Resto], spanish, english, RestoTrad), !.

% Caso especial: "el" al final → artículo por defecto
traducir_lista_contextual([el], spanish, english, [the]) :- !.

% Caso general: traducir palabra normalmente
traducir_lista_contextual([Palabra|Resto], LangOrigen, LangDestino, [Traducida|RestoTraducido]) :-
    traducir_palabra(Palabra, LangOrigen, LangDestino, Traducida),
    traducir_lista_contextual(Resto, LangOrigen, LangDestino, RestoTraducido).

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
reordenar_sintagma_nominal_es_a_en([Articulo, Sustantivo, Adjetivo], Resultado) :-
    % Primero traducir cada palabra
    traducir_palabra(Articulo, spanish, english, ArticuloEn),
    traducir_palabra(Sustantivo, spanish, english, SustantivoEn),
    traducir_palabra(Adjetivo, spanish, english, AdjetivoEn),
    % REORDENAR: construir lista en orden [Art, ADJ, Sust]
    Resultado = [ArticuloEn, AdjetivoEn, SustantivoEn], !.

% Sin adjetivo: [art, sust] → [art, sust]
reordenar_sintagma_nominal_es_a_en([Articulo, Sustantivo], Resultado) :-
    traducir_palabra(Articulo, spanish, english, ArticuloEn),
    traducir_palabra(Sustantivo, spanish, english, SustantivoEn),
    Resultado = [ArticuloEn, SustantivoEn], !.

% Una sola palabra
reordenar_sintagma_nominal_es_a_en([Palabra], [Traduccion]) :-
    traducir_palabra(Palabra, spanish, english, Traduccion).

% --- Reordenar inglés → español ---

% Con adjetivo: [art, adj, sust] → [art, sust, adj]
reordenar_sintagma_nominal_en_a_es([Articulo, Adjetivo, Sustantivo], Resultado) :-
    % Primero traducir cada palabra
    traducir_palabra(Articulo, english, spanish, ArticuloEs),
    traducir_palabra(Adjetivo, english, spanish, AdjetivoEs),
    traducir_palabra(Sustantivo, english, spanish, SustantivoEs),
    % REORDENAR: construir lista en orden [Art, Sust, ADJ]
    Resultado = [ArticuloEs, SustantivoEs, AdjetivoEs], !.

% Sin adjetivo: [art, sust] → [art, sust]
reordenar_sintagma_nominal_en_a_es([Articulo, Sustantivo], Resultado) :-
    traducir_palabra(Articulo, english, spanish, ArticuloEs),
    traducir_palabra(Sustantivo, english, spanish, SustantivoEs),
    Resultado = [ArticuloEs, SustantivoEs], !.

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

% =============================================================================
% TRADUCCIÓN INTELIGENTE DE ORACIONES
% =============================================================================

% Punto de entrada principal: traducir una oración completa
traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    detectar_y_traducir_sn_verbo(Tokens, LangOrigen, LangDestino, Traduccion), !.

% Fallback: intentar traducir como SN puro (sin verbo)
traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    extraer_sn_inicial(Tokens, LangOrigen, SN, []),  % SN que consume todos los tokens
    length(SN, L), L > 0,
    traducir_sn_con_reorden(SN, LangOrigen, LangDestino, Traduccion), !.

% Último fallback: traducción contextual palabra por palabra
traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    traducir_lista_contextual(Tokens, LangOrigen, LangDestino, Traduccion).

% Detectar patrón: [SN] + Verbo + [resto]
% Casos: "el gato grande come", "yo como el pan bueno"
detectar_y_traducir_sn_verbo(Tokens, LangOrigen, LangDestino, Traduccion) :-
    extraer_sn_inicial(Tokens, LangOrigen, SN, Resto),
    length(SN, LSN), LSN > 0,
    Resto = [Verbo|RestoOracion],
    es_verbo_token(Verbo, LangOrigen),
    % Traducir cada parte
    traducir_sn_con_reorden(SN, LangOrigen, LangDestino, SNTrad),
    traducir_palabra(Verbo, LangOrigen, LangDestino, VerboTrad),
    traducir_resto_oracion(RestoOracion, LangOrigen, LangDestino, RestoTrad),
    append(SNTrad, [VerboTrad|RestoTrad], Traduccion), !.

% Extraer sintagma nominal al inicio de la oración
extraer_sn_inicial(Tokens, Lang, SN, Resto) :-
    extraer_sn_tokens(Tokens, Lang, SN, Resto),
    length(SN, L), L > 0, !.

% Patrón: Art + Adj + Nombre (inglés: the big cat)
extraer_sn_tokens([A, Adj, N|Resto], Lang, [A, Adj, N], Resto) :-
    es_articulo_token(A, Lang),
    es_adjetivo_token(Adj, Lang),
    es_nombre_token(N, Lang),
    Lang = english,  % Solo para inglés
    \+ es_verbo_token(N, Lang), !.

% Patrón: Art + Nombre + Adj (español: el gato grande)
extraer_sn_tokens([A, N, Adj|Resto], Lang, [A, N, Adj], Resto) :-
    es_articulo_token(A, Lang),
    es_nombre_token(N, Lang),
    es_adjetivo_token(Adj, Lang),
    \+ es_verbo_token(Adj, Lang), !.

% Patrón: Art + Nombre (verificar que sea nombre, no verbo ni adjetivo solo)
extraer_sn_tokens([A, N|Resto], Lang, [A, N], Resto) :-
    es_articulo_token(A, Lang),
    es_nombre_token(N, Lang),
    \+ es_verbo_token(N, Lang), !.

% Patrón: Pronombre solo (nunca capturar "el" si no viene con sustantivo)
extraer_sn_tokens([P|Resto], Lang, [P], Resto) :-
    es_pronombre_token(P, Lang),
    % Excluir "el" si viene seguido de verbo/adjetivo (es pronombre, no sintagma)
    \+ (P = el, Lang = spanish, Resto = [Siguiente|_], 
        (es_verbo_token(Siguiente, spanish) ; 
         (es_adjetivo_token(Siguiente, spanish), \+ es_nombre_token(Siguiente, spanish)))), !.

% Patrón: Adj + Nombre (inglés sin artículo: big cat)
extraer_sn_tokens([Adj, N|Resto], Lang, [Adj, N], Resto) :-
    es_adjetivo_token(Adj, Lang),
    es_nombre_token(N, Lang),
    Lang = english,  % Solo para inglés
    \+ es_verbo_token(N, Lang), !.

% Patrón: Nombre + Adj (español sin artículo: gato grande)
extraer_sn_tokens([N, Adj|Resto], Lang, [N, Adj], Resto) :-
    es_nombre_token(N, Lang),
    es_adjetivo_token(Adj, Lang),
    \+ es_verbo_token(Adj, Lang), !.

% Patrón: Nombre solo (asegurar que es sustantivo, no verbo)
extraer_sn_tokens([N|Resto], Lang, [N], Resto) :-
    es_nombre_token(N, Lang),
    \+ es_verbo_token(N, Lang),
    \+ es_pronombre_token(N, Lang), !.

% Si no coincide nada, retornar vacío
extraer_sn_tokens(Tokens, _, [], Tokens).

% Traducir SN aplicando reordenamiento según sea necesario
traducir_sn_con_reorden([Art, Nombre, Adj], spanish, english, Resultado) :-
    es_articulo_token(Art, spanish),
    es_nombre_token(Nombre, spanish),
    es_adjetivo_token(Adj, spanish),
    % Reordenar y traducir: [Art, Nombre, Adj] → [Art, Adj, Nombre]
    reordenar_sintagma_nominal_es_a_en([Art, Nombre, Adj], Resultado), !.

traducir_sn_con_reorden([Art, Nombre], spanish, english, Resultado) :-
    es_articulo_token(Art, spanish),
    es_nombre_token(Nombre, spanish),
    % Traducir sin reordenar
    reordenar_sintagma_nominal_es_a_en([Art, Nombre], Resultado), !.

traducir_sn_con_reorden([Nombre, Adj], spanish, english, [AdjEn, NombreEn]) :-
    es_nombre_token(Nombre, spanish),
    es_adjetivo_token(Adj, spanish),
    % Reordenar nombre-adj a adj-nombre
    traducir_palabra(Nombre, spanish, english, NombreEn),
    traducir_palabra(Adj, spanish, english, AdjEn), !.

traducir_sn_con_reorden([Art, Adj, Nombre], english, spanish, Resultado) :-
    es_articulo_token(Art, english),
    es_adjetivo_token(Adj, english),
    es_nombre_token(Nombre, english),
    % Reordenar y traducir: [Art, Adj, Nombre] → [Art, Nombre, Adj]
    reordenar_sintagma_nominal_en_a_es([Art, Adj, Nombre], Resultado), !.

traducir_sn_con_reorden([Art, Nombre], english, spanish, Resultado) :-
    es_articulo_token(Art, english),
    es_nombre_token(Nombre, english),
    % Traducir sin reordenar
    reordenar_sintagma_nominal_en_a_es([Art, Nombre], Resultado), !.

traducir_sn_con_reorden([Adj, Nombre], english, spanish, [NombreEs, AdjEs]) :-
    es_adjetivo_token(Adj, english),
    es_nombre_token(Nombre, english),
    % Reordenar adj-nombre a nombre-adj
    traducir_palabra(Nombre, english, spanish, NombreEs),
    traducir_palabra(Adj, english, spanish, AdjEs), !.

% Caso pronombre
traducir_sn_con_reorden([Pronombre], LangOrigen, LangDestino, [PronTrad]) :-
    es_pronombre_token(Pronombre, LangOrigen),
    traducir_palabra(Pronombre, LangOrigen, LangDestino, PronTrad), !.

% Fallback usando traducción contextual
traducir_sn_con_reorden(SN, LangOrigen, LangDestino, SNTrad) :-
    traducir_lista_contextual(SN, LangOrigen, LangDestino, SNTrad).

% Traducir el resto de la oración (puede contener otro SN)
traducir_resto_oracion([], _, _, []) :- !.

traducir_resto_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    extraer_sn_inicial(Tokens, LangOrigen, SN, Resto),
    length(SN, L), L > 0,
    traducir_sn_con_reorden(SN, LangOrigen, LangDestino, SNTrad),
    traducir_resto_oracion(Resto, LangOrigen, LangDestino, RestoTrad),
    append(SNTrad, RestoTrad, Traduccion), !.

traducir_resto_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    traducir_lista_contextual(Tokens, LangOrigen, LangDestino, Traduccion).

% =============================================================================
% HELPERS PARA DETECCIÓN DE TIPOS
% =============================================================================

es_articulo_token(Palabra, spanish) :- article(_, Palabra, _, _).
es_articulo_token(Palabra, english) :- article(Palabra, _, _, _).

es_nombre_token(Palabra, spanish) :- noun(_, Palabra, _, _).
es_nombre_token(Palabra, english) :- noun(Palabra, _, _, _).

es_adjetivo_token(Palabra, spanish) :- adjective(_, Palabra, _, _).
es_adjetivo_token(Palabra, english) :- adjective(Palabra, _, _, _).

es_pronombre_token(Palabra, spanish) :- pronoun(_, Palabra, _).
es_pronombre_token(Palabra, english) :- pronoun(Palabra, _, _).

es_verbo_token(Palabra, spanish) :- 
    (verb_infinitive(_, Palabra, _) ; 
     irregular_form_spanish(Palabra, _, _, present) ;
     base_espanol(Palabra, _, _)).  % Reconocer verbos conjugados regulares

es_verbo_token(Palabra, english) :- 
    (verb_infinitive(Palabra, _, _) ; 
     irregular_form(Palabra, _, _, present) ;
     base_ingles(Palabra, _, _)).  % Reconocer verbos conjugados regulares