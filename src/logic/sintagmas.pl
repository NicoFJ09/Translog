:- encoding(utf8).
:- consult('../database/DB.pl').
% ===============================================
% SINTAGMAS.PL - Identificar categorías y estructuras
% ===============================================

% ----------- IDENTIFICACIÓN DE CATEGORÍAS (VOCABULARIO) -----------

es_determinante(Palabra, Lang) :- (Lang = spanish, article(_, Palabra, _, _)); (Lang = english, article(Palabra, _, _, _)).
es_nombre(Palabra, Lang) :- (Lang = spanish, noun(_, Palabra, _, _)); (Lang = english, noun(Palabra, _, _, _)).
es_adjetivo(Palabra, Lang) :- (Lang = spanish, adjective(_, Palabra, _, _)); (Lang = english, adjective(Palabra, _, _, _)).
es_pronombre(Palabra, Lang) :- (Lang = spanish, pronoun(_, Palabra, _)); (Lang = english, pronoun(Palabra, _, _)).
es_verbo_infinitivo(Palabra, Lang) :- (Lang = spanish, verb_infinitive(_, Palabra, _)); (Lang = english, verb_infinitive(Palabra, _, _)).
es_verbo(Palabra, Lang) :- es_verbo_infinitivo(Palabra, Lang).
es_adverbio(Palabra, Lang) :- (Lang = spanish, adverb(_, Palabra)); (Lang = english, adverb(Palabra, _)).
es_preposicion(Palabra, Lang) :- (Lang = spanish, preposition(_, Palabra)); (Lang = english, preposition(Palabra, _)).
es_interrogativa(Palabra, Lang) :- (Lang = spanish, question_word(_, Palabra)); (Lang = english, question_word(Palabra, _)).
es_negacion(Palabra, Lang) :- (Lang = spanish, negative(_, Palabra)); (Lang = english, negative(Palabra, _)).
es_frase_comun(Palabra, Lang) :- (Lang = spanish, common_phrase(_, Palabra)); (Lang = english, common_phrase(Palabra, _)).
es_conjuncion(Palabra, Lang) :- (Lang = spanish, conjunction(_, Palabra)); (Lang = english, conjunction(Palabra, _)).
es_auxiliar(Palabra) :- auxiliary(Palabra).

% ----------- CLASIFICADOR DE SINTAGMAS NOMINALES -----------

sintagma_nominal([Art, Nom, Adj], Lang, sn(Art, Nom, Adj)) :-
    es_determinante(Art, Lang),
    es_nombre(Nom, Lang),
    es_adjetivo(Adj, Lang).
sintagma_nominal([Art, Nom], Lang, sn(Art, Nom, none)) :-
    es_determinante(Art, Lang),
    es_nombre(Nom, Lang).
sintagma_nominal([Nom, Adj], Lang, sn(none, Nom, Adj)) :-
    es_nombre(Nom, Lang),
    es_adjetivo(Adj, Lang).
sintagma_nominal([Nom], Lang, sn(none, Nom, none)) :-
    es_nombre(Nom, Lang).
sintagma_nominal([Art, Adj, Nom], english, sn(Art, Nom, Adj)) :-
    es_determinante(Art, english),
    es_adjetivo(Adj, english),
    es_nombre(Nom, english).
sintagma_nominal([Adj, Nom], english, sn(none, Nom, Adj)) :-
    es_adjetivo(Adj, english),
    es_nombre(Nom, english).
sintagma_nominal([Art], Lang, sn(Art, none, none)) :-
    es_determinante(Art, Lang).
sintagma_nominal([Adj], Lang, sn(none, none, Adj)) :-
    es_adjetivo(Adj, Lang).

% ----------- CLASIFICADOR DE ORACIONES (LISTAS PLANAS, SOLO AFIRMATIVAS) -----------

% SVC: Sujeto + Verbo copulativo + Complemento
clasificar_oracion(Tokens, Lang, oracion(afirmativa, s_v_c, SujSN, Verbo, none, CompSN, none)) :-
    append(SujTokens, [Verbo|CompTokens], Tokens),
    member(Verbo, [ser, estar, parecer, parecerse, resultar, quedar, mantenerse, volverse, convertirse, hacerse]),
    sintagma_nominal(SujTokens, Lang, SujSN),
    sintagma_nominal(CompTokens, Lang, CompSN).

% SVO: Sujeto + Verbo + Objeto
clasificar_oracion(Tokens, Lang, oracion(afirmativa, s_v_o, SujSN, Verbo, ObjSN, none, none)) :-
    es_verbo(Verbo, Lang),
    append(SujTokens, [Verbo|ObjTokens], Tokens),
    sintagma_nominal(SujTokens, Lang, SujSN),
    sintagma_nominal(ObjTokens, Lang, ObjSN).

% SV: Sujeto + Verbo
clasificar_oracion(Tokens, Lang, oracion(afirmativa, s_v, SujSN, Verbo, none, none, none)) :-
    es_verbo(Verbo, Lang),
    append(SujTokens, [Verbo], Tokens),
    sintagma_nominal(SujTokens, Lang, SujSN).

% SVO+IO+DO: Sujeto + Verbo + IO + DO
clasificar_oracion(Tokens, Lang, oracion(afirmativa, s_v_io_do, SujSN, Verbo, IOSN, DOSN, none)) :-
    es_verbo(Verbo, Lang),
    append(SujTokens, [Verbo|Rest], Tokens),
    sintagma_nominal(SujTokens, Lang, SujSN),
    append(IOTokens, DOTokens, Rest),
    sintagma_nominal(IOTokens, Lang, IOSN),
    sintagma_nominal(DOTokens, Lang, DOSN).

% SVO+C: Sujeto + Verbo + Objeto + Complemento
clasificar_oracion(Tokens, Lang, oracion(afirmativa, s_v_o_c, SujSN, Verbo, ObjSN, CompSN, none)) :-
    es_verbo(Verbo, Lang),
    append(SujTokens, [Verbo|Rest], Tokens),
    sintagma_nominal(SujTokens, Lang, SujSN),
    append(ObjTokens, CompTokens, Rest),
    sintagma_nominal(ObjTokens, Lang, ObjSN),
    sintagma_nominal(CompTokens, Lang, CompSN).

% Sintagma nominal plano
clasificar_oracion(Tokens, Lang, sn(Art, Nom, Adj)) :-
    sintagma_nominal(Tokens, Lang, sn(Art, Nom, Adj)).

% Si no se reconoce, marcar como desconocida
clasificar_oracion(_, _, desconocida).