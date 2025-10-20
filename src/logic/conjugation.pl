:- consult('../database/DB.pl').
:- consult('irregular_verbs.pl').

%----------------------------------------------------------------------------
% VERBOS REGULARES - ESPAÑOL
% elimina terminaciones y concatena nuevas según la persona
%----------------------------------------------------------------------------

% --- VERBOS -AR ---
conjugar_verbo_espanol(Infinitivo, yo, Conjugado) :-
    verb_infinitive(_, Infinitivo, ar), atom_concat(Raiz, ar, Infinitivo), atom_concat(Raiz, o, Conjugado).

conjugar_verbo_espanol(Infinitivo, tu, Conjugado) :-
    verb_infinitive(_, Infinitivo, ar), atom_concat(Raiz, ar, Infinitivo), atom_concat(Raiz, as, Conjugado).

conjugar_verbo_espanol(Infinitivo, el, Conjugado) :-
    verb_infinitive(_, Infinitivo, ar), atom_concat(Raiz, ar, Infinitivo), atom_concat(Raiz, a, Conjugado).

conjugar_verbo_espanol(Infinitivo, nosotros, Conjugado) :-
    verb_infinitive(_, Infinitivo, ar), atom_concat(Raiz, ar, Infinitivo), atom_concat(Raiz, amos, Conjugado).

conjugar_verbo_espanol(Infinitivo, vosotros, Conjugado) :-
    verb_infinitive(_, Infinitivo, ar), atom_concat(Raiz, ar, Infinitivo), atom_concat(Raiz, ais, Conjugado).

conjugar_verbo_espanol(Infinitivo, ellos, Conjugado) :-
    verb_infinitive(_, Infinitivo, ar), atom_concat(Raiz, ar, Infinitivo), atom_concat(Raiz, an, Conjugado).

% --- VERBOS -ER ---

conjugar_verbo_espanol(Infinitivo, yo, Conjugado) :-
    verb_infinitive(_, Infinitivo, er), atom_concat(Raiz, er, Infinitivo), atom_concat(Raiz, o, Conjugado).

conjugar_verbo_espanol(Infinitivo, tu, Conjugado) :-
    verb_infinitive(_, Infinitivo, er), atom_concat(Raiz, er, Infinitivo), atom_concat(Raiz, es, Conjugado).

conjugar_verbo_espanol(Infinitivo, el, Conjugado) :-
    verb_infinitive(_, Infinitivo, er), atom_concat(Raiz, er, Infinitivo), atom_concat(Raiz, e, Conjugado).

conjugar_verbo_espanol(Infinitivo, nosotros, Conjugado) :-
    verb_infinitive(_, Infinitivo, er), atom_concat(Raiz, er, Infinitivo), atom_concat(Raiz, emos, Conjugado).

conjugar_verbo_espanol(Infinitivo, vosotros, Conjugado) :-
    verb_infinitive(_, Infinitivo, er), atom_concat(Raiz, er, Infinitivo), atom_concat(Raiz, eis, Conjugado).

conjugar_verbo_espanol(Infinitivo, ellos, Conjugado) :-
    verb_infinitive(_, Infinitivo, er), atom_concat(Raiz, er, Infinitivo), atom_concat(Raiz, en, Conjugado).


% --- VERBOS -IR ---

conjugar_verbo_espanol(Infinitivo, yo, Conjugado) :-
    verb_infinitive(_, Infinitivo, ir), atom_concat(Raiz, ir, Infinitivo), atom_concat(Raiz, o, Conjugado).

conjugar_verbo_espanol(Infinitivo, tu, Conjugado) :-
    verb_infinitive(_, Infinitivo, ir), atom_concat(Raiz, ir, Infinitivo), atom_concat(Raiz, es, Conjugado).

conjugar_verbo_espanol(Infinitivo, el, Conjugado) :-
    verb_infinitive(_, Infinitivo, ir), atom_concat(Raiz, ir, Infinitivo), atom_concat(Raiz, e, Conjugado).

conjugar_verbo_espanol(Infinitivo, nosotros, Conjugado) :-
    verb_infinitive(_, Infinitivo, ir), atom_concat(Raiz, ir, Infinitivo), atom_concat(Raiz, imos, Conjugado).

conjugar_verbo_espanol(Infinitivo, vosotros, Conjugado) :-
    verb_infinitive(_, Infinitivo, ir), atom_concat(Raiz, ir, Infinitivo), atom_concat(Raiz, is, Conjugado).

