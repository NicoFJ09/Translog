:- encoding(utf8).
:- consult('../database/DB.pl').
:- consult('./conjugador.pl').

% =============================================================================
% TRADUCIR UNA PALABRA
% =============================================================================

% ESPAÑOL → INGLÉS: buscar en posición 2 → retornar posición 1
traducir_palabra(Palabra, spanish, english, Traduccion) :-
    article(Traduccion, Palabra, _, _), !.

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    possessive_adjective(Traduccion, Palabra, _), !.

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

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    number_word(Traduccion, Palabra), !.

% INGLÉS → ESPAÑOL: buscar en posición 1 → retornar posición 2
traducir_palabra(Palabra, english, spanish, Traduccion) :-
    possessive_adjective(Palabra, Traduccion, _), !.

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

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    number_word(Palabra, Traduccion), !.
    
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

% Traducir palabra sin buscar question_word 
traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    article(Traduccion, Palabra, _, _), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    possessive_adjective(Traduccion, Palabra, _), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    pronoun(Traduccion, Palabra, _), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    noun(Traduccion, Palabra, _, _), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    adjective(Traduccion, Palabra, _, _), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    traducir_verbo(Palabra, spanish, english, Traduccion), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    adverb(Traduccion, Palabra), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    preposition(Traduccion, Palabra), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    negative(Traduccion, Palabra), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    common_phrase(Traduccion, Palabra), !.

traducir_palabra_sin_interrogativa(Palabra, spanish, english, Traduccion) :-
    conjunction(Traduccion, Palabra), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    possessive_adjective(Palabra, Traduccion, _), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    pronoun(Palabra, Traduccion, _), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    article(Palabra, Traduccion, _, _), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    noun(Palabra, Traduccion, _, _), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    adjective(Palabra, Traduccion, _, _), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    traducir_verbo(Palabra, english, spanish, Traduccion), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    adverb(Palabra, Traduccion), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    preposition(Palabra, Traduccion), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    negative(Palabra, Traduccion), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    common_phrase(Palabra, Traduccion), !.

traducir_palabra_sin_interrogativa(Palabra, english, spanish, Traduccion) :-
    conjunction(Palabra, Traduccion), !.

traducir_palabra_sin_interrogativa(Palabra, _, _, Palabra).

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

% Detectar y traducir oraciones interrogativas PRIMERO
traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    detectar_interrogativa(Tokens, LangOrigen),
    !,
    reordenar_interrogativa(Tokens, LangOrigen, LangDestino, Traduccion).

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

% =============================================================================
% REGLAS DE ORDEN PARA ORACIONES INTERROGATIVAS
% =============================================================================

% --- INGLÉS → ESPAÑOL ---
% Patrón: [Question_Word, Auxiliary, Subject, Verb, ...] → [Question_Word, Verb, Subject, ...]

% Interrogativa con palabra interrogativa + auxiliar DO/DOES
% Ejemplo: "What do you eat?" → "¿Qué comes?"
reordenar_interrogativa([QWord, Aux, Sujeto | Resto], english, spanish, OracionReordenada) :-
    question_word(QWord, QWordEs),
    es_auxiliar_do(Aux),
    pronoun(Sujeto, SujetoEs, Categoria),
    Resto = [Verbo | RestoOracion],
    verb_infinitive(Verbo, VerboEs, _),
    % Conjugar verbo en español según persona
    persona_de_categoria(Categoria, PersonaEs),
    conjugar_espanol(VerboEs, PersonaEs, VerboConjugadoEs),
    % Traducir el resto
    traducir_lista(RestoOracion, english, spanish, RestoTraducido),
    % Orden español: QWord + Verbo + Sujeto + Resto
    append([QWordEs, VerboConjugadoEs, SujetoEs], RestoTraducido, OracionReordenada).

% Interrogativa con palabra interrogativa + verbo BE
% Ejemplo: "Where is he?" → "¿Dónde está él?"
reordenar_interrogativa([QWord, Verbo, Sujeto | Resto], english, spanish, OracionReordenada) :-
    question_word(QWord, QWordEs),
    es_verbo_be(Verbo),
    pronoun(Sujeto, SujetoEs, Categoria),
    % Usar traducción del verbo BE según contexto
    traducir_verbo_be_segun_persona(Verbo, Categoria, VerboEs),
    traducir_lista(Resto, english, spanish, RestoTraducido),
    % Orden español: QWord + Verbo + Sujeto + Resto
    append([QWordEs, VerboEs, SujetoEs], RestoTraducido, OracionReordenada).

