:- encoding(utf8).
:- consult('../database/DB.pl').
:- consult('./conjugador.pl').
:- consult('./sintagmas.pl').

% ===============================================
% TRADUCTOR.PL - Sistema de Traducción
% ===============================================

% =============================================================================
% TRADUCIR UNA PALABRA
% =============================================================================

traducir_palabra(Palabra, spanish, english, Traduccion) :-
    (pronoun(Traduccion, Palabra, _, 1) -> true
    ; possessive_adjective(Traduccion, Palabra, _) -> true
    ; common_phrase(Traduccion, Palabra) -> true
    ; adverb(Traduccion, Palabra) -> true
    ; preposition(Traduccion, Palabra) -> true
    ; conjunction(Traduccion, Palabra) -> true
    ; negative(Traduccion, Palabra) -> true
    ; number_word(Traduccion, Palabra) -> true
    ; article(Traduccion, Palabra, _, _) -> true
    ; noun(Traduccion, Palabra, _, _) -> true
    ; adjective(Traduccion, Palabra, _, _) -> true
    ; traducir_verbo(Palabra, spanish, english, Traduccion) -> true
    ; Traduccion = Palabra
    ), !.

traducir_palabra(Palabra, english, spanish, Traduccion) :-
    (pronoun(Palabra, Traduccion, _, 1) -> true
    ; possessive_adjective(Palabra, Traduccion, _) -> true
    ; common_phrase(Palabra, Traduccion) -> true
    ; adverb(Palabra, Traduccion) -> true
    ; preposition(Palabra, Traduccion) -> true
    ; conjunction(Palabra, Traduccion) -> true
    ; negative(Palabra, Traduccion) -> true
    ; number_word(Palabra, Traduccion) -> true
    ; article(Palabra, Traduccion, _, _) -> true
    ; noun(Palabra, Traduccion, _, _) -> true
    ; adjective(Palabra, Traduccion, _, _) -> true
    ; traducir_verbo(Palabra, english, spanish, Traduccion) -> true
    ; Traduccion = Palabra
    ), !.

% =============================================================================
% TRADUCIR VERBO
% =============================================================================

traducir_verbo(VerbEspanol, spanish, english, VerbIngles) :-
    lematizar_espanol(VerbEspanol, InfEspanol, PersonaEsp),
    traducir_infinitivo(InfEspanol, spanish, english, InfIngles),
    persona_espanola_a_pronombre(PersonaEsp, Pronombre),
    conjugar_ingles(InfIngles, Pronombre, VerbIngles),
    !.

traducir_verbo(VerbIngles, english, spanish, VerbEspanol) :-
    lematizar_ingles(VerbIngles, InfIngles, _),
    traducir_infinitivo(InfIngles, english, spanish, InfEspanol),
    VerbEspanol = InfEspanol,
    !.

traducir_verbo(Verbo, _, _, Verbo).

traducir_verbo_con_contexto(VerbIngles, Pronombre, english, spanish, VerbEspanol) :-
    verb_infinitive(VerbIngles, InfEspanol, _),
    !,
    pronombre_a_persona_espanola(Pronombre, PersonaEsp),
    conjugar_espanol(InfEspanol, PersonaEsp, VerbEspanol).

traducir_verbo_con_contexto(VerbIngles, Pronombre, english, spanish, VerbEspanol) :-
    quitar_s_ingles(VerbIngles, InfIngles),
    verb_infinitive(InfIngles, InfEspanol, _),
    !,
    pronombre_a_persona_espanola(Pronombre, PersonaEsp),
    conjugar_espanol(InfEspanol, PersonaEsp, VerbEspanol).

traducir_verbo_con_contexto(VerbIngles, Pronombre, english, spanish, VerbEspanol) :-
    pronoun(Pronombre, _, Categoria, _),
    categoria_a_persona_inglesa(Categoria, Persona),
    irregular_form(VerbIngles, InfIngles, Persona, present),
    traducir_infinitivo(InfIngles, english, spanish, InfEspanol),
    pronombre_a_persona_espanola(Pronombre, PersonaEsp),
    conjugar_espanol(InfEspanol, PersonaEsp, VerbEspanol),
    !.

traducir_verbo_con_contexto(Verbo, _, _, _, Verbo).

