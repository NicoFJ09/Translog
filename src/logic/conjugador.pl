:- encoding(utf8).
:- consult('../database/DB.pl').

% ===============================================
% CONJUGADOR.PL - Sistema de Conjugación
% ===============================================

% ========== CONJUGAR EN ESPAÑOL ==========
/*
 * Summary: Conjuga un verbo en español según la persona gramatical.
 * Maneja verbos irregulares e irregulares aplicando las reglas correspondientes.
 * @param Infinitivo  - Verbo en forma infinitiva (ej: "hablar", "comer", "vivir")
 * @param Persona     - Persona gramatical (ej: yo, tú, él, ella, nosotros, ellos)
 * @return Conjugado  - Verbo conjugado según persona (ej: "hablo", "comes", "vivimos")
 * 
 * Ejemplos:
 *   ?- conjugar_espanol(hablar, yo, X).
 *   X = hablo
 */

% Los irregulares están en la BD como irregular_form_spanish/4
% El ! (cut) detiene la búsqueda si lo encuentra
conjugar_espanol(Infinitivo, Persona, Conjugado) :-
    irregular_form_spanish(Conjugado, Infinitivo, Persona, present), !.

% Si no es irregular, busca su TIPO (AR, ER, IR)
% verb_infinitive/3 dice si es un verbo válido y qué tipo tiene
% Luego aplica las reglas de conjugación regular para ese tipo
conjugar_espanol(Infinitivo, Persona, Conjugado) :-
    verb_infinitive(_, Infinitivo, Tipo),
    conjugar_regular_espanol(Infinitivo, Tipo, Persona, Conjugado).

% ========== REGLAS PARA VERBOS -AR (HABLAR, COMER, VIVIR) ==========
/**
 * Summary: Aplica las reglas de conjugación regular según el tipo de verbo (AR, ER, IR)
 * y la persona gramatical. Extrae la raíz del infinitivo y añade la terminación correcta.
 * 
 * @param Infinitivo  - Verbo en forma infinitiva (ej: "hablar")
 * @param Tipo        - Tipo de verbo: ar, er, ir
 * @param Persona     - Persona gramatical (yo, tú, él, ella, nosotros, ellos)
 * @return Conjugado  - Verbo conjugado (ej: "hablo", "hablas", "habla", etc)
 */
% atom_concat junta/separa strings. "atom_concat(X, ar, hablar)" extrae la raíz

% hablar → yo → hablo (raíz + o)
conjugar_regular_espanol(Infinitivo, ar, yo, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, o, Conjugado).

% hablar → tú → hablas (raíz + as)
conjugar_regular_espanol(Infinitivo, ar, tu, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, as, Conjugado).

% hablar → él/ella → habla (raíz + a)
conjugar_regular_espanol(Infinitivo, ar, el, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, a, Conjugado).

% hablar → ella → habla (igual que él, el español es así)
conjugar_regular_espanol(Infinitivo, ar, ella, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, a, Conjugado).

% hablar → nosotros → hablamos (raíz + amos)
conjugar_regular_espanol(Infinitivo, ar, nosotros, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, amos, Conjugado).

% hablar → ellos → hablan (raíz + an)
conjugar_regular_espanol(Infinitivo, ar, ellos, Conjugado) :-
    atom_concat(Raiz, ar, Infinitivo),
    atom_concat(Raiz, an, Conjugado).

% ========== REGLAS PARA VERBOS -ER (COMER, BEBER, etc) ==========

% comer → yo → como (raíz + o)
conjugar_regular_espanol(Infinitivo, er, yo, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, o, Conjugado).

% comer → tú → comes (raíz + es)
conjugar_regular_espanol(Infinitivo, er, tu, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, es, Conjugado).

% comer → él/ella → come (raíz + e)
conjugar_regular_espanol(Infinitivo, er, el, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, e, Conjugado).

% comer → ella → come
conjugar_regular_espanol(Infinitivo, er, ella, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, e, Conjugado).

% comer → nosotros → comemos (raíz + emos)
conjugar_regular_espanol(Infinitivo, er, nosotros, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, emos, Conjugado).

% comer → ellos → comen (raíz + en)
conjugar_regular_espanol(Infinitivo, er, ellos, Conjugado) :-
    atom_concat(Raiz, er, Infinitivo),
    atom_concat(Raiz, en, Conjugado).

% ========== REGLAS PARA VERBOS -IR (VIVIR, PARTIR, etc) ==========

% vivir → yo → vivo (raíz + o)
conjugar_regular_espanol(Infinitivo, ir, yo, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, o, Conjugado).

% vivir → tú → vives (raíz + es)
conjugar_regular_espanol(Infinitivo, ir, tu, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, es, Conjugado).

% vivir → él/ella → vive (raíz + e)
conjugar_regular_espanol(Infinitivo, ir, el, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, e, Conjugado).

