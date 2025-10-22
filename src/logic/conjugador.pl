:- encoding(utf8).
:- consult('../database/DB.pl').
% ===============================================
% CONJUGADOR.PL - Reglas de conjugación
% ===============================================

% =============================================================================
% CONJUGAR ESPAÑOL
% =============================================================================

% Regla 1: Si es irregular, usar irregular_form_spanish
conjugar_espanol(Infinitivo, Persona, Conjugado) :-
    irregular_form_spanish(Conjugado, Infinitivo, Persona, present), !.

% Regla 2: Si NO es irregular, aplicar reglas regulares
conjugar_espanol(Infinitivo, Persona, Conjugado) :-
    verb_infinitive(_, Infinitivo, Tipo),
    aplicar_regla_regular_espanol(Infinitivo, Tipo, Persona, Conjugado).

% Aplicar reglas regulares por tipo (-ar, -er, -ir)
aplicar_regla_regular_espanol(Infinitivo, ar, yo, Conjugado) :-
    termina_en(Infinitivo, ar, Raiz),
    atom_concat(Raiz, o, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ar, tu, Conjugado) :-
    termina_en(Infinitivo, ar, Raiz),
    atom_concat(Raiz, as, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ar, el, Conjugado) :-
    termina_en(Infinitivo, ar, Raiz),
    atom_concat(Raiz, a, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ar, nosotros, Conjugado) :-
    termina_en(Infinitivo, ar, Raiz),
    atom_concat(Raiz, amos, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ar, ellos, Conjugado) :-
    termina_en(Infinitivo, ar, Raiz),
    atom_concat(Raiz, an, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, er, yo, Conjugado) :-
    termina_en(Infinitivo, er, Raiz),
    atom_concat(Raiz, o, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, er, tu, Conjugado) :-
    termina_en(Infinitivo, er, Raiz),
    atom_concat(Raiz, es, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, er, el, Conjugado) :-
    termina_en(Infinitivo, er, Raiz),
    atom_concat(Raiz, e, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, er, nosotros, Conjugado) :-
    termina_en(Infinitivo, er, Raiz),
    atom_concat(Raiz, emos, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, er, ellos, Conjugado) :-
    termina_en(Infinitivo, er, Raiz),
    atom_concat(Raiz, en, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ir, yo, Conjugado) :-
    termina_en(Infinitivo, ir, Raiz),
    atom_concat(Raiz, o, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ir, tu, Conjugado) :-
    termina_en(Infinitivo, ir, Raiz),
    atom_concat(Raiz, es, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ir, el, Conjugado) :-
    termina_en(Infinitivo, ir, Raiz),
    atom_concat(Raiz, e, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ir, nosotros, Conjugado) :-
    termina_en(Infinitivo, ir, Raiz),
    atom_concat(Raiz, imos, Conjugado).

aplicar_regla_regular_espanol(Infinitivo, ir, ellos, Conjugado) :-
    termina_en(Infinitivo, ir, Raiz),
    atom_concat(Raiz, en, Conjugado).

% =============================================================================
% CONJUGAR INGLÉS
% =============================================================================

% Regla 1: Si es irregular, usar irregular_form
conjugar_ingles(Infinitivo, Pronombre, Conjugado) :-
    pronoun(Pronombre, _, CategoriaDB),
    categoria_db_a_conjugacion(CategoriaDB, CategoriaConj),
    irregular_form(Conjugado, Infinitivo, CategoriaConj, present), !.

% Regla 2: Si NO es irregular, aplicar reglas regulares
conjugar_ingles(Infinitivo, Pronombre, Conjugado) :-
    verb_infinitive(Infinitivo, _, _),
    aplicar_regla_regular_ingles(Infinitivo, Pronombre, Conjugado).

% Aplicar reglas regulares de ingles
aplicar_regla_regular_ingles(Infinitivo, Pronombre, Conjugado) :-
    es_tercera_singular(Pronombre),
    agregar_s(Infinitivo, Conjugado).

aplicar_regla_regular_ingles(Infinitivo, Pronombre, Infinitivo) :-
    \+ es_tercera_singular(Pronombre).

% =============================================================================
% LEMATIZAR (obtener infinitivo + persona/pronombre)
% dado un verbo conjugado, obtener infinitivo y persona
% =============================================================================

% para irregulares -español
base_espanol(VerbConjugado, Infinitivo, Persona) :-
    irregular_form_spanish(VerbConjugado, Infinitivo, Persona, present), !.

% para regulares -español
base_espanol(VerbConjugado, Infinitivo, Persona) :-
    identificar_infinitivo_espanol(VerbConjugado, Infinitivo, Persona),
    verb_infinitive(_, Infinitivo, _),
    VerbConjugado \= Infinitivo, !.

% si el infinitivo no está conjugado, agarrar primera persona -español
base_espanol(Infinitivo, Infinitivo, yo) :-
    verb_infinitive(_, Infinitivo, _).

% para irregulares -ingles
base_ingles(VerbConjugado, Infinitivo, Pronombre) :-
    irregular_form(VerbConjugado, Infinitivo, CategoriaConj, present),
    pronoun(Pronombre, _, CategoriaDB),
    categoria_db_a_conjugacion(CategoriaDB, CategoriaConj), !.