% =============================================================================
% TRADUCIR INFINITIVO
% =============================================================================

traducir_infinitivo(InfEspanol, spanish, english, InfIngles) :-
    (irregular_verb_pair(InfEspanol, InfIngles) -> true
    ; verb_infinitive(InfIngles, InfEspanol, _) -> true
    ; InfIngles = InfEspanol
    ), !.

traducir_infinitivo(InfIngles, english, spanish, InfEspanol) :-
    (irregular_verb_pair(InfEspanol, InfIngles) -> true
    ; verb_infinitive(InfIngles, InfEspanol, _) -> true
    ; InfEspanol = InfIngles
    ), !.

% =============================================================================
% MAPEO PERSONA ↔ PRONOMBRE
% =============================================================================

persona_espanola_a_pronombre(yo, i).
persona_espanola_a_pronombre(tu, you).
persona_espanola_a_pronombre(el, he).
persona_espanola_a_pronombre(ella, she).
persona_espanola_a_pronombre(nosotros, we).
persona_espanola_a_pronombre(ellos, they).
persona_espanola_a_pronombre(ellas, they).

pronombre_a_persona_espanola(i, yo).
pronombre_a_persona_espanola(you, tu).
pronombre_a_persona_espanola(he, el).
pronombre_a_persona_espanola(she, ella).
pronombre_a_persona_espanola(it, el).
pronombre_a_persona_espanola(we, nosotros).
pronombre_a_persona_espanola(they, ellos).

% =============================================================================
% TRADUCIR LISTA DE PALABRAS
% =============================================================================

traducir_lista([], _, _, []).

traducir_lista([Palabra|Resto], LangOrigen, LangDestino, [Traducida|RestoTrad]) :-
    traducir_palabra(Palabra, LangOrigen, LangDestino, Traducida),
    traducir_lista(Resto, LangOrigen, LangDestino, RestoTrad).

% =============================================================================
% TRADUCIR ORACIONES
% =============================================================================

traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    es_interrogativa_oracion(Tokens, LangOrigen),
    !,
    traducir_interrogativa(Tokens, LangOrigen, LangDestino, Traduccion).

traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    detectar_sujeto_verbo(Tokens, LangOrigen, Sujeto, Verbo, Resto),
    !,
    traducir_sujeto(Sujeto, LangOrigen, LangDestino, SujetoTrad),
    (LangOrigen = english, LangDestino = spanish ->
        extraer_pronombre_de_sujeto(Sujeto, LangOrigen, PronombreOrigen),
        (tiene_contexto_ser_estar(Resto, english) ->
            obtener_primer_contexto(Resto, Contexto),
            traducir_verbo_be_con_contexto(Verbo, Contexto, PronombreOrigen, VerboTrad)
        ;
            traducir_verbo_con_contexto(Verbo, PronombreOrigen, english, spanish, VerboTrad)
        )
    ;
        traducir_palabra(Verbo, LangOrigen, LangDestino, VerboTrad)
    ),
    traducir_complemento(Resto, LangOrigen, LangDestino, ComplementoTrad),
    % Special handling for frequency adverbs: in English->Spanish, move before verb
    (LangOrigen = english, LangDestino = spanish,
     ComplementoTrad = [PrimerToken|RestoComp],
     member(PrimerToken, [siempre, nunca, ahora, hoy]) ->  % Frequency/time adverbs only
        append(SujetoTrad, [PrimerToken, VerboTrad|RestoComp], Traduccion)
    ;
        append(SujetoTrad, [VerboTrad|ComplementoTrad], Traduccion)
    ).

traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    es_sintagma_nominal(Tokens, LangOrigen),
    !,
    traducir_sintagma_nominal(Tokens, LangOrigen, LangDestino, Traduccion).

traducir_oracion(Tokens, LangOrigen, LangDestino, Traduccion) :-
    traducir_lista(Tokens, LangOrigen, LangDestino, Traduccion).

% =============================================================================
% TRADUCIR BE CON CONTEXTO
% =============================================================================

% Helper: Check if rest has preposition or adjective context (check first 4 tokens, skip adverbs)
tiene_contexto_ser_estar([Token|_], Lang) :-
    (es_preposicion(Token, Lang) ; es_adjetivo(Token, Lang)), !.