% Interrogativa simple con auxiliar DO/DOES (yes/no question)
% Ejemplo: "Do you eat?" → "¿Comes?"
% Ejemplo: "Does she work?" → "¿Trabaja ella?"
reordenar_interrogativa([Aux, Sujeto, Verbo | Resto], english, spanish, OracionReordenada) :-
    es_auxiliar_do(Aux),
    pronoun(Sujeto, SujetoEs, Categoria),
    verb_infinitive(Verbo, VerboEs, _),
    persona_de_categoria(Categoria, PersonaEs),
    conjugar_espanol(VerboEs, PersonaEs, VerboConjugadoEs),
    traducir_lista(Resto, english, spanish, RestoTraducido),
    % Orden español: Verbo + Sujeto + Resto
    append([VerboConjugadoEs, SujetoEs], RestoTraducido, OracionReordenada).

% Caso especial: Yes/No con verbo pero sin resto
reordenar_interrogativa([Aux, Sujeto, Verbo], english, spanish, [VerboConjugadoEs, SujetoEs]) :-
    es_auxiliar_do(Aux),
    pronoun(Sujeto, SujetoEs, Categoria),
    verb_infinitive(Verbo, VerboEs, _),
    persona_de_categoria(Categoria, PersonaEs),
    conjugar_espanol(VerboEs, PersonaEs, VerboConjugadoEs).

% Interrogativa simple con verbo BE (yes/no question)
% Ejemplo: "Is he happy?" → "¿Es él feliz?"
reordenar_interrogativa([Verbo, Sujeto | Resto], english, spanish, OracionReordenada) :-
    es_verbo_be(Verbo),
    pronoun(Sujeto, SujetoEs, Categoria),
    traducir_verbo_be_segun_persona(Verbo, Categoria, VerboEs),
    traducir_lista(Resto, english, spanish, RestoTraducido),
    % Orden español: Verbo + Sujeto + Resto
    append([VerboEs, SujetoEs], RestoTraducido, OracionReordenada).

% --- ESPAÑOL → INGLÉS ---
% Patrón: [Question_Word, Verb, Subject, ...] → [Question_Word, Auxiliary, Subject, Verb_Infinitive, ...]

% Interrogativa con palabra interrogativa + verbo SER/ESTAR + sustantivo/adjetivo
% Ejemplo: "¿Cuál es tu nombre?" → "What is your name?"
% Ejemplo: "¿Cómo estás?" → "How are you?"
reordenar_interrogativa([QWord, Verbo, Sujeto | Resto], spanish, english, OracionReordenada) :-
    question_word(QWordEn, QWord),
    es_verbo_ser_estar(Verbo),
    !,  % Cut para evitar backtracking
    % Traducir sujeto (puede ser pronombre o artículo posesivo)
    (pronoun(SujetoEn, Sujeto, _) -> true ; traducir_palabra(Sujeto, spanish, english, SujetoEn)),
    traducir_palabra(Verbo, spanish, english, VerboEn),
    traducir_lista(Resto, spanish, english, RestoTraducido),
    % Orden inglés: QWord + Verbo + Sujeto + Resto
    append([QWordEn, VerboEn, SujetoEn], RestoTraducido, OracionReordenada).