% vivir → ella → vive
conjugar_regular_espanol(Infinitivo, ir, ella, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, e, Conjugado).

% vivir → nosotros → vivimos (raíz + imos) - NOTA: distinto a AR y ER
conjugar_regular_espanol(Infinitivo, ir, nosotros, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, imos, Conjugado).

% vivir → ellos → viven (raíz + en)
conjugar_regular_espanol(Infinitivo, ir, ellos, Conjugado) :-
    atom_concat(Raiz, ir, Infinitivo),
    atom_concat(Raiz, en, Conjugado).

% ========== CONJUGAR EN INGLÉS ==========
/**
 * Summary: Conjuga un verbo en inglés según el pronombre.
 * En inglés, solo la 3ª persona singular lleva cambio (-s o -es).
 * Las demás personas usan el infinitivo directo.
 * 
 * @param Infinitivo  - Verbo en forma infinitiva (ej: "eat", "go", "be")
 * @param Pronombre   - Pronombre (i, you, he, she, we, they)
 * @return Conjugado  - Verbo conjugado (ej: "eats" para he, "eat" para I)
 * 
 * Ej:
 *   ?- conjugar_ingles(eat, he, X).
 *   X = eats.
 */
conjugar_ingles(Infinitivo, Pronombre, Conjugado) :-
    pronoun(Pronombre, _, Categoria, _),
    categoria_a_persona_inglesa(Categoria, Persona),
    irregular_form(Conjugado, Infinitivo, Persona, present), !.

% SEGUNDO INTENTO: Si es REGULAR
% En inglés solo la 3ª persona singular lleva cambio (he/she eats)
% El resto usa el infinitivo directo (I eat, you eat, we eat)
conjugar_ingles(Infinitivo, Pronombre, Conjugado) :-
    verb_infinitive(Infinitivo, _, _),
    pronoun(Pronombre, _, Categoria, _),
    (es_tercera_persona_singular(Categoria) ->
        agregar_s_ingles(Infinitivo, Conjugado)
    ;
        Conjugado = Infinitivo
    ).

% Agregar "s" o "es" en 3 persona singular inglés si termina en: s, sh, ch, x, o → agregar "es"
% Sino agregar "s"
% Ejemplos: kiss -kisses, go - goes, eat - eats
/**
 * Summary: Agrega "s" o "es" al verbo para la 3ª persona singular en inglés.
 * Aplica reglas ortográficas especiales: si termina en s, sh, ch, x, o → agrega "es"
 * 
 * @param Verbo       - Verbo en infinitivo (ej: "eat", "kiss", "go")
 * @return Conjugado  - Verbo con terminación agregada (ej: "eats", "kisses", "goes")
 * 
 * Ejemplos:
 *   ?- agregar_s_ingles(eat, X).
 *   X = eats.
 */
agregar_s_ingles(Verbo, Conjugado) :-
    (atom_concat(_, s, Verbo) ; atom_concat(_, sh, Verbo) ; 
     atom_concat(_, ch, Verbo) ; atom_concat(_, x, Verbo) ; 
     atom_concat(_, o, Verbo)) ->
    atom_concat(Verbo, es, Conjugado)
    ;
    atom_concat(Verbo, s, Conjugado).

lematizar_espanol(Conjugado, Infinitivo, Persona) :-
    irregular_form_spanish(Conjugado, Infinitivo, Persona, present), !.

% PASO 2: Si es REGULAR, identifica la persona por el sufijo
% identificar_persona_espanol/3 mira terminaciones (-o, -as, -a, etc)
% y deduce qué persona es
lematizar_espanol(Conjugado, Infinitivo, Persona) :-
    identificar_persona_espanol(Conjugado, Infinitivo, Persona),
    verb_infinitive(_, Infinitivo, _), !.

% PASO 3: Si todo falla, asumir que es infinitivo en 1ª persona
% (fallback: si no reconoce nada, devuelve el mismo como infinitivo)
lematizar_espanol(Infinitivo, Infinitivo, yo) :-
    verb_infinitive(_, Infinitivo, _).

% ========== LEMATIZAR EN INGLÉS (INVERSO: conjugado → infinitivo) ==========
/**
 * Summary: Convierte un verbo conjugado al infinitivo e identifica el pronombre.
 * Busca primero formas irregulares, luego remueve la "s" o "es" de verbos regulares.
 * 
 * @param Conjugado   - Verbo conjugado (ej: "eats", "goes", "has")
 * @return Infinitivo - Verbo en forma infinitiva (ej: "eat", "go", "have")
 * @return Pronombre  - Pronombre asociado (i, you, he, we, they)
 * 
 * Ejemplos:
 *   ?- lematizar_ingles(eats, X, Y).
 *   X = eat, Y = he
 */