tiene_contexto_ser_estar([Adv, Token|_], Lang) :-
    es_adverbio(Adv, Lang),
    (es_preposicion(Token, Lang) ; es_adjetivo(Token, Lang)), !.
tiene_contexto_ser_estar([_, Token|_], Lang) :-
    (es_preposicion(Token, Lang) ; es_adjetivo(Token, Lang)), !.
tiene_contexto_ser_estar([_, _, Token|_], Lang) :-
    (es_preposicion(Token, Lang) ; es_adjetivo(Token, Lang)), !.
tiene_contexto_ser_estar([_, _, _, Token|_], Lang) :-
    (es_preposicion(Token, Lang) ; es_adjetivo(Token, Lang)), !.
tiene_contexto_ser_estar(_, _) :- fail.

% Helper: Get first preposition or adjective from list (skip adverbs like "very")
obtener_primer_contexto([Token|_], Token) :-
    (es_preposicion(Token, english) ; es_adjetivo(Token, english)), !.
obtener_primer_contexto([Adv, Token|_], Token) :-
    es_adverbio(Adv, english),
    (es_preposicion(Token, english) ; es_adjetivo(Token, english)), !.
obtener_primer_contexto([_, Token|_], Token) :-
    (es_preposicion(Token, english) ; es_adjetivo(Token, english)), !.
obtener_primer_contexto([_, _, Token|_], Token) :-
    (es_preposicion(Token, english) ; es_adjetivo(Token, english)), !.
obtener_primer_contexto([_, _, _, Token|_], Token) :-
    (es_preposicion(Token, english) ; es_adjetivo(Token, english)), !.
obtener_primer_contexto(_, _) :- fail.

traducir_verbo_be_con_contexto(Verbo, Contexto, Pronombre, VerboEspanol) :-
    irregular_form(Verbo, be, _, present),
    !,
    (member(Contexto, [in, at, on]) ->
        InfEspanol = estar
    ;
        (es_adjetivo(Contexto, english), adjective(Contexto, ContextoEsp, _, _),
         member(ContextoEsp, [cansado, cansada])) ->
        InfEspanol = estar
    ;
        InfEspanol = ser
    ),
    pronombre_a_persona_espanola(Pronombre, PersonaEsp),
    conjugar_espanol(InfEspanol, PersonaEsp, VerboEspanol).

traducir_verbo_be_con_contexto(Verbo, _, Pronombre, VerboEspanol) :-
    traducir_verbo_con_contexto(Verbo, Pronombre, english, spanish, VerboEspanol).

% =============================================================================
% DETECTAR SUJETO + VERBO
% =============================================================================

% Check more specific patterns first (with adjectives)
detectar_sujeto_verbo([Art, Adj, Noun, Verbo|Resto], english, [Art, Adj, Noun], Verbo, Resto) :-
    es_determinante(Art, english),
    es_adjetivo(Adj, english),
    es_nombre(Noun, english),
    es_verbo(Verbo, english), !.

detectar_sujeto_verbo([Art, Noun, Adj, Verbo|Resto], spanish, [Art, Noun, Adj], Verbo, Resto) :-
    es_determinante(Art, spanish),
    es_nombre(Noun, spanish),
    es_adjetivo(Adj, spanish),
    es_verbo(Verbo, spanish), !.

% Then check article + noun patterns
detectar_sujeto_verbo([Art, Noun, Verbo|Resto], Lang, [Art, Noun], Verbo, Resto) :-
    es_determinante(Art, Lang),
    es_nombre(Noun, Lang),
    es_verbo(Verbo, Lang), !.

% Pattern: Pronoun + Adverb + Verb (e.g., "i always eat")
detectar_sujeto_verbo([Pronombre, Adv, Verbo|Resto], Lang, [Pronombre], Verbo, [Adv|Resto]) :-
    es_pronombre(Pronombre, Lang),
    es_adverbio(Adv, Lang),
    es_verbo(Verbo, Lang), !.

% Finally check pronoun patterns (most general)
detectar_sujeto_verbo([Pronombre, Verbo|Resto], Lang, [Pronombre], Verbo, Resto) :-
    es_pronombre(Pronombre, Lang),
    es_verbo(Verbo, Lang), !.

