:- encoding(utf8).
:- consult('../database/DB.pl').

% ===============================================
% SINTAGMAS.PL - Detección de Categorías
% ===============================================

es_determinante(Palabra, Lang) :-
    article(_, Palabra, _, _), Lang = spanish, !.

es_determinante(Palabra, Lang) :-
    article(Palabra, _, _, _), Lang = english, !.

es_nombre(Palabra, Lang) :-
    noun(_, Palabra, _, _), Lang = spanish, !.

es_nombre(Palabra, Lang) :-
    noun(Palabra, _, _, _), Lang = english, !.

es_adjetivo(Palabra, Lang) :-
    adjective(_, Palabra, _, _), Lang = spanish, !.

es_adjetivo(Palabra, Lang) :-
    adjective(Palabra, _, _, _), Lang = english, !.

es_pronombre(Palabra, Lang) :-
    pronoun(_, Palabra, _, _), Lang = spanish, !.

es_pronombre(Palabra, Lang) :-
    pronoun(Palabra, _, _, _), Lang = english, !.

es_verbo_infinitivo(Palabra, Lang) :-
    verb_infinitive(_, Palabra, _), Lang = spanish, !.

es_verbo_infinitivo(Palabra, Lang) :-
    verb_infinitive(Palabra, _, _), Lang = english, !.

es_verbo_conjugado(Palabra, spanish) :- 
    irregular_form_spanish(Palabra, _, _, present), !.

es_verbo_conjugado(Palabra, english) :- 
    irregular_form(Palabra, _, _, present), !.

es_verbo_conjugado(Palabra, spanish) :-
    \+ noun(_, Palabra, _, _),
    \+ adjective(_, Palabra, _, _),
    \+ pronoun(_, Palabra, _, _),
    (atom_concat(_, o, Palabra) ;
     atom_concat(_, as, Palabra) ;
     atom_concat(_, a, Palabra) ;
     atom_concat(_, amos, Palabra) ;
     atom_concat(_, an, Palabra) ;
     atom_concat(_, es, Palabra) ;
     atom_concat(_, e, Palabra) ;
     atom_concat(_, emos, Palabra) ;
     atom_concat(_, en, Palabra) ;
     atom_concat(_, imos, Palabra)),
    atom_length(Palabra, L),
    L > 2, !.

es_verbo_conjugado(Palabra, english) :-
    \+ noun(Palabra, _, _, _),
    \+ pronoun(Palabra, _, _, _),
    (atom_concat(Base, s, Palabra) ; atom_concat(Base, es, Palabra)),
    verb_infinitive(Base, _, _),
    !.

es_verbo(Palabra, Lang) :- 
    (es_verbo_infinitivo(Palabra, Lang) ; es_verbo_conjugado(Palabra, Lang)), !.

es_adverbio(Palabra, spanish) :- adverb(_, Palabra), !.
es_adverbio(Palabra, english) :- adverb(Palabra, _), !.

es_preposicion(Palabra, spanish) :- preposition(_, Palabra), !.
es_preposicion(Palabra, english) :- preposition(Palabra, _), !.

es_interrogativa(Palabra, spanish) :- question_word(_, Palabra), !.
es_interrogativa(Palabra, english) :- question_word(Palabra, _), !.

es_negacion(Palabra, spanish) :- negative(_, Palabra), !.
es_negacion(Palabra, english) :- negative(Palabra, _), !.

es_frase_comun(Palabra, spanish) :- common_phrase(_, Palabra), !.
es_frase_comun(Palabra, english) :- common_phrase(Palabra, _), !.

es_conjuncion(Palabra, spanish) :- conjunction(_, Palabra), !.
es_conjuncion(Palabra, english) :- conjunction(Palabra, _), !.

es_auxiliar(do).
es_auxiliar(does).
es_auxiliar(is).
es_auxiliar(are).
es_auxiliar(am).
es_auxiliar(was).
es_auxiliar(were).