% PASO 1: ¿Es forma IRREGULAR?
lematizar_ingles(Conjugado, Infinitivo, Pronombre) :-
    irregular_form(Conjugado, Infinitivo, Persona, present),
    persona_inglesa_a_pronombre(Persona, Pronombre), !.

% PASO 2: Si es REGULAR, quita la "s" o "es" (ej: eats -eat)
% Luego asume que es 3ª persona singular (he)
lematizar_ingles(Conjugado, Infinitivo, he) :-
    quitar_s_ingles(Conjugado, Infinitivo),
    verb_infinitive(Infinitivo, _, _), !.

% PASO 3: Si no se puede quitar "s", asumir que es infinitivo en 1ª persona
lematizar_ingles(Infinitivo, Infinitivo, i) :-
    verb_infinitive(Infinitivo, _, _).

% ========== IDENTIFICAR PERSONA EN ESPAÑOL (por sufijo) ==========
/**
 * Summary: Identifica la persona gramatical analizando la terminación del verbo.
 * Comprueba si es válido contra la BD y deduce infinitivo y persona.
 * 
 * @param Conjugado   - Verbo conjugado (ej: "hablo", "hablas", "hablamos")
 * @return Infinitivo - Verbo en infinitivo (ej: "hablar")
 * @return Persona    - Persona identificada (yo, tú, él, ella, nosotros, ellos)
 * 
 * Análisis por terminación:
 *   -o-yo        (hablo, como, vivo)
 *   -as/-es -tú        (hablas, comes, vives)
 *   -a/-e  -él/ella   (habla, come, vive)
 *   -amos/-emos/-imos → nosotros
 *   -an/-en  → ellos     (hablan, comen, viven)
 */

% Si termina en "o" → es 1ª singular (yo)
% hablo = habl + o → infinitivo es hablar → persona es yo
identificar_persona_espanol(Conjugado, Infinitivo, yo) :-
    atom_concat(Raiz, o, Conjugado),
    (atom_concat(Raiz, ar, Infinitivo), verb_infinitive(_, Infinitivo, ar) ;
     atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er) ;
     atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir)), !.

% Si termina en "as" (verbo -AR) o "es" (verbo -ER/-IR) → es 2ª singular (tú)
% hablas = habl + as → infinitivo hablar → persona tú
% comes = com + es → infinitivo comer → persona tú
identificar_persona_espanol(Conjugado, Infinitivo, tu) :-
    (atom_concat(Raiz, as, Conjugado),
     atom_concat(Raiz, ar, Infinitivo),
     verb_infinitive(_, Infinitivo, ar)) ;
    (atom_concat(Raiz, es, Conjugado),
     (atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er) ;
      atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir))), !.

% Si termina en "a" (-AR) o "e" (-ER/-IR) → es 3ª singular (él/ella)
% habla = habl + a → infinitivo hablar → persona él
% come = com + e → infinitivo comer → persona él
identificar_persona_espanol(Conjugado, Infinitivo, el) :-
    (atom_concat(Raiz, a, Conjugado),
     atom_concat(Raiz, ar, Infinitivo),
     verb_infinitive(_, Infinitivo, ar)) ;
    (atom_concat(Raiz, e, Conjugado),
     (atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er) ;
      atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir))), !.

% Si termina en "amos" (-AR), "emos" (-ER), o "imos" (-IR) → es 1ª plural (nosotros)
% hablamos = habl + amos → infinitivo hablar → persona nosotros
% comemos = com + emos → infinitivo comer → persona nosotros
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

% Si termina en "an" (-AR) → es 3ª plural (ellos)
% hablan = habl + an → infinitivo hablar → persona ellos
identificar_persona_espanol(Conjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, an, Conjugado),
    atom_concat(Raiz, ar, Infinitivo),
    verb_infinitive(_, Infinitivo, ar), !.

% Si termina en "en" (-ER/-IR) → es 3ª plural (ellos)
% comen = com + en → infinitivo comer → persona ellos
% viven = viv + en → infinitivo vivir → persona ellos
identificar_persona_espanol(Conjugado, Infinitivo, ellos) :-
    atom_concat(Raiz, en, Conjugado),
    (atom_concat(Raiz, er, Infinitivo), verb_infinitive(_, Infinitivo, er) ;
     atom_concat(Raiz, ir, Infinitivo), verb_infinitive(_, Infinitivo, ir)), !.

% ========== QUITAR "S" EN INGLÉS (inverso de agregar_s) ==========
/**
 * Summary: Remueve la "s" o "es" agregada en 3ª persona singular.
 * Aplica reglas inversas: si terminación es "es", quita "es"; sino quita "s"
 * 
 * @param Conjugado   - Verbo conjugado (ej: "eats", "kisses", "goes")
 * @return Infinitivo - Verbo en infinitivo (ej: "eat", "kiss", "go")
 * 
 * Ejemplos:
 *   ?- quitar_s_ingles(eats, X).
 *   X = eat.
 */
