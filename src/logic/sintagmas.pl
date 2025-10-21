:- encoding(utf8).
:- consult('../database/DB.pl').
% ===============================================
% SINTAGMAS.PL - Identificar categorías
% ===============================================

% Formato: article(English, Spanish, Gender, Number)
% Solo buscamos en SEGUNDA posición para español
es_determinante(Palabra, spanish) :- article(_, Palabra, _, _).
% Solo buscamos en PRIMERA posición para inglés
es_determinante(Palabra, english) :- article(Palabra, _, _, _).

% Formato: noun(English, Spanish, Gender, Number)
es_nombre(Palabra, spanish) :- noun(_, Palabra, _, _).
es_nombre(Palabra, english) :- noun(Palabra, _, _, _).

% Formato: adjective(English, Spanish, Gender, Number)
es_adjetivo(Palabra, spanish) :- adjective(_, Palabra, _, _).
es_adjetivo(Palabra, english) :- adjective(Palabra, _, _, _).

% Formato: pronoun(English, Spanish, Person)
es_pronombre(Palabra, spanish) :- pronoun(_, Palabra, _).
es_pronombre(Palabra, english) :- pronoun(Palabra, _, _).

% Formato: verb_infinitive(English, Spanish, Type)
es_verbo_infinitivo(Palabra, spanish) :- verb_infinitive(_, Palabra, _).
es_verbo_infinitivo(Palabra, english) :- verb_infinitive(Palabra, _, _).

% Formato: irregular_form(Conjugated, Infinitive, Person, Tense)
es_verbo_conjugado(Palabra, english) :- irregular_form(Palabra, _, _, present).

% Formato: irregular_form_spanish(Conjugated, Infinitive, Person, Tense)
es_verbo_conjugado(Palabra, spanish) :- irregular_form_spanish(Palabra, _, _, present).

% Es verbo si es infinitivo O conjugado
es_verbo(Palabra, Lang) :- es_verbo_infinitivo(Palabra, Lang).
es_verbo(Palabra, Lang) :- es_verbo_conjugado(Palabra, Lang).

% Formato: adverb(English, Spanish)
es_adverbio(Palabra, spanish) :- adverb(_, Palabra).
es_adverbio(Palabra, english) :- adverb(Palabra, _).

% Formato: preposition(English, Spanish)
es_preposicion(Palabra, spanish) :- preposition(_, Palabra).
es_preposicion(Palabra, english) :- preposition(Palabra, _).

% Formato: question_word(English, Spanish)
es_interrogativa(Palabra, spanish) :- question_word(_, Palabra).
es_interrogativa(Palabra, english) :- question_word(Palabra, _).

% Formato: negative(English, Spanish)
es_negacion(Palabra, spanish) :- negative(_, Palabra).
es_negacion(Palabra, english) :- negative(Palabra, _).

% Formato: common_phrase(English, Spanish)
es_frase_comun(Palabra, spanish) :- common_phrase(_, Palabra).
es_frase_comun(Palabra, english) :- common_phrase(Palabra, _).

% Formato: conjunction(English, Spanish)
es_conjuncion(Palabra, spanish) :- conjunction(_, Palabra).
es_conjuncion(Palabra, english) :- conjunction(Palabra, _).

% Formato: auxiliary(Word) - solo inglés
es_auxiliar(Palabra) :- auxiliary(Palabra).