% =============================================================================
% EXTRAER PRONOMBRE DEL SUJETO
% =============================================================================

extraer_pronombre_de_sujeto([Pronombre], Lang, Pronombre) :-
    es_pronombre(Pronombre, Lang), !.

extraer_pronombre_de_sujeto([_|_], spanish, el) :- !.
extraer_pronombre_de_sujeto([_|_], english, it) :- !.
extraer_pronombre_de_sujeto(_, _, i).

% =============================================================================
% TRADUCIR SUJETO
% =============================================================================

traducir_sujeto([Pronombre], LangOrigen, LangDestino, [PronTrad]) :-
    es_pronombre(Pronombre, LangOrigen),
    traducir_palabra(Pronombre, LangOrigen, LangDestino, PronTrad), !.

traducir_sujeto([Art, Noun], LangOrigen, LangDestino, [ArtTrad, NounTrad]) :-
    traducir_con_genero(Art, Noun, LangOrigen, LangDestino, ArtTrad, NounTrad), !.

traducir_sujeto([Art, Noun, Adj], spanish, english, [ArtTrad, AdjTrad, NounTrad]) :-
    traducir_con_genero(Art, Noun, spanish, english, ArtTrad, NounTrad),
    traducir_palabra(Adj, spanish, english, AdjTrad), !.

traducir_sujeto([Art, Adj, Noun], english, spanish, [ArtTrad, NounTrad, AdjTrad]) :-
    traducir_con_genero(Art, Noun, english, spanish, ArtTrad, NounTrad),
    traducir_adjetivo_con_genero(Adj, NounTrad, english, spanish, AdjTrad), !.

traducir_sujeto(Sujeto, LangOrigen, LangDestino, SujetoTrad) :-
    traducir_lista(Sujeto, LangOrigen, LangDestino, SujetoTrad).

% =============================================================================
% TRADUCIR COMPLEMENTO
% =============================================================================

traducir_complemento([], _, _, []).

% Pattern: Adverb + Adjective (English -> Spanish) - e.g., "very intelligent"
traducir_complemento([Adv, Adj|Resto], english, spanish, Traduccion) :-
    es_adverbio(Adv, english),
    es_adjetivo(Adj, english),
    !,
    traducir_palabra(Adv, english, spanish, AdvTrad),
    traducir_palabra(Adj, english, spanish, AdjTrad),
    traducir_complemento(Resto, english, spanish, RestoTrad),
    append([AdvTrad, AdjTrad], RestoTrad, Traduccion).

% Pattern: Adverb + Adjective (Spanish -> English) - e.g., "muy cansado"
traducir_complemento([Adv, Adj|Resto], spanish, english, Traduccion) :-
    es_adverbio(Adv, spanish),
    es_adjetivo(Adj, spanish),
    !,
    traducir_palabra(Adv, spanish, english, AdvTrad),
    traducir_palabra(Adj, spanish, english, AdjTrad),
    traducir_complemento(Resto, spanish, english, RestoTrad),
    append([AdvTrad, AdjTrad], RestoTrad, Traduccion).

% Pattern: Adverb + Adjective + Adverb (English -> Spanish) - e.g., "very tired today"
traducir_complemento([Adv1, Adj, Adv2|Resto], english, spanish, Traduccion) :-
    es_adverbio(Adv1, english),
    es_adjetivo(Adj, english),
    es_adverbio(Adv2, english),
    !,
    traducir_palabra(Adv1, english, spanish, Adv1Trad),
    traducir_palabra(Adj, english, spanish, AdjTrad),
    traducir_palabra(Adv2, english, spanish, Adv2Trad),
    traducir_complemento(Resto, english, spanish, RestoTrad),
    append([Adv1Trad, AdjTrad, Adv2Trad], RestoTrad, Traduccion).

