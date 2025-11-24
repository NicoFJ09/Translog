:- encoding(utf8).
:- consult('../database/DB.pl').

% ===============================================
% CONJUGADOR.PL - Sistema de Conjugación
% ===============================================

conjugar_espanol(Infinitivo, Persona, Conjugado) :-
    irregular_form_spanish(Conjugado, Infinitivo, Persona, present), !.

conjugar_espanol(Infinitivo, Persona, Conjugado) :-
    verb_infinitive(_, Infinitivo, Tipo),
    conjugar_regular_espanol(Infinitivo, Tipo, Persona, Conjugado).

conjugar_regular_espanol(Infinitivo, ar, yo, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, o, Conjugado).

conjugar_regular_espanol(Infinitivo, ar, tu, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, as, Conjugado).

conjugar_regular_espanol(Infinitivo, ar, el, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, a, Conjugado).

conjugar_regular_espanol(Infinitivo, ar, ella, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, a, Conjugado).

conjugar_regular_espanol(Infinitivo, ar, nosotros, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, amos, Conjugado).

conjugar_regular_espanol(Infinitivo, ar, ellos, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, an, Conjugado).

conjugar_regular_espanol(Infinitivo, er, yo, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, o, Conjugado).

conjugar_regular_espanol(Infinitivo, er, tu, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, es, Conjugado).

conjugar_regular_espanol(Infinitivo, er, el, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, e, Conjugado).

conjugar_regular_espanol(Infinitivo, er, ella, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, e, Conjugado).

conjugar_regular_espanol(Infinitivo, er, nosotros, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, emos, Conjugado).

conjugar_regular_espanol(Infinitivo, er, ellos, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, en, Conjugado).

conjugar_regular_espanol(Infinitivo, ir, yo, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, o, Conjugado).

conjugar_regular_espanol(Infinitivo, ir, tu, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, es, Conjugado).

conjugar_regular_espanol(Infinitivo, ir, el, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, e, Conjugado).

conjugar_regular_espanol(Infinitivo, ir, ella, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, e, Conjugado).

conjugar_regular_espanol(Infinitivo, ir, nosotros, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, imos, Conjugado).

conjugar_regular_espanol(Infinitivo, ir, ellos, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, en, Conjugado).

conjugar_ingles(Infinitivo, Pronombre, Conjugado) :-
    pronoun(Pronombre, _, Categoria, _),
    categoria_a_persona_inglesa(Categoria, Persona),
    irregular_form(Conjugado, Infinitivo, Persona, present), !.

conjugar_ingles(Infinitivo, Pronombre, Conjugado) :-
    verb_infinitive(Infinitivo, _, _),
    pronoun(Pronombre, _, Categoria, _),
    (es_tercera_persona_singular(Categoria) ->
        agregar_s_ingles(Infinitivo, Conjugado)
    ;
        Conjugado = Infinitivo
    ).

agregar_s_ingles(Verbo, Conjugado) :-
    (atom_concat(_, s, Verbo) ; atom_concat(_, sh, Verbo) ; 
     atom_concat(_, ch, Verbo) ; atom_concat(_, x, Verbo) ; 
     atom_concat(_, o, Verbo)) ->
    atom_concat(Verbo, es, Conjugado)
    ;
    atom_concat(Verbo, s, Conjugado).

lematizar_espanol(Conjugado, Infinitivo, Persona) :-
    irregular_form_spanish(Conjugado, Infinitivo, Persona, present), !.

lematizar_espanol(Conjugado, Infinitivo, Persona) :-
    identificar_persona_espanol(Conjugado, Infinitivo, Persona),
    verb_infinitive(_, Infinitivo, _), !.

lematizar_espanol(Infinitivo, Infinitivo, yo) :-
    verb_infinitive(_, Infinitivo, _).

