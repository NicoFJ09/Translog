% ===============================================
% SENTENCE TRANSLATOR
% Traduce palabra por palabra usando componentes tipados
% ===============================================

:- consult('../../database/DB.pl').
:- consult('classifier.pl').
:- consult('structure.pl').

% =============================================================================
% TRADUCCIÓN PRINCIPAL
% =============================================================================

% translate(+Classification, +TargetLang, -TranslatedTokens)
translate(Classification, TargetLang, Translated) :-
    % 1. Estructurar (reordenar)
    structure(Classification, TargetLang, StructuredComponents),
    
    % 2. Traducir palabra por palabra
    translate_components(StructuredComponents, TargetLang, TranslatedComponents),
    
    % 3. Extraer tokens finales
    components_to_tokens(TranslatedComponents, Translated).


% =============================================================================
% TRADUCCIÓN DE COMPONENTES
% =============================================================================

% translate_components(+Components, +TargetLang, -TranslatedComponents)
translate_components([], _, []).

translate_components([Component|Rest], TargetLang, [Translated|TranslatedRest]) :-
    translate_component(Component, TargetLang, Translated),
    translate_components(Rest, TargetLang, TranslatedRest).


% translate_component(+Component, +TargetLang, -TranslatedComponent)

% FIXED PHRASE
translate_component(fixed(Tokens), TargetLang, fixed(Translated)) :-
    translate_phrase_direct(Tokens, TargetLang, Translated), !.

% SUBJECT
translate_component(subject(TypedWords), TargetLang, subject(Translated)) :-
    translate_typed_words(TypedWords, TargetLang, Translated), !.

% VERB
translate_component(verb(TypedWords), TargetLang, verb(Translated)) :-
    translate_typed_words(TypedWords, TargetLang, Translated), !.

% COMPLEMENT
translate_component(complement(TypedWords), TargetLang, complement(Translated)) :-
    translate_typed_words(TypedWords, TargetLang, Translated), !.

% AUXILIARY
translate_component(auxiliary(TypedWords), TargetLang, auxiliary(Translated)) :-
    translate_typed_words(TypedWords, TargetLang, Translated), !.

% NEGATION
translate_component(negation(TypedWords), TargetLang, negation(Translated)) :-
    translate_typed_words(TypedWords, TargetLang, Translated), !.

% QWORD
translate_component(qword(TypedWords), TargetLang, qword(Translated)) :-
    translate_typed_words(TypedWords, TargetLang, Translated), !.

% PUNCTUATION
translate_component(punct(Punct), _, punct(Punct)) :- !.
translate_component(opening(Open), _, opening(Open)) :- !.
translate_component(closing(Close), _, closing(Close)) :- !.


% =============================================================================
% TRADUCCIÓN DE PALABRAS TIPADAS
% =============================================================================

% translate_typed_words(+TypedWords, +TargetLang, -TranslatedWords)
translate_typed_words([], _, []).

translate_typed_words([word(Token, Type)|Rest], TargetLang, [word(Translated, Type)|TranslatedRest]) :-
    translate_word(Token, Type, TargetLang, Translated),
    translate_typed_words(Rest, TargetLang, TranslatedRest).


% translate_word(+Word, +Type, +TargetLang, -Translation)

% PRONOUN
translate_word(Word, pronoun, spanish, Translation) :-
    pronoun(Word, Translation, _), !.
translate_word(Word, pronoun, english, Translation) :-
    pronoun(Translation, Word, _), !.

% ARTICLE
translate_word(Word, article, spanish, Translation) :-
    article(Word, Translation, _, _), !.
translate_word(Word, article, english, Translation) :-
    article(Translation, Word, _, _), !.

% NOUN (usar la forma base identificada)
translate_word(_, noun(Base, Gender, Number), spanish, Translation) :-
    noun(Base, SpanishBase, Gender, singular),
    apply_number(SpanishBase, Number, Translation), !.