conjugar_verbo_espanol(Infinitivo, ellos, Conjugado) :-
    verb_infinitive(_, Infinitivo, ir), atom_concat(Raiz, ir, Infinitivo), atom_concat(Raiz, en, Conjugado).

% ----------------------------------------------------------------------------
% VERBOS REGULARES - INGLES
% elimina terminaciones y concatena nuevas según la persona
% ----------------------------------------------------------------------------

% Primera persona singular (I)
conjugar_verbo_ingles(Infinitivo, i, Infinitivo) :-
    verb_infinitive(Infinitivo, _, _).

% Segunda persona (You)
conjugar_verbo_ingles(Infinitivo, you, Infinitivo) :-
    verb_infinitive(Infinitivo, _, _).

% Primera persona plural (We)
conjugar_verbo_ingles(Infinitivo, we, Infinitivo) :-
    verb_infinitive(Infinitivo, _, _).

% Tercera persona plural (They)
conjugar_verbo_ingles(Infinitivo, they, Infinitivo) :-
    verb_infinitive(Infinitivo, _, _).

% Tercera persona singular (He/She/It) - agrega -s o -es
conjugar_verbo_ingles(Infinitivo, he, Conjugado) :-
    verb_infinitive(Infinitivo, _, _), \+ verb_infinitive(Infinitivo, _, irregular), agregar_s_tercera_persona(Infinitivo, Conjugado).

conjugar_verbo_ingles(Infinitivo, she, Conjugado) :-
    verb_infinitive(Infinitivo, _, _), \+ verb_infinitive(Infinitivo, _, irregular), agregar_s_tercera_persona(Infinitivo, Conjugado).

conjugar_verbo_ingles(Infinitivo, it, Conjugado) :-
    verb_infinitive(Infinitivo, _, _), \+ verb_infinitive(Infinitivo, _, irregular), agregar_s_tercera_persona(Infinitivo, Conjugado).


% CASOS ESPECIALES - REGLAS PARA AGREGAR -S/-ES EN TERCERA PERSONA
% ej: go-goes wash-washes study-studies

% Reglas:
% - Termina en -s, -sh, -ch, -x, -o → añadir -es (go→goes, wash→washes)
% - Termina en consonante+y → cambiar y por -ies (study→studies)
% - Resto → añadir -s (speak→speaks)

agregar_s_tercera_persona(Infinitivo, Conjugado) :-
    % Termina en -s, -sh, -ch, -x, -o
    ( atom_concat(_, s, Infinitivo)
    ; atom_concat(_, sh, Infinitivo)
    ; atom_concat(_, ch, Infinitivo)
    ; atom_concat(_, x, Infinitivo)
    ; atom_concat(_, o, Infinitivo)
    ),
    atom_concat(Infinitivo, es, Conjugado), !.

% para los casos de terminacion de i griega se separa cada una de las partes, verifica terminación antes de agregar -ies

agregar_s_tercera_persona(Infinitivo, Conjugado) :-
    atom_concat(Raiz, y, Infinitivo),
    atom_length(Raiz, Len),
    Len > 0,
    atom_chars(Raiz, Chars),
    last(Chars, UltimaLetra),
    \+ member(UltimaLetra, [a, e, i, o, u]),  % No es vocal
    atom_concat(Raiz, ies, Conjugado), !.

agregar_s_tercera_persona(Infinitivo, Conjugado) :-
    atom_concat(Infinitivo, s, Conjugado).


%----------------------------------------------------------------------------
% Para los verbos irregulares, se trae de irregular_verbs.pl para español
% y DB.pl para inglés
%----------------------------------------------------------------------------

conjugar_irregular_espanol(Infinitivo, Persona, Conjugado) :-
    irregular_form_spanish(Conjugado, Infinitivo, Persona, present).

% para ingles, mapeo de persona a categoria

persona_a_categoria(i, first_singular).
persona_a_categoria(you, second_singular).
persona_a_categoria(you, plural).
persona_a_categoria(he, third_singular).
persona_a_categoria(she, third_singular).
persona_a_categoria(it, third_singular).
persona_a_categoria(we, plural).
persona_a_categoria(they, plural).

conjugar_irregular_ingles(Infinitivo, Persona, Conjugado) :-
    persona_a_categoria(Persona, Categoria),
    irregular_form(Conjugado, Infinitivo, Categoria, present).


