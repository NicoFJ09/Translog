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

% FIXED PHRASE - manejar frases completas
translate_component(fixed(Tokens), TargetLang, fixed(Translated)) :-
    translate_fixed_phrase(Tokens, TargetLang, Translated), !.

% QWORD - palabras interrogativas
translate_component(qword(TypedWords), TargetLang, qword(Translated)) :-
    translate_typed_words(TypedWords, TargetLang, Translated), !.

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

% OPENING/CLOSING PUNCTUATION
translate_component(opening(Punct), _, opening(Punct)) :- !.
translate_component(closing(Punct), _, closing(Punct)) :- !.
translate_component(punct(Punct), _, punct(Punct)) :- !.

% DEFAULT
translate_component(Component, _, Component).


% =============================================================================
% TRADUCCIÓN DE PALABRAS TIPADAS
% =============================================================================

% translate_typed_words(+TypedWords, +TargetLang, -TranslatedWords)
translate_typed_words([], _, []).

translate_typed_words([TypedWord|Rest], TargetLang, [TranslatedWord|TranslatedRest]) :-
    translate_typed_word(TypedWord, TargetLang, TranslatedWord),
    translate_typed_words(Rest, TargetLang, TranslatedRest).


% translate_typed_word(+TypedWord, +TargetLang, -TranslatedWord)

% ARTICLES
translate_typed_word(word(the, article), spanish, el) :- !.
translate_typed_word(word(a, article), spanish, un) :- !.
translate_typed_word(word(an, article), spanish, un) :- !.

% Spanish articles to English
translate_typed_word(word(el, article), english, the) :- !.
translate_typed_word(word(la, article), english, the) :- !.
translate_typed_word(word(los, article), english, the) :- !.
translate_typed_word(word(las, article), english, the) :- !.
translate_typed_word(word(un, article), english, a) :- !.
translate_typed_word(word(una, article), english, a) :- !.

% NOUNS with context: noun(Translation, Gender, Number)
translate_typed_word(word(_, noun(Translation, _, _)), spanish, Translation) :- !.

% Spanish nouns to English
translate_typed_word(word(Word, noun(_, Gender, Number)), english, English) :-
    noun(English, Word, Gender, Number), !.

% VERB BE - special cases
translate_typed_word(word(is, verb(be, irregular(third_singular, present))), spanish, es) :- !.
translate_typed_word(word(am, verb(be, irregular(first_singular, present))), spanish, soy) :- !.
translate_typed_word(word(are, verb(be, irregular(_, present))), spanish, eres) :- !.

% Spanish BE to English
translate_typed_word(word(es, verb(be, irregular(third_singular, present))), english, is) :- !.
translate_typed_word(word(soy, verb(be, irregular(first_singular, present))), english, am) :- !.

% VERB general with context
translate_typed_word(word(_, verb(VerbBase, _)), spanish, Spanish) :-
    verb_infinitive(VerbBase, Spanish, _), !.

% Spanish verbs to English
translate_typed_word(word(Word, verb(_, _)), english, English) :-
    verb_infinitive(English, Word, _), !.

% ADJECTIVES
translate_typed_word(word(Word, adjective), spanish, Spanish) :-
    adjective(Word, Spanish), !.
translate_typed_word(word(Word, adjective), spanish, Spanish) :-
    adjective(Word, Spanish, _), !.

% Spanish adjectives to English  
translate_typed_word(word(Word, adjective), english, English) :-
    adjective(English, Word), !.
translate_typed_word(word(Word, adjective), english, English) :-
    adjective(English, Word, _), !.

% PRONOUNS
translate_typed_word(word(Word, pronoun), spanish, Spanish) :-
    pronoun(Word, Spanish, _), !.

% Spanish pronouns to English
translate_typed_word(word(Word, pronoun), english, English) :-
    pronoun(English, Word, _), !.

% QUESTION WORDS
translate_typed_word(word(Word, question_word), spanish, Spanish) :-
    question_word(Word, Spanish), !.

