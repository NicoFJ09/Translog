% ===============================================
% SENTENCE CLASSIFIER
% Identifica estructura y extrae componentes tipados
% Usa CONTEXTO para determinar qué es cada palabra
% ===============================================

:- consult('../../database/DB.pl').

% =============================================================================
% CLASIFICACIÓN PRINCIPAL
% =============================================================================

% classify(+Tokens, -Classification)
% Classification = classification(Type, TypedComponents, Language)
classify(Tokens, classification(Type, TypedComponents, Lang)) :-
    detect_language(Tokens, Lang),
    classify_type(Tokens, Type),
    extract_components_typed(Tokens, Type, Lang, TypedComponents).


% =============================================================================
% DETECCIÓN DE IDIOMA
% =============================================================================

detect_language(Tokens, spanish) :-
    (member('¿', Tokens) ; member('¡', Tokens)), !.
detect_language(_, english).


% =============================================================================
% CLASIFICACIÓN DE TIPO
% =============================================================================

classify_type(Tokens, phrase) :-
    remove_punctuation(Tokens, Clean),
    common_phrase(Word, _),
    Clean = [Word|_], !.

classify_type(Tokens, question) :-
    (member('?', Tokens) ; member('¿', Tokens)), !.

classify_type(Tokens, negative) :-
    member(Word, Tokens),
    (Word = not ; Word = no ; negative(Word, _)), !.

classify_type(_, statement).


% =============================================================================
% EXTRACCIÓN TIPADA CON CONTEXTO
% =============================================================================

% extract_components_typed(+Tokens, +Type, +Lang, -TypedComponents)

% PHRASE: no descomponer
extract_components_typed(Tokens, phrase, _, [fixed(Tokens)]).

% STATEMENT
extract_components_typed(Tokens, statement, Lang, Components) :-
    remove_final_punct(Tokens, Punct, WithoutPunct),
    extract_subject_typed(WithoutPunct, Lang, Subject, Rest1),
    extract_verb_typed(Rest1, Lang, Verb, Rest2),
    extract_complement_typed(Rest2, Lang, Complement),
    Components = [subject(Subject), verb(Verb), complement(Complement), punct(Punct)].

% QUESTION
extract_components_typed(Tokens, question, Lang, Components) :-
    remove_punct_marks(Tokens, OpenPunct, ClosePunct, Clean),
    (starts_with_qword(Clean) ->
        extract_wh_question_typed(Clean, Lang, Comp)
    ;
        extract_yn_question_typed(Clean, Lang, Comp)
    ),
    append([[opening(OpenPunct)], Comp, [closing(ClosePunct)]], Components).

% NEGATIVE
extract_components_typed(Tokens, negative, Lang, Components) :-
    remove_final_punct(Tokens, Punct, WithoutPunct),
    extract_subject_typed(WithoutPunct, Lang, Subject, Rest1),
    extract_aux_typed(Rest1, Lang, Aux, Rest2),
    extract_negation_typed(Rest2, Lang, Neg, Rest3),
    extract_verb_typed(Rest3, Lang, Verb, Rest4),
    extract_complement_typed(Rest4, Lang, Complement),
    Components = [subject(Subject), auxiliary(Aux), negation(Neg), verb(Verb), 
                  complement(Complement), punct(Punct)].


% =============================================================================
% EXTRACTORES TIPADOS CON CONTEXTO
% =============================================================================

% extract_subject_typed(+Tokens, +Lang, -TypedSubject, -Rest)
% CONTEXTO: Al inicio de oración, esperamos sujeto

extract_subject_typed([Word|Rest], _, [word(Word, pronoun)], Rest) :-
    pronoun(Word, _, _), !.

extract_subject_typed([Art, Noun|Rest], Lang, 
                     [word(Art, article), word(Noun, noun(Base, Gender, Number))], 
                     Rest) :-
    article(Art, _, _, _),
    % Ingeniería inversa: deducir forma base del sustantivo
    identify_noun_from_context(Noun, Lang, Base, Gender, Number), !.