% Pattern: Prep + Art + Adj + Noun (English -> Spanish)
traducir_complemento([Prep, Art, Adj, Noun|Resto], english, spanish, Traduccion) :-
    es_preposicion(Prep, english),
    es_determinante(Art, english),
    es_adjetivo(Adj, english),
    es_nombre(Noun, english),
    !,
    traducir_palabra(Prep, english, spanish, PrepTrad),
    traducir_con_genero(Art, Noun, english, spanish, ArtTrad, NounTrad),
    traducir_adjetivo_con_genero(Adj, NounTrad, english, spanish, AdjTrad),
    traducir_complemento(Resto, english, spanish, RestoTrad),
    append([PrepTrad, ArtTrad, NounTrad, AdjTrad], RestoTrad, Traduccion).

% Pattern: Prep + Art + Noun + Adj (Spanish -> English)
traducir_complemento([Prep, Art, Noun, Adj|Resto], spanish, english, Traduccion) :-
    es_preposicion(Prep, spanish),
    es_determinante(Art, spanish),
    es_nombre(Noun, spanish),
    es_adjetivo(Adj, spanish),
    !,
    traducir_palabra(Prep, spanish, english, PrepTrad),
    traducir_con_genero(Art, Noun, spanish, english, ArtTrad, NounTrad),
    traducir_palabra(Adj, spanish, english, AdjTrad),
    traducir_complemento(Resto, spanish, english, RestoTrad),
    append([PrepTrad, ArtTrad, AdjTrad, NounTrad], RestoTrad, Traduccion).

% Pattern: Adj + Noun (without article, English -> Spanish)
traducir_complemento([Adj, Noun|Resto], english, spanish, Traduccion) :-
    es_adjetivo(Adj, english),
    es_nombre(Noun, english),
    \+ es_determinante(Adj, english),
    !,
    traducir_palabra(Noun, english, spanish, NounTrad),
    traducir_adjetivo_con_genero(Adj, NounTrad, english, spanish, AdjTrad),
    traducir_complemento(Resto, english, spanish, RestoTrad),
    append([NounTrad, AdjTrad], RestoTrad, Traduccion).

% Pattern: Noun + Adj (without article, Spanish -> English)
traducir_complemento([Noun, Adj|Resto], spanish, english, Traduccion) :-
    es_nombre(Noun, spanish),
    es_adjetivo(Adj, spanish),
    \+ es_determinante(Noun, spanish),
    !,
    traducir_palabra(Noun, spanish, english, NounTrad),
    traducir_palabra(Adj, spanish, english, AdjTrad),
    traducir_complemento(Resto, spanish, english, RestoTrad),
    append([AdjTrad, NounTrad], RestoTrad, Traduccion).

% Pattern: Art + Noun + Adj (Spanish -> English) - e.g., "un libro viejo"
traducir_complemento([Art, Noun, Adj|Resto], spanish, english, Traduccion) :-
    es_determinante(Art, spanish),
    es_nombre(Noun, spanish),
    es_adjetivo(Adj, spanish),
    !,
    traducir_con_genero(Art, Noun, spanish, english, ArtTrad, NounTrad),
    traducir_palabra(Adj, spanish, english, AdjTrad),
    traducir_complemento(Resto, spanish, english, RestoTrad),
    append([ArtTrad, AdjTrad, NounTrad], RestoTrad, Traduccion).

% Pattern: Art + Adj + Noun (English -> Spanish) - e.g., "a new book"
traducir_complemento([Art, Adj, Noun|Resto], english, spanish, Traduccion) :-
    es_determinante(Art, english),
    es_adjetivo(Adj, english),
    es_nombre(Noun, english),
    !,
    traducir_con_genero(Art, Noun, english, spanish, ArtTrad, NounTrad),
    traducir_adjetivo_con_genero(Adj, NounTrad, english, spanish, AdjTrad),
    traducir_complemento(Resto, english, spanish, RestoTrad),
    append([ArtTrad, NounTrad, AdjTrad], RestoTrad, Traduccion).

% Pattern: Possessive + Noun (Spanish -> English) - e.g., "tu amigo" -> "your friend"
traducir_complemento([Pos, Noun|Resto], spanish, english, Traduccion) :-
    possessive_adjective(PosTrad, Pos, _),
    es_nombre(Noun, spanish),
    !,
    traducir_palabra(Noun, spanish, english, NounTrad),
    traducir_complemento(Resto, spanish, english, RestoTrad),
    append([PosTrad, NounTrad], RestoTrad, Traduccion).