% Spanish question words to English
translate_typed_word(word(Word, question_word), english, English) :-
    question_word(English, Word), !.

% PREPOSITIONS
translate_typed_word(word(Word, preposition), spanish, Spanish) :-
    preposition(Word, Spanish), !.

% Spanish prepositions to English
translate_typed_word(word(Word, preposition), english, English) :-
    preposition(English, Word), !.

% NEGATIVES
translate_typed_word(word(Word, negative), spanish, Spanish) :-
    negative(Word, Spanish), !.

% Spanish negatives to English
translate_typed_word(word(Word, negative), english, English) :-
    negative(English, Word), !.

% AUXILIARIES - special handling
translate_typed_word(word(do, auxiliary), spanish, '') :- !.  % Eliminated in Spanish
translate_typed_word(word(does, auxiliary), spanish, '') :- !.
translate_typed_word(word(did, auxiliary), spanish, '') :- !.

% DEFAULT - keep original if no translation found
translate_typed_word(word(Word, _), _, Word).


% =============================================================================
% FIXED PHRASES TRANSLATION
% =============================================================================

% translate_fixed_phrase(+Tokens, +TargetLang, -Translation)
translate_fixed_phrase([Word], spanish, [Spanish]) :-
    common_phrase(Word, Spanish), !.

translate_fixed_phrase([Word], english, [English]) :-
    common_phrase(English, Word), !.

% If not a common phrase, translate word by word
translate_fixed_phrase([], _, []).
translate_fixed_phrase([Word|Rest], TargetLang, [Translated|TranslatedRest]) :-
    translate_single_word(Word, TargetLang, Translated),
    translate_fixed_phrase(Rest, TargetLang, TranslatedRest).

% translate_single_word(+Word, +TargetLang, -Translation)
translate_single_word(Word, spanish, Spanish) :-
    common_phrase(Word, Spanish), !.

translate_single_word(Word, english, English) :-
    common_phrase(English, Word), !.

translate_single_word(Word, _, Word).


% =============================================================================
% CONVERT COMPONENTS TO TOKENS
% =============================================================================

% components_to_tokens(+Components, -Tokens)
components_to_tokens([], []).

components_to_tokens([Component|Rest], AllTokens) :-
    component_to_tokens(Component, Tokens),
    components_to_tokens(Rest, RestTokens),
    append(Tokens, RestTokens, AllTokens).


% component_to_tokens(+Component, -Tokens)
component_to_tokens(fixed(Words), Words) :- !.

component_to_tokens(opening(Punct), Punct) :- !.
component_to_tokens(closing(Punct), Punct) :- !.
component_to_tokens(punct(Punct), Punct) :- !.

component_to_tokens(qword(Words), Tokens) :-
    extract_words(Words, Tokens), !.

component_to_tokens(subject(Words), Tokens) :-
    extract_words(Words, Tokens), !.

component_to_tokens(verb(Words), Tokens) :-
    extract_words(Words, Tokens), !.

component_to_tokens(complement(Words), Tokens) :-
    extract_words(Words, Tokens), !.

component_to_tokens(auxiliary(['']), []) :- !.  % Remove empty auxiliaries
component_to_tokens(auxiliary(Words), Tokens) :-
    extract_words(Words, Tokens), !.

component_to_tokens(negation(Words), Tokens) :-
    extract_words(Words, Tokens), !.

component_to_tokens(_, []).


% extract_words(+WordList, -Tokens)
extract_words([], []).

extract_words([''|Rest], Tokens) :-  % Skip empty strings
    extract_words(Rest, Tokens), !.

extract_words([Word|Rest], [Word|Tokens]) :-
    atom(Word),
    Word \= '',  % Skip empty atoms
    extract_words(Rest, Tokens), !.

extract_words([word(Token, _)|Rest], [Token|Tokens]) :-
    Token \= '',  % Skip empty tokens
    extract_words(Rest, Tokens), !.

extract_words([_|Rest], Tokens) :-
    extract_words(Rest, Tokens).