% =============================================================================
% CONJUGACIONES COMPLETAS
% =============================================================================
% Unificando todos los tipos de conjugación

% Ejemplos:
%   ?- conjugar(hablar, yo, espanol, V).
%   V = hablo.
%   ?- conjugar(speak, he, ingles, V).
%   V = speaks.
%   ?- conjugar(ser, tu, espanol, V).
%   V = eres.

conjugar(Infinitivo, Persona, espanol, Conjugado) :-
    ( conjugar_irregular_espanol(Infinitivo, Persona, Conjugado) -> true
    ; conjugar_verbo_espanol(Infinitivo, Persona, Conjugado) ).

conjugar(Infinitivo, Persona, ingles, Conjugado) :-
    ( conjugar_irregular_ingles(Infinitivo, Persona, Conjugado) -> true
    ; conjugar_verbo_ingles(Infinitivo, Persona, Conjugado) ).


% =============================================================================
% IDENTIFICAR INFINITIVO- Se hace ahora al reves
% =============================================================================

% Deduce el infinitivo de un verbo conjugado español

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, Persona) :-
    conjugar_irregular_espanol(Infinitivo, Persona, VerbConjugado), !.

% Verbos -AR
identificar_infinitivo_espanol(VerbConjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, VerbConjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, tu) :-
    atom_concat(Raiz, as, VerbConjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, el) :-
    atom_concat(Raiz, a, VerbConjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, nosotros) :-
    atom_concat(Raiz, amos, VerbConjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, vosotros) :-
    atom_concat(Raiz, ais, VerbConjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, an, VerbConjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

% Verbos -ER
identificar_infinitivo_espanol(VerbConjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, VerbConjugado),
    atom_concat(Raiz, er, Infinitivo),
    verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, tu) :-
    atom_concat(Raiz, es, VerbConjugado),
    atom_concat(Raiz, er, Infinitivo),
    verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, el) :-
    atom_concat(Raiz, e, VerbConjugado),
    atom_concat(Raiz, er, Infinitivo),
    verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, nosotros) :-
    atom_concat(Raiz, emos, VerbConjugado),
    atom_concat(Raiz, er, Infinitivo),
    verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, vosotros) :-
    atom_concat(Raiz, eis, VerbConjugado),
    atom_concat(Raiz, er, Infinitivo),
    verb_infinitive(_, Infinitivo, er), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, en, VerbConjugado),
    atom_concat(Raiz, er, Infinitivo),
    verb_infinitive(_, Infinitivo, er), !.

% Verbos -IR
identificar_infinitivo_espanol(VerbConjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, VerbConjugado),
    atom_concat(Raiz, ir, Infinitivo),
    verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, tu) :-
    atom_concat(Raiz, es, VerbConjugado),
    atom_concat(Raiz, ir, Infinitivo),
    verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, el) :-
    atom_concat(Raiz, e, VerbConjugado),
    atom_concat(Raiz, ir, Infinitivo),
    verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, nosotros) :-
    atom_concat(Raiz, imos, VerbConjugado),
    atom_concat(Raiz, ir, Infinitivo),
    verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, vosotros) :-
    atom_concat(Raiz, is, VerbConjugado),
    atom_concat(Raiz, ir, Infinitivo),
    verb_infinitive(_, Infinitivo, ir), !.

identificar_infinitivo_espanol(VerbConjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, en, VerbConjugado),
    atom_concat(Raiz, ir, Infinitivo),
    verb_infinitive(_, Infinitivo, ir), !.

%-----------------------------
% Deduce el infinitivo de un verbo conjugado inglés

identificar_infinitivo_ingles(VerbConjugado, Infinitivo, Persona) :-
    irregular_form(VerbConjugado, Infinitivo, Persona, present), !.

% Si termina en -s, es tercera persona
identificar_infinitivo_ingles(VerbConjugado, Infinitivo, he) :-
    atom_concat(Infinitivo, s, VerbConjugado),
    verb_infinitive(Infinitivo, _, _), !.

identificar_infinitivo_ingles(Infinitivo, Infinitivo, i) :-
    verb_infinitive(Infinitivo, _, _).


% --------------------------------------------------------------------------------
% VALIDACIÓN
% ----------------------------------------------------------------------------

% Verifica si un verbo es regular

es_verbo_regular(Infinitivo, espanol) :-
    verb_infinitive(_, Infinitivo, Tipo),
    member(Tipo, [ar, er, ir]).