% Pattern: Possessive + Noun (English -> Spanish) - e.g., "your friend" -> "tu amigo"
traducir_complemento([Pos, Noun|Resto], english, spanish, Traduccion) :-
    possessive_adjective(Pos, PosTrad, _),
    es_nombre(Noun, english),
    !,
    traducir_palabra(Noun, english, spanish, NounTrad),
    traducir_complemento(Resto, english, spanish, RestoTrad),
    append([PosTrad, NounTrad], RestoTrad, Traduccion).

% Pattern: Single Adjective (English -> Spanish) - e.g., "happy", "tired"
% Must come AFTER Adj+Noun patterns to avoid matching too early
traducir_complemento([Adj|Resto], english, spanish, Traduccion) :-
    es_adjetivo(Adj, english),
    \+ es_nombre(Adj, english),  % Make sure it's not also a noun
    !,
    traducir_palabra(Adj, english, spanish, AdjTrad),
    traducir_complemento(Resto, english, spanish, RestoTrad),
    append([AdjTrad], RestoTrad, Traduccion).

% Pattern: Single Adjective (Spanish -> English) - e.g., "feliz", "cansado"
% Must come AFTER Noun+Adj patterns to avoid matching too early
traducir_complemento([Adj|Resto], spanish, english, Traduccion) :-
    es_adjetivo(Adj, spanish),
    \+ es_nombre(Adj, spanish),  % Make sure it's not also a noun
    !,
    traducir_palabra(Adj, spanish, english, AdjTrad),
    traducir_complemento(Resto, spanish, english, RestoTrad),
    append([AdjTrad], RestoTrad, Traduccion).

% Pattern: Preposition + Article + Noun (preserve gender agreement)
traducir_complemento([Prep, Art, Noun|Resto], LangOrigen, LangDestino, Traduccion) :-
    es_preposicion(Prep, LangOrigen),
    es_determinante(Art, LangOrigen),
    es_nombre(Noun, LangOrigen),
    !,
    traducir_palabra(Prep, LangOrigen, LangDestino, PrepTrad),
    traducir_con_genero(Art, Noun, LangOrigen, LangDestino, ArtTrad, NounTrad),
    traducir_complemento(Resto, LangOrigen, LangDestino, RestoTrad),
    append([PrepTrad, ArtTrad, NounTrad], RestoTrad, Traduccion).

% Pattern: Preposition + Noun WITHOUT article (English to Spanish - add article)
traducir_complemento([Prep, Noun|Resto], english, spanish, Traduccion) :-
    es_preposicion(Prep, english),
    es_nombre(Noun, english),
    !,
    traducir_palabra(Prep, english, spanish, PrepTrad),
    % Get noun with proper article
    noun(Noun, NounTrad, Genero, Numero),
    article(the, ArtTrad, Genero, Numero),
    traducir_complemento(Resto, english, spanish, RestoTrad),
    append([PrepTrad, ArtTrad, NounTrad], RestoTrad, Traduccion).

% Pattern: Single noun (base case for recursion)
traducir_complemento([Noun|Resto], LangOrigen, LangDestino, Traduccion) :-
    es_nombre(Noun, LangOrigen),
    \+ es_determinante(Noun, LangOrigen),
    !,
    traducir_palabra(Noun, LangOrigen, LangDestino, NounTrad),
    traducir_complemento(Resto, LangOrigen, LangDestino, RestoTrad),
    append([NounTrad], RestoTrad, Traduccion).

% Default: check if it's a noun phrase, otherwise translate word by word
traducir_complemento(Tokens, LangOrigen, LangDestino, Traduccion) :-
    (es_sintagma_nominal(Tokens, LangOrigen) ->
        traducir_sintagma_nominal(Tokens, LangOrigen, LangDestino, Traduccion)
    ;
        traducir_lista(Tokens, LangOrigen, LangDestino, Traduccion)
    ).

% =============================================================================
% CONCORDANCIA DE GÉNERO
% =============================================================================

traducir_con_genero(ArtEng, NounEng, english, spanish, ArtEsp, NounEsp) :-
    noun(NounEng, NounEsp, Genero, Numero),
    article(ArtEng, ArtEsp, Genero, Numero), !.

