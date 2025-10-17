% ===============================================
% ARTICLES & ADJECTIVES MODULE
% Sistema de Concordancia de Género y Número
% ===============================================
% Persona 2: David
% Fecha: 17 de Octubre 2025
% 
% RESPONSABILIDADES:
% - Concordancia artículo-sustantivo-adjetivo
% - Selección de a/an según contexto
% - Ajuste de adjetivos según género del sustantivo
% - Reordenamiento de adjetivos (ES ↔ EN)
% ===============================================

:- consult('../database/DB.pl').
% NOTA: Si se carga desde raíz, usar: consult('src/database/DB.pl')

% =============================================================================
% 1. VERIFICACIÓN DE CONCORDANCIA
% =============================================================================

% verificar_concordancia(+Articulo, +Sustantivo, +Adjetivo)
% Verifica que artículo, sustantivo y adjetivo concuerden en género y número
%
% NOTA: El sustantivo puede estar en español o inglés
% noun(English, Spanish, Gender, Number) en DB.pl
% adjective(English, Spanish) o adjective(English, Spanish, Gender, Number)
%
% Ejemplos:
%   ?- verificar_concordancia(el, gato, pequeno).
%   true.
%   ?- verificar_concordancia(la, gato, pequeno).
%   false.
verificar_concordancia(Art, Sust, Adj) :-
    % 1. Obtener género y número del artículo
    article(_, Art, GeneroArt, NumeroArt),
    
    % 2. Verificar que el sustantivo coincida (puede ser español)
    ( noun(_, Sust, GeneroArt, NumeroArt) -> true
    ; noun(Sust, _, GeneroArt, NumeroArt) ),
    
    % 3. Verificar el adjetivo (puede estar en español o inglés)
    ( adjective(_, Adj, GeneroArt, NumeroArt) -> true  % Español con género
    ; adjective(Adj, _, GeneroArt, NumeroArt) -> true  % Inglés con género
    ; adjective(_, Adj) -> true                         % Español invariable
    ; adjective(Adj, _) ).                              % Inglés invariable


% verificar_concordancia_simple(+Articulo, +Sustantivo)
% Solo verifica artículo-sustantivo (sin adjetivo)
%
% Ejemplo:
%   ?- verificar_concordancia_simple(el, gato).
%   true.
verificar_concordancia_simple(Art, Sust) :-
    article(_, Art, Genero, Numero),
    ( noun(_, Sust, Genero, Numero) -> true  % Sustantivo en español
    ; noun(Sust, _, Genero, Numero) ).       % Sustantivo en inglés


% =============================================================================
% 2. SELECCIÓN DE ARTÍCULOS
% =============================================================================

% seleccionar_articulo_espanol(+Sustantivo, +Tipo, -Articulo)
% Selecciona el artículo español correcto según el sustantivo
% Tipo: definido | indefinido
%
% Ejemplos:
%   ?- seleccionar_articulo_espanol(gato, definido, Art).
%   Art = el.
%   ?- seleccionar_articulo_espanol(casa, indefinido, Art).
%   Art = una.
seleccionar_articulo_espanol(Sust, definido, Art) :-
    ( noun(_, Sust, Genero, Numero) -> true  % Es español
    ; noun(Sust, _, Genero, Numero) ),       % Es inglés
    article(the, Art, Genero, Numero).

seleccionar_articulo_espanol(Sust, indefinido, Art) :-
    ( noun(_, Sust, Genero, Numero) -> true
    ; noun(Sust, _, Genero, Numero) ),
    article(a, Art, Genero, Numero).


% seleccionar_articulo_ingles(+Sustantivo_EN, +Tipo, -Articulo)
% Selecciona 'a' o 'an' según si la palabra empieza con vocal
% Tipo: definido | indefinido
%
% Ejemplos:
%   ?- seleccionar_articulo_ingles(apple, indefinido, Art).
%   Art = an.
%   ?- seleccionar_articulo_ingles(cat, indefinido, Art).
%   Art = a.
seleccionar_articulo_ingles(_, definido, the) :- !.