% Interrogativa con palabra interrogativa + verbo regular
% Ejemplo: "¿Qué comes?" → "What do you eat?"
% Ejemplo: "¿Qué cocinas?" → "What do you cook?"
reordenar_interrogativa([QWord, Verbo, Sujeto | Resto], spanish, english, OracionReordenada) :-
    question_word(QWordEn, QWord),
    es_verbo_token(Verbo, spanish),
    \+ es_verbo_ser_estar(Verbo),  % Asegurar que NO es SER/ESTAR
    !,
    (pronoun(SujetoEn, Sujeto, Categoria) -> true ; (SujetoEn = Sujeto, Categoria = second_singular)),
    % Obtener infinitivo del verbo
    (base_espanol(Verbo, InfinitivoEs, _) ; InfinitivoEs = Verbo),
    traducir_infinitivo(InfinitivoEs, spanish, english, InfinitivoEn),
    % Determinar auxiliar según categoría
    auxiliar_segun_categoria(Categoria, Auxiliar),
    % Traducir resto
    traducir_lista(Resto, spanish, english, RestoTraducido),
    % Orden inglés: QWord + Aux + Sujeto + Verbo + Resto
    append([QWordEn, Auxiliar, SujetoEn, InfinitivoEn], RestoTraducido, OracionReordenada).

% Interrogativa con palabra interrogativa + verbo (sin sujeto explícito)
% Ejemplo: "¿Cómo estás?" → "How are you?"
reordenar_interrogativa([QWord, Verbo | Resto], spanish, english, OracionReordenada) :-
    question_word(QWordEn, QWord),
    es_verbo_ser_estar(Verbo),
    !,
    % Inferir pronombre desde el verbo
    (base_espanol(Verbo, _, Persona) ; irregular_form_spanish(Verbo, _, Persona, present)),
    mapear_persona(Persona, spanish, english, PronombreEn),
    traducir_palabra(Verbo, spanish, english, VerboEn),
    traducir_lista(Resto, spanish, english, RestoTraducido),
    % Orden inglés: QWord + Verbo + Pronombre + Resto
    append([QWordEn, VerboEn, PronombreEn], RestoTraducido, OracionReordenada).

% Interrogativa simple con SER/ESTAR + pronombre
% Ejemplo: "¿Está feliz?" → "Is he happy?"
reordenar_interrogativa([Verbo, Sujeto | Resto], spanish, english, OracionReordenada) :-
    es_verbo_ser_estar(Verbo),
    pronoun(SujetoEn, Sujeto, _),
    !,  % Cut para evitar backtracking
    traducir_palabra(Verbo, spanish, english, VerboEn),
    traducir_lista(Resto, spanish, english, RestoTraducido),
    % Orden inglés: Verbo + Sujeto + Resto
    append([VerboEn, SujetoEn], RestoTraducido, OracionReordenada).

% Interrogativa simple con SER/ESTAR sin pronombre explícito
% Ejemplo: "¿Estás triste?" → "Are you sad?"
reordenar_interrogativa([Verbo | Resto], spanish, english, OracionReordenada) :-
    es_verbo_ser_estar(Verbo),
    !,
    % Inferir pronombre desde el verbo
    (irregular_form_spanish(Verbo, _, Persona, present) -> true ; Persona = tu),
    mapear_persona(Persona, spanish, english, PronombreEn),
    traducir_palabra(Verbo, spanish, english, VerboEn),
    traducir_lista(Resto, spanish, english, RestoTraducido),
    % Orden inglés: Verbo + Pronombre + Resto
    append([VerboEn, PronombreEn], RestoTraducido, OracionReordenada).

% Interrogativa simple (yes/no question) con verbo regular
% Ejemplo: "¿Comes?" → "Do you eat?"
reordenar_interrogativa([Verbo, Sujeto | Resto], spanish, english, OracionReordenada) :-
    es_verbo_token(Verbo, spanish),
    \+ es_verbo_ser_estar(Verbo),  % Asegurar que NO es SER/ESTAR
    pronoun(SujetoEn, Sujeto, Categoria),
    (base_espanol(Verbo, InfinitivoEs, _) ; InfinitivoEs = Verbo),
    traducir_infinitivo(InfinitivoEs, spanish, english, InfinitivoEn),
    auxiliar_segun_categoria(Categoria, Auxiliar),
    traducir_lista(Resto, spanish, english, RestoTraducido),
    % Orden inglés: Aux + Sujeto + Verbo + Resto
    append([Auxiliar, SujetoEn, InfinitivoEn], RestoTraducido, OracionReordenada).