traducir_con_genero(ArtEsp, NounEsp, spanish, english, ArtEng, NounEng) :-
    article(ArtEng, ArtEsp, _, _),
    noun(NounEng, NounEsp, _, _), !.

traducir_adjetivo_con_genero(AdjOrigen, NounDestino, english, spanish, AdjDestino) :-
    noun(_, NounDestino, Genero, Numero),
    adjective(AdjOrigen, AdjDestino, Genero, Numero), !.

traducir_adjetivo_con_genero(AdjOrigen, _, spanish, english, AdjDestino) :-
    adjective(AdjDestino, AdjOrigen, _, _), !.

traducir_adjetivo_con_genero(Adj, _, LangOrigen, LangDestino, AdjTrad) :-
    traducir_palabra(Adj, LangOrigen, LangDestino, AdjTrad).

% =============================================================================
% SINTAGMA NOMINAL
% =============================================================================

es_sintagma_nominal([Art, Noun], Lang) :-
    es_determinante(Art, Lang),
    es_nombre(Noun, Lang), !.

es_sintagma_nominal([Art, Adj, Noun], english) :-
    es_determinante(Art, english),
    es_adjetivo(Adj, english),
    es_nombre(Noun, english), !.

es_sintagma_nominal([Art, Noun, Adj], spanish) :-
    es_determinante(Art, spanish),
    es_nombre(Noun, spanish),
    es_adjetivo(Adj, spanish), !.

traducir_sintagma_nominal([Art, Noun], LangOrigen, LangDestino, [ArtTrad, NounTrad]) :-
    traducir_con_genero(Art, Noun, LangOrigen, LangDestino, ArtTrad, NounTrad), !.

traducir_sintagma_nominal([Art, Noun, Adj], spanish, english, [ArtTrad, AdjTrad, NounTrad]) :-
    traducir_con_genero(Art, Noun, spanish, english, ArtTrad, NounTrad),
    traducir_palabra(Adj, spanish, english, AdjTrad), !.

traducir_sintagma_nominal([Art, Adj, Noun], english, spanish, [ArtTrad, NounTrad, AdjTrad]) :-
    traducir_con_genero(Art, Noun, english, spanish, ArtTrad, NounTrad),
    traducir_adjetivo_con_genero(Adj, NounTrad, english, spanish, AdjTrad), !.

% =============================================================================
% INTERROGATIVAS
% =============================================================================

:- discontiguous traducir_interrogativa/4.

es_interrogativa_oracion([Primera|_], Lang) :-
    (es_interrogativa_estricta(Primera, Lang) ;
     es_auxiliar_interrogativo(Primera) ;
     member(Primera, [cómo, como]), Lang = spanish
    ), !.

es_interrogativa_estricta(Palabra, spanish) :-
    member(Palabra, [qué, que, dónde, donde, cuándo, cuando, quién, quien, por_que, cómo, como]), !.
es_interrogativa_estricta(Palabra, english) :- 
    member(Palabra, [what, where, when, who, why, how]), !.

es_auxiliar_interrogativo(do).
es_auxiliar_interrogativo(does).
es_auxiliar_interrogativo(is).
es_auxiliar_interrogativo(are).

traducir_interrogativa([QWord|Resto], spanish, english, Traduccion) :-
    member(QWord, [cómo, como]),
    !,
    traducir_interrogativa_como(Resto, Traduccion).

traducir_interrogativa_como([Verbo|Resto], Traduccion) :-
    es_verbo_ser_estar(Verbo),
    !,
    lematizar_espanol(Verbo, _, Persona),
    persona_espanola_a_pronombre(Persona, Pronombre),
    traducir_palabra(Verbo, spanish, english, VerboEng),
    traducir_lista(Resto, spanish, english, RestoTrad),
    append([how, VerboEng, Pronombre], RestoTrad, Traduccion).

traducir_interrogativa_como(Resto, Traduccion) :-
    traducir_lista(Resto, spanish, english, RestoTrad),
    append([how], RestoTrad, Traduccion).