lematizar_ingles(Conjugado, Infinitivo, Pronombre) :-
    irregular_form(Conjugado, Infinitivo, Persona, present),
    persona_inglesa_a_pronombre(Persona, Pronombre), !.

lematizar_ingles(Conjugado, Infinitivo, he) :-
    quitar_s_ingles(Conjugado, Infinitivo),
    verb_infinitive(Infinitivo, _, _), !.

lematizar_ingles(Infinitivo, Infinitivo, i) :-
    verb_infinitive(Infinitivo, _, _).

identificar_persona_espanol(Conjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, Conjugado),
    (atom_concat(Raiz, ar, Infinitivo), verb_infinitive(_, Infinitivo, ar) ;
     atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er) ;
     atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir)), !.

identificar_persona_espanol(Conjugado, Infinitivo, tu) :-
    (atom_concat(Raiz, as, Conjugado),
     atom_concat(Raiz, ar, Infinitivo),
     verb_infinitive(_, Infinitivo, ar)) ;
    (atom_concat(Raiz, es, Conjugado),
     (atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er) ;
      atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir))), !.

identificar_persona_espanol(Conjugado, Infinitivo, el) :-
    (atom_concat(Raiz, a, Conjugado),
     atom_concat(Raiz, ar, Infinitivo),
     verb_infinitive(_, Infinitivo, ar)) ;
    (atom_concat(Raiz, e, Conjugado),
     (atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er) ;
      atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir))), !.

identificar_persona_espanol(Conjugado, Infinitivo, nosotros) :-
    (atom_concat(Raiz, amos, Conjugado),
     atom_concat(Raiz, ar, Infinitivo),
     verb_infinitive(_, Infinitivo, ar)) ;
    (atom_concat(Raiz, emos, Conjugado),
     atom_concat(Raiz, er, Infinitivo),
     verb_infinitive(_, Infinitivo, er)) ;
    (atom_concat(Raiz, imos, Conjugado),
     atom_concat(Raiz, ir, Infinitivo),
     verb_infinitive(_, Infinitivo, ir)), !.

identificar_persona_espanol(Conjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, an, Conjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

identificar_persona_espanol(Conjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, en, Conjugado),
    (atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er) ;
     atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir)), !.

quitar_s_ingles(Conjugado, Infinitivo) :-
    atom_concat(Infinitivo, es, Conjugado),
    (atom_concat(_, s, Infinitivo) ; atom_concat(_, sh, Infinitivo) ;
     atom_concat(_, ch, Infinitivo) ; atom_concat(_, x, Infinitivo) ;
     atom_concat(_, o, Infinitivo)), !.

quitar_s_ingles(Conjugado, Infinitivo) :-
    atom_concat(Infinitivo, s, Conjugado), !.

categoria_a_persona_espanola(first_singular, yo).
categoria_a_persona_espanola(second_singular, tu).
categoria_a_persona_espanola(third_singular_masculine, el).
categoria_a_persona_espanola(third_singular_feminine, ella).
categoria_a_persona_espanola(first_plural, nosotros).
categoria_a_persona_espanola(third_plural_masculine, ellos).
categoria_a_persona_espanola(third_plural_feminine, ellos).

categoria_a_persona_inglesa(first_singular, first_singular).
categoria_a_persona_inglesa(second_singular, second_singular).
categoria_a_persona_inglesa(third_singular_masculine, third_singular).
categoria_a_persona_inglesa(third_singular_feminine, third_singular).
categoria_a_persona_inglesa(first_plural, plural).
categoria_a_persona_inglesa(third_plural_masculine, plural).
categoria_a_persona_inglesa(third_plural_feminine, plural).

persona_inglesa_a_pronombre(first_singular, i).
persona_inglesa_a_pronombre(second_singular, you).
persona_inglesa_a_pronombre(third_singular, he).
persona_inglesa_a_pronombre(plural, we).

es_tercera_persona_singular(third_singular_masculine).
es_tercera_persona_singular(third_singular_feminine).