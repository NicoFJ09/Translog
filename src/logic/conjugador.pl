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
    irregular_form_spanish(Conjugado, Infinitivo, Persona, present).

% Regla 2: Si NO es irregular, aplicar reglas regulares
conjugar_espanol(Infinitivo, Persona, Conjugado) :-
    \+ irregular_form_spanish(_, Infinitivo, _, present),
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
    pronombre_a_categoria(Pronombre, Categoria),
    irregular_form(Conjugado, Infinitivo, Categoria, present).

% Regla 2: Si NO es irregular, aplicar reglas regulares
conjugar_ingles(Infinitivo, Pronombre, Conjugado) :-
    verb_infinitive(Infinitivo, _, _),
    \+ (pronombre_a_categoria(Pronombre, Cat), irregular_form(_, Infinitivo, Cat, present)),
    aplicar_regla_regular_ingles(Infinitivo, Pronombre, Conjugado).

% Aplicar reglas regulares inglesas
aplicar_regla_regular_ingles(Infinitivo, Pronombre, Conjugado) :-
    es_tercera_singular(Pronombre),
    agregar_s(Infinitivo, Conjugado).

aplicar_regla_regular_ingles(Infinitivo, Pronombre, Infinitivo) :-
    \+ es_tercera_singular(Pronombre).

% =============================================================================
% FUNCIONES AUXILIARES
% =============================================================================

% Extraer raíz quitando terminación
termina_en(Palabra, Sufijo, Raiz) :-
    atom_concat(Raiz, Sufijo, Palabra).
    
% Mapear pronombres ingleses a categorías
pronombre_a_categoria(i, first_singular).
pronombre_a_categoria(you, second_singular).
pronombre_a_categoria(he, third_singular).
pronombre_a_categoria(she, third_singular).
pronombre_a_categoria(it, third_singular).
pronombre_a_categoria(we, plural).
pronombre_a_categoria(they, plural).

% Verificar tercera persona singular
es_tercera_singular(he).
es_tercera_singular(she).
es_tercera_singular(it).

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

% =============================================================================
% IDENTIFICAR INFINITIVO (inverso)
% =============================================================================

% Identificar infinitivo español: comprobar irregulares primero
identificar_infinitivo_espanol(VerbConjugado, Infinitivo, Persona) :-
    irregular_form_spanish(VerbConjugado, Infinitivo, Persona, present), !.

% Verbos -AR
identificar_infinitivo_espanol(VerbConjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, VerbConjugado), atom_concat(Raiz, ar, Infinitivo), verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, tu) :-
    atom_concat(Raiz, as, VerbConjugado), atom_concat(Raiz, ar, Infinitivo), verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, el) :-
    atom_concat(Raiz, a, VerbConjugado), atom_concat(Raiz, ar, Infinitivo), verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, nosotros) :-
    atom_concat(Raiz, amos, VerbConjugado), atom_concat(Raiz, ar, Infinitivo), verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, an, VerbConjugado), atom_concat(Raiz, ar, Infinitivo), verb_infinitive(_, Infinitivo, ar), !.

% Verbos -ER
identificar_infinitivo_espanol(VerbConjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, VerbConjugado), atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, tu) :-
    atom_concat(Raiz, es, VerbConjugado), atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, el) :-
    atom_concat(Raiz, e, VerbConjugado), atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, nosotros) :-
    atom_concat(Raiz, emos, VerbConjugado), atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, en, VerbConjugado), atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er), !.

% Verbos -IR
identificar_infinitivo_espanol(VerbConjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, VerbConjugado), atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, tu) :-
    atom_concat(Raiz, es, VerbConjugado), atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, el) :-
    atom_concat(Raiz, e, VerbConjugado), atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, nosotros) :-
    atom_concat(Raiz, imos, VerbConjugado), atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, en, VerbConjugado), atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir), !.

% -----------------------------
% Identificar infinitivo inglés
% comprobar irregulares primero (usa categorías en DB)
identificar_infinitivo_ingles(VerbConjugado, Infinitivo, Persona) :-
    irregular_form(VerbConjugado, Infinitivo, Categoria, present),
    categoria_a_pronombre(Categoria, Persona), !.

% termina en -ies -> raiz + y
identificar_infinitivo_ingles(VerbConjugado, Infinitivo, he) :-
    atom_concat(Raiz, ies, VerbConjugado), atom_concat(Raiz, y, Infinitivo), verb_infinitive(Infinitivo, _, _), !.

% termina en -es para casos especiales (s, sh, ch, x, o)
identificar_infinitivo_ingles(VerbConjugado, Infinitivo, he) :-
    atom_concat(Infinitivo, es, VerbConjugado),
    ( termina_en(Infinitivo, s, _)
    ; termina_en(Infinitivo, sh, _)
    ; termina_en(Infinitivo, ch, _)
    ; termina_en(Infinitivo, x, _)
    ; termina_en(Infinitivo, o, _)
    ),
    verb_infinitive(Infinitivo, _, _), !.

% termina en -s (caso general)
identificar_infinitivo_ingles(VerbConjugado, Infinitivo, he) :-
    atom_concat(Infinitivo, s, VerbConjugado), verb_infinitive(Infinitivo, _, _), !.

% Si ya es infinitivo (no 3ª pers.), devolver como I
identificar_infinitivo_ingles(Infinitivo, Infinitivo, i) :-
    verb_infinitive(Infinitivo, _, _).

% Mapeo inverso de categorías a pronombres (simple representante)
categoria_a_pronombre(first_singular, i).
categoria_a_pronombre(second_singular, you).
categoria_a_pronombre(third_singular, he).
categoria_a_pronombre(plural, they).