quitar_s_ingles(Conjugado, Infinitivo) :-
    atom_concat(Infinitivo, es, Conjugado),
    (atom_concat(_, s, Infinitivo) ; atom_concat(_, sh, Infinitivo) ;
     atom_concat(_, ch, Infinitivo) ; atom_concat(_, x, Infinitivo) ;
     atom_concat(_, o, Infinitivo)), !.

quitar_s_ingles(Conjugado, Infinitivo) :-
    atom_concat(Infinitivo, s, Conjugado), !.

% ========== TABLAS DE CONVERSIÓN: Categoría → Persona ==========
/**
 * Summary: Mapea categorías lingüísticas a personas gramaticales en español.
 * Las categorías vienen de los pronombres en la BD y se usan para normalizar
 * la conversión entre idiomas.
 * 
 * @param Categoria   - Categoría del pronombre (first_singular, third_singular_masculine, etc)
 * @return Persona    - Persona en español (yo, tú, él, ella, nosotros, ellos)
 * 
 * Mapeo:
 *   first_singular                → yo
 *   second_singular               → tú
 *   third_singular_masculine      → él
 *   third_singular_feminine       → ella
 *   first_plural                  → nosotros
 *   third_plural_masculine        → ellos
 *   third_plural_feminine         → ellos
 */

% Español: Las categorías mapean directo a personas
categoria_a_persona_espanola(first_singular, yo).
categoria_a_persona_espanola(second_singular, tu).
categoria_a_persona_espanola(third_singular_masculine, el).
categoria_a_persona_espanola(third_singular_feminine, ella).
categoria_a_persona_espanola(first_plural, nosotros).
categoria_a_persona_espanola(third_plural_masculine, ellos).
categoria_a_persona_espanola(third_plural_feminine, ellos).

/**
 * Summary: Mapea categorías lingüísticas a personas gramaticales EN INGLÉS.
 * Importante: EN INGLÉS NO hay distinción de género en conjugación.
 * he eats = she eats (mismo verbo)
 * 
 * @param Categoria   - Categoría del pronombre (first_singular, third_singular_masculine, etc)
 * @return Persona    - Persona en inglés (first_singular, third_singular, plural)
 * 
 * Mapeo:
 *   first_singular                → first_singular
 *   second_singular               → second_singular
 *   third_singular_masculine      → third_singular
 *   third_singular_feminine       → third_singular  (¡igual!)
 *   first_plural                  → plural
 *   third_plural_masculine        → plural
 *   third_plural_feminine         → plural
 */
categoria_a_persona_inglesa(first_singular, first_singular).
categoria_a_persona_inglesa(second_singular, second_singular).
categoria_a_persona_inglesa(third_singular_masculine, third_singular).
categoria_a_persona_inglesa(third_singular_feminine, third_singular).
categoria_a_persona_inglesa(first_plural, plural).
categoria_a_persona_inglesa(third_plural_masculine, plural).
categoria_a_persona_inglesa(third_plural_feminine, plural).

% Inverso: Persona ingles - pronombre
% Se usa al lematizar (pasar de conjugado a infinitivo)
/**
 * persona_inglesa_a_pronombre(?Persona, ?Pronombre)
 * 
 * Summary: Mapea personas gramaticales en inglés a sus pronombres correspondientes.
 * Se usa al lematizar para asociar el verbo conjugado con su pronombre.
 * 
 * @param Persona     - Persona en inglés (first_singular, third_singular, plural)
 * @return Pronombre  - Pronombre en inglés (i, you, he, we)
 * 
 * Mapeo:
 *   first_singular   → i
 *   second_singular  → you
 *   third_singular   → he
 *   plural           → we
 */
persona_inglesa_a_pronombre(first_singular, i).
persona_inglesa_a_pronombre(second_singular, you).
persona_inglesa_a_pronombre(third_singular, he).
persona_inglesa_a_pronombre(plural, we).

% HELPER: Identifica si una categoría es 3ª persona singular
% Necesario porque solo 3ª singular lleva "s" en inglés
/**
 * es_tercera_persona_singular(?Categoria)
 * 
 * Summary: Verifica si una categoría corresponde a 3ª persona singular.
 * Solo en 3ª singular se agrega "s" al verbo en inglés.
 * 
 * @param Categoria   - Categoría a verificar (third_singular_masculine, third_singular_feminine)
 * @return true/false - Verdadero si es 3ª singular, falso en caso contrario
 * 
 * Uso: En conjugar_ingles/3 para decidir si agregar "s" o no.
 */
es_tercera_persona_singular(third_singular_masculine).
es_tercera_persona_singular(third_singular_feminine).