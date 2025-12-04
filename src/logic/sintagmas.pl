:- encoding(utf8).
:- consult('../database/DB.pl').

% ===============================================
% SINTAGMAS.PL - Detección de Categorías
% ===============================================

/*
 * es_determinante(+Palabra, +Lang, -Result)
 * 
 * Summary: Verifica si una palabra es un artículo o determinante en el idioma especificado.
 * Busca la palabra en la base de datos de artículos según el idioma.
 * 
 * @param Palabra   - Palabra a verificar (ej: "el", "la", "the", "a")
 * @param Lang      - Idioma (spanish, english)
 * @return true/false - Verdadero si es determinante, falso en caso contrario
 * 
 * Ejemplos:
 *   ?- es_determinante(el, spanish).
 *   true.
 *   
 *   ?- es_determinante(the, english).
 *   true.
 */
es_determinante(Palabra, Lang) :-
    article(_, Palabra, _, _), Lang = spanish, !.

es_determinante(Palabra, Lang) :-
    article(Palabra, _, _, _), Lang = english, !.

/*
 * es_nombre(+Palabra, +Lang, -Result)
 * 
 * Summary: Verifica si una palabra es un sustantivo en el idioma especificado.
 * 
 * @param Palabra   - Palabra a verificar (ej: "gato", "casa", "cat", "house")
 * @param Lang      - Idioma (spanish, english)
 * @return true/false - Verdadero si es sustantivo
 * 
 * Ejemplos:
 *   ?- es_nombre(gato, spanish).
 *   true.
 */
es_nombre(Palabra, Lang) :-
    noun(_, Palabra, _, _), Lang = spanish, !.

es_nombre(Palabra, Lang) :-
    noun(Palabra, _, _, _), Lang = english, !.

/*
 * es_adjetivo(+Palabra, +Lang, -Result)
 * 
 * Summary: Verifica si una palabra es un adjetivo en el idioma especificado.
 * 
 * @param Palabra   - Palabra a verificar (ej: "grande", "bonito", "big", "pretty")
 * @param Lang      - Idioma (spanish, english)
 * @return true/false - Verdadero si es adjetivo
 * 
 * Ejemplos:
 *   ?- es_adjetivo(grande, spanish).
 *   true.
 */
es_adjetivo(Palabra, Lang) :-
    adjective(_, Palabra, _, _), Lang = spanish, !.

es_adjetivo(Palabra, Lang) :-
    adjective(Palabra, _, _, _), Lang = english, !.

/*
 * es_pronombre(+Palabra, +Lang, -Result)
 * 
 * Summary: Verifica si una palabra es un pronombre en el idioma especificado.
 * 
 * @param Palabra   - Palabra a verificar (ej: "yo", "él", "ella", "i", "he", "she")
 * @param Lang      - Idioma (spanish, english)
 * @return true/false - Verdadero si es pronombre
 * 
 * Ejemplos:
 *   ?- es_pronombre(yo, spanish).
 *   true.
 */
es_pronombre(Palabra, Lang) :-
    pronoun(_, Palabra, _, _), Lang = spanish, !.

es_pronombre(Palabra, Lang) :-
    pronoun(Palabra, _, _, _), Lang = english, !.

/*
 * es_verbo_infinitivo(+Palabra, +Lang, -Result)
 * 
 * Summary: Verifica si una palabra es un verbo en forma infinitiva.
 * 
 * @param Palabra   - Palabra a verificar (ej: "hablar", "comer", "eat", "go")
 * @param Lang      - Idioma (spanish, english)
 * @return true/false - Verdadero si es infinitivo
 * 
 * Ejemplos:
 *   ?- es_verbo_infinitivo(hablar, spanish).
 *   true.
 */
es_verbo_infinitivo(Palabra, Lang) :-
    verb_infinitive(_, Palabra, _), Lang = spanish, !.

es_verbo_infinitivo(Palabra, Lang) :-
    verb_infinitive(Palabra, _, _), Lang = english, !.