extract_subject_typed([Art, Adj, Noun|Rest], Lang,
                     [word(Art, article), word(Adj, adjective), word(Noun, noun(Base, Gender, Number))],
                     Rest) :-
    article(Art, _, _, _),
    adjective(Adj, _),
    identify_noun_from_context(Noun, Lang, Base, Gender, Number), !.

extract_subject_typed([Quant, Noun|Rest], Lang,
                     [word(Quant, quantifier), word(Noun, noun(Base, Gender, Number))],
                     Rest) :-
    quantifier(Quant, _, _, _),
    identify_noun_from_context(Noun, Lang, Base, Gender, Number), !.

extract_subject_typed(Tokens, _, [], Tokens).


% extract_verb_typed(+Tokens, +Lang, -TypedVerb, -Rest)
% CONTEXTO: Después de sujeto, esperamos verbo

extract_verb_typed([Verb|Rest], Lang, [word(Verb, verb(Base, Conjugation))], Rest) :-
    % Ingeniería inversa: deducir infinitivo del verbo
    identify_verb_from_context(Verb, Lang, Base, Conjugation), !.

extract_verb_typed([Aux, Verb|Rest], Lang,
                   [word(Aux, auxiliary), word(Verb, verb(Base, Conjugation))],
                   Rest) :-
    member(Aux, [do, does, did, is, are, was, were, can, will, should]),
    identify_verb_from_context(Verb, Lang, Base, Conjugation), !.

extract_verb_typed(Tokens, _, [], Tokens).


% extract_aux_typed(+Tokens, +Lang, -TypedAux, -Rest)
extract_aux_typed([Aux|Rest], _, [word(Aux, auxiliary)], Rest) :-
    member(Aux, [do, does, did]), !.
extract_aux_typed(Tokens, _, [], Tokens).


% extract_negation_typed(+Tokens, +Lang, -TypedNeg, -Rest)
extract_negation_typed([Word|Rest], _, [word(Word, negative)], Rest) :-
    (Word = not ; Word = no ; negative(Word, _)), !.
extract_negation_typed(Tokens, _, [], Tokens).


% extract_complement_typed(+Tokens, +Lang, -TypedComplement)
extract_complement_typed([], _, []).
extract_complement_typed([Token|Rest], Lang, [word(Token, Type)|TypedRest]) :-
    identify_word_by_context(Token, complement, Lang, Type),
    extract_complement_typed(Rest, Lang, TypedRest).


% extract_wh_question_typed(+Tokens, +Lang, -TypedComponents)
extract_wh_question_typed([QWord|Rest], Lang, Components) :-
    question_word(QWord, _),
    extract_verb_typed(Rest, Lang, Verb, Rest2),
    extract_subject_typed(Rest2, Lang, Subject, Rest3),
    extract_complement_typed(Rest3, Lang, Complement),
    Components = [qword([word(QWord, question_word)]), verb(Verb), 
                  subject(Subject), complement(Complement)].


% extract_yn_question_typed(+Tokens, +Lang, -TypedComponents)
extract_yn_question_typed([Aux|Rest], Lang, Components) :-
    member(Aux, [do, does, did, is, are]),
    extract_subject_typed(Rest, Lang, Subject, Rest2),
    extract_verb_typed(Rest2, Lang, Verb, Rest3),
    extract_complement_typed(Rest3, Lang, Complement),
    Components = [auxiliary([word(Aux, auxiliary)]), subject(Subject), 
                  verb(Verb), complement(Complement)].


% =============================================================================
% INGENIERÍA INVERSA: IDENTIFICAR POR CONTEXTO
% =============================================================================

% identify_noun_from_context(+Word, +Lang, -Base, -Gender, -Number)
% Deduce la forma base del sustantivo usando contexto

identify_noun_from_context(Word, _, Base, Gender, Number) :-
    % Primero intenta búsqueda directa
    noun(Word, Base, Gender, Number), !.

