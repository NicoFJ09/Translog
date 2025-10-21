:- encoding(utf8).
:- consult('../database/DB.pl').
:- consult('sintagmas.pl').
% ===============================================
% TRADUCTOR.PL - Traducción estructurada
% ===============================================

% Traducción de sintagma nominal
traducir_sintagma_nominal(sn(Art, Nom, Adj), LangO, LangD, Traduccion) :-
    traducir_articulo(Art, LangO, LangD, ArtT),
    traducir_nombre(Nom, LangO, LangD, NomT),
    traducir_adjetivo(Adj, LangO, LangD, AdjT),
    build_sn_list(ArtT, NomT, AdjT, Clean),
    reordenar_sn(Clean, LangO, LangD, Traduccion).

% Construcción robusta del sintagma nominal (siempre respeta el orden Art, Nom, Adj)
build_sn_list(Art, Nom, Adj, Clean) :-
    (Art \= none -> A = [Art]; A = []),
    (Nom \= none -> N = [Nom]; N = []),
    (Adj \= none -> D = [Adj]; D = []),
    append(A, N, AN),
    append(AN, D, Clean).

% Traducción de oraciones usando SN
traducir_oracion(Tokens, LangO, LangD, Traduccion) :-
    clasificar_oracion(Tokens, LangO, Estructura),
    traducir_estructura(Estructura, LangO, LangD, Traduccion).

% S + V (intransitivo)
traducir_estructura(oracion(_, s_v, SujSN, V, none, none, none), LangO, LangD, Traduccion) :-
    traducir_sintagma_nominal(SujSN, LangO, LangD, SujT),
    traducir_verbo(V, LangO, LangD, VT),
    append(SujT, [VT], Traduccion).

% S + V + O (transitivo)
traducir_estructura(oracion(_, s_v_o, SujSN, V, ObjSN, none, none), LangO, LangD, Traduccion) :-
    traducir_sintagma_nominal(SujSN, LangO, LangD, SujT),
    traducir_verbo(V, LangO, LangD, VT),
    traducir_sintagma_nominal(ObjSN, LangO, LangD, ObjT),
    append(SujT, [VT|ObjT], Traduccion).

% S + V + C (copulativo)
traducir_estructura(oracion(_, s_v_c, SujSN, V, none, CompSN, none), LangO, LangD, Traduccion) :-
    traducir_sintagma_nominal(SujSN, LangO, LangD, SujT),
    traducir_verbo(V, LangO, LangD, VT),
    traducir_sintagma_nominal(CompSN, LangO, LangD, CompT),
    append(SujT, [VT|CompT], Traduccion).

% S + V + IO + DO (ditransitivo)
traducir_estructura(oracion(_, s_v_io_do, SujSN, V, IOSN, DOSN, none), LangO, LangD, Traduccion) :-
    traducir_sintagma_nominal(SujSN, LangO, LangD, SujT),
    traducir_verbo(V, LangO, LangD, VT),
    traducir_sintagma_nominal(IOSN, LangO, LangD, IOT),
    traducir_sintagma_nominal(DOSN, LangO, LangD, DOT),
    append(SujT, [VT|IOT], Temp),
    append(Temp, DOT, Traduccion).

% S + V + O + C (causativo/nombrar)
traducir_estructura(oracion(_, s_v_o_c, SujSN, V, ObjSN, CompSN, none), LangO, LangD, Traduccion) :-
    traducir_sintagma_nominal(SujSN, LangO, LangD, SujT),
    traducir_verbo(V, LangO, LangD, VT),
    traducir_sintagma_nominal(ObjSN, LangO, LangD, ObjT),
    traducir_sintagma_nominal(CompSN, LangO, LangD, CompT),
    append(SujT, [VT|ObjT], Temp),
    append(Temp, CompT, Traduccion).

% Sintagma nominal
traducir_estructura(sn(Art, Nom, Adj), LangO, LangD, Traduccion) :-
    traducir_sintagma_nominal(sn(Art, Nom, Adj), LangO, LangD, Traduccion).

traducir_estructura(desconocida, _, _, ['[estructura desconocida]']).

% Traducción de cada rol
traducir_articulo(Palabra, spanish, english, Traduccion) :- article(Traduccion, Palabra, _, _), !.
traducir_articulo(Palabra, english, spanish, Traduccion) :- article(Palabra, Traduccion, _, _), !.
traducir_articulo(_, _, _, none).

traducir_nombre(Palabra, spanish, english, Traduccion) :- noun(Traduccion, Palabra, _, _), !.
traducir_nombre(Palabra, english, spanish, Traduccion) :- noun(Palabra, Traduccion, _, _), !.
traducir_nombre(_, _, _, none).

traducir_adjetivo(Palabra, spanish, english, Traduccion) :- adjective(Traduccion, Palabra, _, _), !.
traducir_adjetivo(Palabra, english, spanish, Traduccion) :- adjective(Palabra, Traduccion, _, _), !.
traducir_adjetivo(_, _, _, none).

traducir_verbo(Palabra, spanish, english, Traduccion) :- verb_infinitive(Traduccion, Palabra, _), !.
traducir_verbo(Palabra, english, spanish, Traduccion) :- verb_infinitive(Palabra, Traduccion, _), !.
traducir_verbo(Palabra, _, _, Palabra).

% Reordenamiento para sintagmas nominales
% Español → Inglés: "el gato grande" → "the big cat"
reordenar_sn([Articulo, Nombre, Adjetivo], spanish, english, [Articulo, Adjetivo, Nombre]) :- 
    length([Articulo, Nombre, Adjetivo], 3).
% Español → Inglés: "el gato" → "the cat" (sin cambio)
reordenar_sn([Articulo, Nombre], spanish, english, [Articulo, Nombre]) :- 
    article(Articulo, _, _, _).
% Español → Inglés: "gato grande" → "big cat" (intercambiar)
reordenar_sn([Nombre, Adjetivo], spanish, english, [Adjetivo, Nombre]) :- 
    noun(_, Nombre, _, _).
% Español → Inglés: "gato" → "cat" (sin cambio)
reordenar_sn([Palabra], spanish, english, [Palabra]).

% Inglés → Español: "the big cat" → "el gato grande"
reordenar_sn([Articulo, Adjetivo, Nombre], english, spanish, [Articulo, Nombre, Adjetivo]) :- 
    length([Articulo, Adjetivo, Nombre], 3).
% Inglés → Español: "the cat" → "el gato" (sin cambio)
reordenar_sn([Articulo, Nombre], english, spanish, [Articulo, Nombre]) :- 
    article(Articulo, _, _, _).
% Inglés → Español: "big cat" → "gato grande" (intercambiar)
reordenar_sn([Adjetivo, Nombre], english, spanish, [Nombre, Adjetivo]) :- 
    adjective(Adjetivo, _, _, _).
% Inglés → Español: "cat" → "gato" (sin cambio)
reordenar_sn([Palabra], english, spanish, [Palabra]).

% Por defecto (debe ir al final)
reordenar_sn(Lista, _, _, Lista).