/*
 * es_verbo_conjugado(+Palabra, +Lang, -Result)
 * 
 * Summary: Verifica si una palabra es un verbo en forma conjugada (pasada, presente, etc).
 * Maneja tanto verbos irregulares como regulares.
 * 
 * @param Palabra   - Palabra a verificar (ej: "hablo", "comes", "hablan", "eats", "went")
 * @param Lang      - Idioma (spanish, english)
 * @return true/false - Verdadero si es verbo conjugado
 * 
 * Ejemplos:
 *   ?- es_verbo_conjugado(hablo, spanish).
 *   true.
 *   
 *   ?- es_verbo_conjugado(eats, english).
 *   true.
 */
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

/*
 * es_verbo(+Palabra, +Lang, -Result)
 * 
 * Summary: Verifica si una palabra es un verbo (infinitivo o conjugado).
 * 
 * @param Palabra   - Palabra a verificar
 * @param Lang      - Idioma (spanish, english)
 * @return true/false - Verdadero si es verbo
 * 
 * Ejemplos:
 *   ?- es_verbo(hablar, spanish).
 *   true.
 *   
 *   ?- es_verbo(hablo, spanish).
 *   true.
 */
es_verbo(Palabra, Lang) :- 
    (es_verbo_infinitivo(Palabra, Lang) ; es_verbo_conjugado(Palabra, Lang)), !.

% Otros verificadores de categorías

/*
 * es_adverbio(+Palabra, +Lang, -Result)
 * Summary: Verifica si una palabra es un adverbio (ej: "siempre", "nunca", "rápido")
 */
es_adverbio(Palabra, spanish) :- adverb(_, Palabra), !.
es_adverbio(Palabra, english) :- adverb(Palabra, _), !.

/*
 * es_preposicion(+Palabra, +Lang, -Result)
 * Summary: Verifica si una palabra es una preposición (ej: "en", "a", "in", "at")
 */
es_preposicion(Palabra, spanish) :- preposition(_, Palabra), !.
es_preposicion(Palabra, english) :- preposition(Palabra, _), !.

/*
 * es_interrogativa(+Palabra, +Lang, -Result)
 * Summary: Verifica si una palabra es una palabra interrogativa (ej: "qué", "dónde", "what", "where")
 */
es_interrogativa(Palabra, spanish) :- question_word(_, Palabra), !.
es_interrogativa(Palabra, english) :- question_word(Palabra, _), !.

/*
 * es_negacion(+Palabra, +Lang, -Result)
 * Summary: Verifica si una palabra es una negación (ej: "no", "not")
 */
es_negacion(Palabra, spanish) :- negative(_, Palabra), !.
es_negacion(Palabra, english) :- negative(Palabra, _), !.

/*
 * es_frase_comun(+Palabra, +Lang, -Result)
 * Summary: Verifica si una palabra es una frase común o expresión (ej: "buenos días", "good morning")
 */
es_frase_comun(Palabra, spanish) :- common_phrase(_, Palabra), !.
es_frase_comun(Palabra, english) :- common_phrase(Palabra, _), !.

/*
 * es_conjuncion(+Palabra, +Lang, -Result)
 * Summary: Verifica si una palabra es una conjunción (ej: "y", "o", "and", "or")
 */
es_conjuncion(Palabra, spanish) :- conjunction(_, Palabra), !.
es_conjuncion(Palabra, english) :- conjunction(Palabra, _), !.

/*
 * es_auxiliar(+Palabra, -Result)
 * 
 * Summary: Verifica si una palabra es un verbo auxiliar en inglés.
 * Los auxiliares se usan para formar preguntas, negaciones y tiempos verbales.
 * 
 * @param Palabra - Verbo a verificar (do, does, is, are, am, was, were)
 * @return true/false - Verdadero si es auxiliar
 * 
 * Ejemplos:
 *   ?- es_auxiliar(is).
 *   true.
 *   
 *   ?- es_auxiliar(does).
 *   true.
 */
es_auxiliar(do).
es_auxiliar(does).
es_auxiliar(is).
es_auxiliar(are).
es_auxiliar(am).
es_auxiliar(was).
es_auxiliar(were).