% Interrogativa con verbo regular sin pronombre explícito
% Ejemplo: "¿Cocinas?" → "Do you cook?"
reordenar_interrogativa([Verbo | Resto], spanish, english, OracionReordenada) :-
    es_verbo_token(Verbo, spanish),
    \+ es_verbo_ser_estar(Verbo),
    !,
    % Inferir persona desde el verbo
    (base_espanol(Verbo, InfinitivoEs, Persona) ; (InfinitivoEs = Verbo, Persona = tu)),
    traducir_infinitivo(InfinitivoEs, spanish, english, InfinitivoEn),
    mapear_persona(Persona, spanish, english, PronombreEn),
    persona_a_categoria(Persona, Categoria),
    auxiliar_segun_categoria(Categoria, Auxiliar),
    traducir_lista(Resto, spanish, english, RestoTraducido),
    % Orden inglés: Aux + Pronombre + Verbo + Resto
    append([Auxiliar, PronombreEn, InfinitivoEn], RestoTraducido, OracionReordenada).

% =============================================================================
% FUNCIONES AUXILIARES PARA INTERROGATIVAS
% =============================================================================

% Detectar si una oración es interrogativa
detectar_interrogativa([Primera|_], english) :-
    ( es_auxiliar_do(Primera) ; es_verbo_be(Primera) ; question_word(Primera, _) ).

detectar_interrogativa([Primera|Resto], spanish) :-
    ( question_word(_, Primera) ; (es_verbo_token(Primera, spanish), Resto \= []) ).

% Identificar auxiliares DO/DOES
es_auxiliar_do(do).
es_auxiliar_do(does).

% Identificar verbo BE en sus formas
es_verbo_be(am).
es_verbo_be(is).
es_verbo_be(are).
es_verbo_be(was).
es_verbo_be(were).

% Identificar verbos SER/ESTAR
es_verbo_ser_estar(soy).
es_verbo_ser_estar(eres).
es_verbo_ser_estar(es).
es_verbo_ser_estar(somos).
es_verbo_ser_estar(son).
es_verbo_ser_estar(estoy).
es_verbo_ser_estar(estas).
es_verbo_ser_estar(esta).
es_verbo_ser_estar(estamos).
es_verbo_ser_estar(estan).

% Mapear categoría de pronombre a persona española
% Nota: ella y el usan la misma conjugación, así que mapeamos ambos a 'el'
persona_de_categoria(first_singular, yo).
persona_de_categoria(second_singular, tu).
persona_de_categoria(third_singular_masculine, el).
persona_de_categoria(third_singular_feminine, el).  % Mismo que 'el' para conjugación
persona_de_categoria(first_plural, nosotros).
persona_de_categoria(third_plural_masculine, ellos).
persona_de_categoria(third_plural_feminine, ellos).  % Mismo que 'ellos' para conjugación

% Determinar auxiliar según categoría
auxiliar_segun_categoria(third_singular_masculine, does).
auxiliar_segun_categoria(third_singular_feminine, does).
auxiliar_segun_categoria(_, do).

% Mapear persona a categoría (inverso de persona_de_categoria)
persona_a_categoria(yo, first_singular).
persona_a_categoria(tu, second_singular).
persona_a_categoria(el, third_singular_masculine).
persona_a_categoria(ella, third_singular_feminine).
persona_a_categoria(nosotros, first_plural).
persona_a_categoria(ellos, third_plural_masculine).
persona_a_categoria(ellas, third_plural_feminine).

% Traducir verbo BE según persona (usa ESTAR por defecto en preguntas de ubicación)
traducir_verbo_be_segun_persona(am, first_singular, estoy).
traducir_verbo_be_segun_persona(are, second_singular, estas).
traducir_verbo_be_segun_persona(is, third_singular_masculine, esta).
traducir_verbo_be_segun_persona(is, third_singular_feminine, esta).
traducir_verbo_be_segun_persona(are, first_plural, estamos).
traducir_verbo_be_segun_persona(are, third_plural_masculine, estan).
traducir_verbo_be_segun_persona(are, third_plural_feminine, estan).

% Si el contexto indica característica permanente, usar SER
% (esto se puede extender con análisis del complemento)
traducir_verbo_be_a_ser(am, soy).
traducir_verbo_be_a_ser(are, eres).
traducir_verbo_be_a_ser(is, es).
traducir_verbo_be_a_ser(are, son).