seleccionar_articulo_ingles(Palabra, indefinido, an) :-
    empieza_con_vocal(Palabra), !.

seleccionar_articulo_ingles(_, indefinido, a).


% empieza_con_vocal(+Palabra)
% Verifica si una palabra empieza con vocal
empieza_con_vocal(Palabra) :-
    atom_chars(Palabra, [Primera|_]),
    member(Primera, [a, e, i, o, u, 'A', 'E', 'I', 'O', 'U']).


% =============================================================================
% 3. TRADUCCIÓN DE ARTÍCULOS CON CONTEXTO
% =============================================================================

% traducir_articulo_en_a_es(+ArtIngles, +SustantivoEspanol, -ArtEspanol)
% Traduce artículo inglés a español usando el contexto del sustantivo
% porque 'the' no indica género
%
% Ejemplo:
%   ?- traducir_articulo_en_a_es(the, gato, Art).
%   Art = el.
%   ?- traducir_articulo_en_a_es(the, casa, Art).
%   Art = la.
traducir_articulo_en_a_es(the, SustES, ArtES) :-
    noun(_, SustES, Genero, Numero),  % Sustantivo en español (2do parámetro)
    article(the, ArtES, Genero, Numero), !.

traducir_articulo_en_a_es(a, SustES, ArtES) :-
    noun(_, SustES, Genero, Numero),
    article(a, ArtES, Genero, Numero), !.

traducir_articulo_en_a_es(an, SustES, ArtES) :-
    noun(_, SustES, Genero, Numero),
    article(a, ArtES, Genero, Numero), !.

traducir_articulo_en_a_es(some, SustES, ArtES) :-
    noun(_, SustES, Genero, Numero),
    article(some, ArtES, Genero, Numero), !.


% traducir_articulo_es_a_en(+ArtEspanol, +SustantivoIngles, -ArtIngles)
% Traduce artículo español a inglés
% Más simple porque inglés no tiene género
%
% Ejemplo:
%   ?- traducir_articulo_es_a_en(el, cat, Art).
%   Art = the.
traducir_articulo_es_a_en(ArtES, SustEN, ArtEN) :-
    article(ArtEN, ArtES, _, _),
    % Ajustar 'a' o 'an' si es indefinido
    ( ArtEN = a -> seleccionar_articulo_ingles(SustEN, indefinido, ArtENFinal)
    ; ArtENFinal = ArtEN ),
    ArtEN = ArtENFinal, !.


% =============================================================================
% 4. AJUSTE DE ADJETIVOS SEGÚN GÉNERO
% =============================================================================

% ajustar_adjetivo_genero(+AdjetivoEN, +SustantivoES, -AdjetivoES)
% Ajusta el adjetivo inglés al género y número del sustantivo español
%
% Ejemplos:
%   ?- ajustar_adjetivo_genero(small, gato, Adj).
%   Adj = pequeno.
%   ?- ajustar_adjetivo_genero(small, casa, Adj).
%   Adj = pequena.
ajustar_adjetivo_genero(AdjEN, SustES, AdjES) :-
    % Obtener género y número del sustantivo español
    noun(_, SustES, Genero, Numero),  % Sustantivo en español (2do parámetro)
    
    % Buscar adjetivo que coincida con ese género/número
    ( adjective(AdjEN, AdjES, Genero, Numero) -> true  % Con género
    ; adjective(AdjEN, AdjES) ),  % Si es invariable
    !.


% ajustar_adjetivo_numero(+AdjetivoES, +Singular, -Plural)
% Convierte adjetivo de singular a plural (simplificado)
% NOTA: Esta es una implementación básica, casos especiales se manejan en DB.pl
%
% Ejemplo:
%   ?- ajustar_adjetivo_numero(pequeno, _, pequenos).
ajustar_adjetivo_numero(AdjSing, _, AdjPlural) :-
    % Si el adjetivo ya está en la base de datos en plural, usarlo
    adjective(AdjPlural, _, _, plural),
    adjective(AdjSing, TraduccionEN, _, singular),
    adjective(AdjPlural, TraduccionEN, _, plural), !.