translate_word(_, noun(Base, Gender, Number), english, Translation) :-
    noun(EnglishBase, Base, Gender, singular),
    apply_number(EnglishBase, Number, Translation), !.

% VERB (usar la forma base identificada)
translate_word(_, verb(Base, _Conjugation), spanish, Translation) :-
    verb_infinitive(Base, Translation, _), !.

translate_word(_, verb(Base, _Conjugation), english, Translation) :-
    verb_infinitive(Translation, Base, _), !.

% ADJECTIVE
translate_word(Word, adjective, spanish, Translation) :-
    adjective(Word, Translation), !.
translate_word(Word, adjective, english, Translation) :-
    adjective(Translation, Word), !.

% ADVERB
translate_word(Word, adverb, spanish, Translation) :-
    adverb(Word, Translation), !.
translate_word(Word, adverb, english, Translation) :-
    adverb(Translation, Word), !.

% PREPOSITION
translate_word(Word, preposition, spanish, Translation) :-
    preposition(Word, Translation), !.
translate_word(Word, preposition, english, Translation) :-
    preposition(Translation, Word), !.

% QUESTION_WORD
translate_word(Word, question_word, spanish, Translation) :-
    question_word(Word, Translation), !.
translate_word(Word, question_word, english, Translation) :-
    question_word(Translation, Word), !.

% NEGATIVE
translate_word(Word, negative, spanish, Translation) :-
    negative(Word, Translation), !.
translate_word(Word, negative, english, Translation) :-
    negative(Translation, Word), !.

% AUXILIARY (especial - no se traduce directamente)
translate_word(do, auxiliary, spanish, '') :- !.  % Se elimina en español
translate_word(does, auxiliary, spanish, '') :- !.
translate_word(did, auxiliary, spanish, '') :- !.

% UNKNOWN - dejar como está
translate_word(Word, unknown, _, Word).


% =============================================================================
% APLICAR NÚMERO
% =============================================================================

% apply_number(+Base, +Number, -WithNumber)
apply_number(Base, singular, Base) :- !.

apply_number(Base, plural, Plural) :-
    atom_concat(Base, 's', Plural).


% =============================================================================
% TRADUCCIÓN DE FRASES FIJAS
% =============================================================================

% translate_phrase_direct(+Tokens, +TargetLang, -Translation)
translate_phrase_direct([Word|Rest], spanish, Translation) :-
    Rest = [],
    common_phrase(Word, Translation), !.

translate_phrase_direct([Word1, Word2|Rest], spanish, Translation) :-
    Rest = [],
    common_phrase([Word1, Word2], Translation), !.

translate_phrase_direct([Word|Rest], english, Translation) :-
    Rest = [],
    common_phrase(Translation, Word), !.

translate_phrase_direct(Tokens, _, Tokens).


% =============================================================================
% CONVERTIR COMPONENTES A TOKENS
% =============================================================================

% components_to_tokens(+Components, -Tokens)
components_to_tokens(Components, Tokens) :-
    extract_all_words(Components, Words),
    remove_empty_words(Words, Tokens).


extract_all_words([], []).

extract_all_words([fixed(Tokens)|Rest], AllTokens) :-
    extract_all_words(Rest, RestTokens),
    append(Tokens, RestTokens, AllTokens), !.

extract_all_words([Component|Rest], AllTokens) :-
    Component =.. [_Type, TypedWords],
    is_list(TypedWords),
    extract_words_from_typed(TypedWords, Words),
    extract_all_words(Rest, RestTokens),
    append(Words, RestTokens, AllTokens), !.

extract_all_words([_|Rest], AllTokens) :-
    extract_all_words(Rest, AllTokens).


extract_words_from_typed([], []).
extract_words_from_typed([word(Token, _)|Rest], [Token|Tokens]) :-
    extract_words_from_typed(Rest, Tokens).


remove_empty_words([], []).
remove_empty_words([''|Rest], Clean) :-
    remove_empty_words(Rest, Clean), !.
remove_empty_words([Word|Rest], [Word|Clean]) :-
    remove_empty_words(Rest, Clean).