% para regulares -ingles (tercera persona singular)
base_ingles(VerbConjugado, Infinitivo, Pronombre) :-
    identificar_infinitivo_ingles(VerbConjugado, Infinitivo, Pronombre),
    verb_infinitive(Infinitivo, _, _),
    es_tercera_singular(Pronombre),
    VerbConjugado \= Infinitivo, !.

% para regulares -ingles (otras personas)
base_ingles(VerbConjugado, Infinitivo, Pronombre) :-
    identificar_infinitivo_ingles(VerbConjugado, Infinitivo, Pronombre),
    verb_infinitive(Infinitivo, _, _),
    \+ es_tercera_singular(Pronombre), !.

% si el infinitivo no está conjugado, agarrar primera persona -ingles
base_ingles(Infinitivo, Infinitivo, i) :-
    verb_infinitive(Infinitivo, _, _).

% =============================================================================
% Funciones extra para identificar los infinitivos
% =============================================================================

% Identificar infinitivo español
identificar_infinitivo_espanol(VerbConjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, VerbConjugado),
    (   atom_concat(Raiz, ar, Infinitivo), verb_infinitive(_, Infinitivo, ar)
    ;   atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er)
    ;   atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir)
    ), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, tu) :-
    (   atom_concat(Raiz, as, VerbConjugado), 
        atom_concat(Raiz, ar, Infinitivo), 
        verb_infinitive(_, Infinitivo, ar)
    ;   atom_concat(Raiz, es, VerbConjugado),
        (   atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er)
        ;   atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir)
        )
    ), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, el) :-
    (   atom_concat(Raiz, a, VerbConjugado),
        atom_concat(Raiz, ar, Infinitivo),
        verb_infinitive(_, Infinitivo, ar)
    ;   atom_concat(Raiz, e, VerbConjugado),
        (   atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er)
        ;   atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir)
        )
    ), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, nosotros) :-
    (   atom_concat(Raiz, amos, VerbConjugado),
        atom_concat(Raiz, ar, Infinitivo),
        verb_infinitive(_, Infinitivo, ar)
    ;   atom_concat(Raiz, emos, VerbConjugado),
        atom_concat(Raiz, er, Infinitivo),
        verb_infinitive(_, Infinitivo, er)
    ;   atom_concat(Raiz, imos, VerbConjugado),
        atom_concat(Raiz, ir, Infinitivo),
        verb_infinitive(_, Infinitivo, ir)
    ), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, an, VerbConjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, en, VerbConjugado),
    (   atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er)
    ;   atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir)
    ), !.

% Identificar infinitivo inglés

% terminación -ies a -y
identificar_infinitivo_ingles(VerbConjugado, Infinitivo, he) :-
    atom_concat(Raiz, ies, VerbConjugado),
    atom_concat(Raiz, y, Infinitivo),
    verb_infinitive(Infinitivo, _, _), !.

% terminación -es
identificar_infinitivo_ingles(VerbConjugado, Infinitivo, he) :-
    atom_concat(Infinitivo, es, VerbConjugado),
    (   termina_en(Infinitivo, s, _)
    ;   termina_en(Infinitivo, sh, _)
    ;   termina_en(Infinitivo, ch, _)
    ;   termina_en(Infinitivo, x, _)
    ;   termina_en(Infinitivo, o, _)
    ),
    verb_infinitive(Infinitivo, _, _), !.

% terminación -s
identificar_infinitivo_ingles(VerbConjugado, Infinitivo, he) :-
    atom_concat(Infinitivo, s, VerbConjugado),
    verb_infinitive(Infinitivo, _, _), !.

identificar_infinitivo_ingles(Infinitivo, Infinitivo, i) :-
    % Caso 4: es el infinitivo base
    verb_infinitive(Infinitivo, _, _).

% =============================================================================
% FUNCIONES AUXILIARES
% =============================================================================

% Extraer raíz quitando terminación
termina_en(Palabra, Sufijo, Raiz) :-
    atom_concat(Raiz, Sufijo, Palabra).

% Verifica directamente los pronombres que son tercera persona
es_tercera_singular(he).
es_tercera_singular(she).
es_tercera_singular(it).

% toma del databa base pronoun a irregular_form. - manera de setear bien la categoria para el uso en conjugacion
categoria_db_a_conjugacion(first_singular, first_singular).
categoria_db_a_conjugacion(second_singular, second_singular).
categoria_db_a_conjugacion(third_singular_masculine, third_singular).
categoria_db_a_conjugacion(third_singular_feminine, third_singular).
categoria_db_a_conjugacion(first_plural, plural).
categoria_db_a_conjugacion(third_plural_masculine, plural).
categoria_db_a_conjugacion(third_plural_feminine, plural).

% Agregar -s o -es
agregar_s(Infinitivo, Conjugado) :-
    termina_en_s_o(Infinitivo),
    atom_concat(Infinitivo, es, Conjugado).

agregar_s(Infinitivo, Conjugado) :-
    \+ termina_en_s_o(Infinitivo),
    atom_concat(Infinitivo, s, Conjugado).

% Verificar si termina en s u o
termina_en_s_o(Palabra) :-
    (termina_en(Palabra, s, _) ; termina_en(Palabra, o, _)).