% =============================================================================
% 5. REORDENAMIENTO DE ADJETIVOS
% =============================================================================

% reordenar_sintagma_nominal_es_a_en(+ListaES, -ListaEN)
% Español: [Art, Sustantivo, Adjetivo] → Inglés: [Art, Adjetivo, Sustantivo]
%
% Ejemplo:
%   ?- reordenar_sintagma_nominal_es_a_en([el, gato, pequeno], Lista).
%   Lista = [the, small, cat].
reordenar_sintagma_nominal_es_a_en([ArtES, SustES, AdjES], [ArtEN, AdjEN, SustEN]) :-
    % 1. Traducir sustantivo (noun(English, Spanish, _, _))
    noun(SustEN, SustES, _, _),
    
    % 2. Traducir artículo con contexto
    traducir_articulo_es_a_en(ArtES, SustEN, ArtEN),
    
    % 3. Traducir adjetivo (adjective(English, Spanish, _, _))
    ( adjective(AdjEN, AdjES, _, _) -> true
    ; adjective(AdjEN, AdjES) ),
    !.

% Sin adjetivo (solo art + sust)
reordenar_sintagma_nominal_es_a_en([ArtES, SustES], [ArtEN, SustEN]) :-
    noun(SustEN, SustES, _, _),
    traducir_articulo_es_a_en(ArtES, SustEN, ArtEN), !.


% reordenar_sintagma_nominal_en_a_es(+ListaEN, -ListaES)
% Inglés: [Art, Adjetivo, Sustantivo] → Español: [Art, Sustantivo, Adjetivo]
%
% Ejemplo:
%   ?- reordenar_sintagma_nominal_en_a_es([the, small, cat], Lista).
%   Lista = [el, gato, pequeno].
reordenar_sintagma_nominal_en_a_es([ArtEN, AdjEN, SustEN], [ArtES, SustES, AdjES]) :-
    % 1. Traducir sustantivo (noun(English, Spanish, _, _))
    noun(SustEN, SustES, _, _),
    
    % 2. Traducir artículo con contexto del sustantivo español
    traducir_articulo_en_a_es(ArtEN, SustES, ArtES),
    
    % 3. Ajustar adjetivo al género del sustantivo español
    ajustar_adjetivo_genero(AdjEN, SustES, AdjES),
    !.

% Sin adjetivo (solo art + sust)
reordenar_sintagma_nominal_en_a_es([ArtEN, SustEN], [ArtES, SustES]) :-
    noun(SustEN, SustES, _, _),
    traducir_articulo_en_a_es(ArtEN, SustES, ArtES), !.


% =============================================================================
% 6. UTILIDADES
% =============================================================================

% obtener_genero_sustantivo(+Sustantivo, -Genero, -Numero)
% Obtiene el género y número de un sustantivo (español o inglés)
obtener_genero_sustantivo(Sust, Genero, Numero) :-
    ( noun(Sust, _, Genero, Numero) -> true  % Es inglés (1er parámetro)
    ; noun(_, Sust, Genero, Numero) ).       % Es español (2do parámetro)


% es_adjetivo_invariable(+Adjetivo)
% Verifica si un adjetivo no cambia con el género
% Un adjetivo es invariable si solo tiene 2 parámetros (English, Spanish)
% y NO tiene definiciones con 4 parámetros (English, Spanish, Gender, Number)
es_adjetivo_invariable(Adj) :-
    % Puede ser español o inglés
    ( adjective(Adj, _) ; adjective(_, Adj) ),
    % Y NO debe tener versión con género
    \+ ( adjective(Adj, _, _, _) ; adjective(_, Adj, _, _) ).