traducir_interrogativa([QWord, Verbo|Resto], spanish, english, Traduccion) :-
    es_interrogativa_estricta(QWord, spanish),
    es_verbo_ser_estar(Verbo),
    !,
    traducir_question_word(QWord, QWordEng),
    lematizar_espanol(Verbo, _, Persona),
    persona_espanola_a_pronombre(Persona, Pronombre),
    traducir_palabra(Verbo, spanish, english, VerboEng),
    (Resto = [Pronombre2|_], es_pronombre(Pronombre2, spanish) ->
        traducir_lista(Resto, spanish, english, RestoTrad),
        append([QWordEng, VerboEng], RestoTrad, Traduccion)
    ;
        traducir_lista(Resto, spanish, english, RestoTrad),
        append([QWordEng, VerboEng, Pronombre], RestoTrad, Traduccion)
    ).

traducir_interrogativa([QWord, Verbo|Resto], spanish, english, Traduccion) :-
    es_interrogativa_estricta(QWord, spanish),
    !,
    traducir_question_word(QWord, QWordEng),
    lematizar_espanol(Verbo, InfEsp, Persona),
    traducir_infinitivo(InfEsp, spanish, english, InfEng),
    persona_espanola_a_pronombre(Persona, Pronombre),
    traducir_lista(Resto, spanish, english, RestoTrad),
    append([QWordEng, do, Pronombre, InfEng], RestoTrad, Traduccion).

traducir_interrogativa([QWord, Aux, Sujeto, Verbo|Resto], english, spanish, Traduccion) :-
    es_interrogativa_estricta(QWord, english),
    member(Aux, [do, does]),
    !,
    traducir_question_word_inv(QWord, QWordEsp),
    pronombre_a_persona_espanola(Sujeto, PersonaEsp),
    traducir_infinitivo(Verbo, english, spanish, InfEsp),
    conjugar_espanol(InfEsp, PersonaEsp, VerboEsp),
    traducir_lista(Resto, english, spanish, RestoTrad),
    append([QWordEsp, VerboEsp], RestoTrad, Traduccion).

traducir_interrogativa([how, Verbo, Sujeto|Resto], english, spanish, Traduccion) :-
    member(Verbo, [is, are]),
    !,
    pronombre_a_persona_espanola(Sujeto, PersonaEsp),
    conjugar_espanol(estar, PersonaEsp, VerboEsp),
    traducir_lista(Resto, english, spanish, RestoTrad),
    append([cómo, VerboEsp], RestoTrad, Traduccion).

traducir_interrogativa([QWord, Verbo, Sujeto|Resto], english, spanish, Traduccion) :-
    es_interrogativa_estricta(QWord, english),
    member(Verbo, [is, are]),
    !,
    traducir_question_word_inv(QWord, QWordEsp),
    (Resto = [Contexto|_], member(Contexto, [in, at, on, tired, happy, sad]) ->
        InfEspanol = estar
    ;
        InfEspanol = ser
    ),
    pronombre_a_persona_espanola(Sujeto, PersonaEsp),
    conjugar_espanol(InfEspanol, PersonaEsp, VerboEsp),
    traducir_palabra(Sujeto, english, spanish, SujetoEsp),
    traducir_lista(Resto, english, spanish, RestoTrad),
    append([QWordEsp, VerboEsp, SujetoEsp], RestoTrad, Traduccion).

traducir_interrogativa(Tokens, LangOrigen, LangDestino, Traduccion) :-
    traducir_lista(Tokens, LangOrigen, LangDestino, Traduccion).

traducir_question_word(qué, what).
traducir_question_word(que, what).
traducir_question_word(dónde, where).
traducir_question_word(donde, where).
traducir_question_word(cuándo, when).
traducir_question_word(cuando, when).
traducir_question_word(quién, who).
traducir_question_word(quien, who).
traducir_question_word(por_que, why).

traducir_question_word_inv(what, qué).
traducir_question_word_inv(where, dónde).
traducir_question_word_inv(when, cuándo).
traducir_question_word_inv(who, quién).
traducir_question_word_inv(why, por_que).
traducir_question_word_inv(how, cómo).

es_verbo_ser_estar(soy).
es_verbo_ser_estar(eres).
es_verbo_ser_estar(es).
es_verbo_ser_estar(somos).
es_verbo_ser_estar(son).
es_verbo_ser_estar(estoy).
es_verbo_ser_estar(estas).
es_verbo_ser_estar(esta).
es_verbo_ser_estar(estamos).
es_verbo_ser_estar(estan).