es_verbo_regular(Infinitivo, ingles) :-
    verb_infinitive(Infinitivo, _, Tipo),
    Tipo \= irregular.


% Verifica si un verbo es irregular

es_verbo_irregular(Infinitivo, espanol) :-
    member(Infinitivo, [ser, estar, ir, tener, hacer]).

es_verbo_irregular(Infinitivo, ingles) :-
    verb_infinitive(Infinitivo, _, irregular).

% Obtiene el tipo de conjugación de un verbo español

obtener_tipo_verbo(Infinitivo, Tipo) :-
    verb_infinitive(_, Infinitivo, Tipo).


% mapear_persona_pronombre(+Pronombre, -PersonaConjugacion, +Idioma)
% Mapea pronombres a formas de conjugación
%
% Ejemplo:
%   ?- mapear_persona_pronombre(yo, P, espanol).
%   P = yo.

mapear_persona_pronombre(yo, yo, espanol).
mapear_persona_pronombre(tu, tu, espanol).
mapear_persona_pronombre(el, el, espanol).
mapear_persona_pronombre(ella, el, espanol).  % Misma conjugación
mapear_persona_pronombre(usted, el, espanol). % Formal = 3ra persona
mapear_persona_pronombre(nosotros, nosotros, espanol).
mapear_persona_pronombre(vosotros, vosotros, espanol).
mapear_persona_pronombre(ellos, ellos, espanol).
mapear_persona_pronombre(ellas, ellos, espanol).
mapear_persona_pronombre(ustedes, ellos, espanol).

mapear_persona_pronombre(i, i, ingles).
mapear_persona_pronombre(you, you, ingles).
mapear_persona_pronombre(he, he, ingles).
mapear_persona_pronombre(she, she, ingles).
mapear_persona_pronombre(it, it, ingles).
mapear_persona_pronombre(we, we, ingles).
mapear_persona_pronombre(they, they, ingles).


% =============================================================================
% TESTING
% =============================================================================

test_conjugacion_ar :-
    write('Testing -AR verbs...'), nl,
    conjugar_verbo_espanol(hablar, yo, V1),
    write('hablar + yo = '), write(V1), nl,
    conjugar_verbo_espanol(hablar, el, V2),
    write('hablar + el = '), write(V2), nl.

test_conjugacion_ingles :-
    write('Testing English verbs...'), nl,
    conjugar_verbo_ingles(speak, i, V1),
    write('speak + I = '), write(V1), nl,
    conjugar_verbo_ingles(speak, he, V2),
    write('speak + he = '), write(V2), nl.

test_irregulares :-
    write('Testing irregular verbs...'), nl,
    nl,
    % Spanish irregular verbs
    write('Spanish irregular verbs:'), nl,
    write('ser:'), nl,
    conjugar_irregular_espanol(ser, yo, V1),
    write('ser + yo = '), write(V1), nl,
    conjugar_irregular_espanol(ser, tu, V2),
    write('ser + tú = '), write(V2), nl,
    
    write('estar:'), nl,
    conjugar_irregular_espanol(estar, yo, V3),
    write('estar + yo = '), write(V3), nl,
    conjugar_irregular_espanol(estar, el, V4),
    write('estar + él = '), write(V4), nl,
    
    write('ir:'), nl,
    conjugar_irregular_espanol(ir, nosotros, V5),
    write('ir + nosotros = '), write(V5), nl,
    
    nl,
    % English irregular verbs
    write('English irregular verbs:'), nl,
    write('be:'), nl,
    conjugar_irregular_ingles(be, i, V6),
    write('be + I = '), write(V6), nl,
    conjugar_irregular_ingles(be, he, V7),
    write('be + he = '), write(V7), nl,
    
    write('have:'), nl,
    conjugar_irregular_ingles(have, i, V8),
    write('have + I = '), write(V8), nl,
    conjugar_irregular_ingles(have, she, V9),
    write('have + she = '), write(V9), nl,
    
    write('do:'), nl,
    conjugar_irregular_ingles(do, they, V10),
    write('do + they = '), write(V10), nl,
    conjugar_irregular_ingles(do, he, V11),
    write('do + he = '), write(V11), nl,
    
    write('All irregular verb tests completed.'), nl.

run_all_tests :-
    test_conjugacion_ar,
    test_conjugacion_ingles,
    test_irregulares.

% =============================================================================
% FIN DEL MÓDULO
% =============================================================================