identify_noun_from_context(Word, english, Base, Gender, plural) :-
    % Inglés: quitar -s para plural
    atom_concat(Base, 's', Word),
    noun(Base, _, Gender, singular), !.

identify_noun_from_context(Word, english, Base, Gender, plural) :-
    % Inglés: quitar -es para plural
    atom_concat(Base, 'es', Word),
    noun(Base, _, Gender, singular), !.

identify_noun_from_context(Word, spanish, Base, Gender, plural) :-
    % Español: quitar -s para plural
    atom_concat(Base, 's', Word),
    noun(Base, _, Gender, singular), !.

identify_noun_from_context(Word, spanish, Base, Gender, plural) :-
    % Español: quitar -es para plural
    atom_concat(Base, 'es', Word),
    noun(Base, _, Gender, singular), !.

% Si no encuentra, asumir que es la forma base
identify_noun_from_context(Word, _, Word, unknown, unknown).


% identify_verb_from_context(+Word, +Lang, -Base, -Conjugation)
% Deduce el infinitivo del verbo

identify_verb_from_context(Word, _, Word, infinitive) :-
    % Primero intenta búsqueda directa (infinitivo)
    verb_infinitive(Word, _, _), !.

identify_verb_from_context(Word, english, Base, third_person) :-
    % Inglés: quitar -s (he likes -> like)
    atom_concat(Base, 's', Word),
    verb_infinitive(Base, _, _), !.

identify_verb_from_context(Word, english, Base, past) :-
    % Inglés: quitar -ed (walked -> walk)
    atom_concat(Base, 'ed', Word),
    verb_infinitive(Base, _, _), !.

identify_verb_from_context(Word, english, Base, present_participle) :-
    % Inglés: quitar -ing (walking -> walk)
    atom_concat(Base, 'ing', Word),
    verb_infinitive(Base, _, _), !.

identify_verb_from_context(Word, spanish, Base, conjugated) :-
    % Español: (PLACEHOLDER - esperar a Fabiola)
    % Por ahora, asumir que puede ser conjugado
    verb_infinitive(Base, _, _),
    atom_concat(Root, _, Base),
    atom_concat(Root, _, Word), !.

% Si no encuentra, asumir que es base
identify_verb_from_context(Word, _, Word, unknown).


% identify_word_by_context(+Word, +Context, +Lang, -Type)
% Identifica palabra según el contexto donde aparece

identify_word_by_context(Word, complement, _, adjective) :-
    adjective(Word, _), !.

identify_word_by_context(Word, complement, _, adverb) :-
    adverb(Word, _), !.

identify_word_by_context(Word, complement, _, preposition) :-
    preposition(Word, _), !.

identify_word_by_context(Word, complement, Lang, noun(Base, Gender, Number)) :-
    identify_noun_from_context(Word, Lang, Base, Gender, Number), !.

identify_word_by_context(_, _, _, unknown).


% =============================================================================
% UTILIDADES
% =============================================================================

remove_punctuation([], []).
remove_punctuation([P|Rest], Clean) :-
    member(P, ['.', ',', '!', '?', '¿', '¡', ';', ':']), !,
    remove_punctuation(Rest, Clean).
remove_punctuation([T|Rest], [T|Clean]) :-
    remove_punctuation(Rest, Clean).


remove_final_punct(Tokens, [Punct], WithoutPunct) :-
    append(WithoutPunct, [Punct], Tokens),
    member(Punct, ['.', '?', '!']), !.
remove_final_punct(Tokens, [], Tokens).


remove_punct_marks(Tokens, [Open], [Close], Clean) :-
    Tokens = [First|_],
    member(First, ['¿', '¡']),
    Tokens = [Open|Rest],
    append(Clean, [Close], Rest), !.
remove_punct_marks(Tokens, [], Close, Clean) :-
    remove_final_punct(Tokens, Close, Clean).


starts_with_qword([Word|_]) :-
    question_word(Word, _).