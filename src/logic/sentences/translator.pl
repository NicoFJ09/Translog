% ===============================================
% SENTENCE TRANSLATOR
% ===============================================

:- consult('../../database/DB.pl').
:- consult('classifier.pl').
:- consult('structure.pl').

translate(Classification, SourceLang, TargetLang, Translated) :-
    fix_classification(Classification, SourceLang, FixedClassification),
    structure(FixedClassification, SourceLang, TargetLang, Structured),
    translate_components(Structured, SourceLang, TargetLang, TranslatedComponents),
    flatten_to_tokens(TranslatedComponents, Translated).

% =============================================================================
% FIX CLASSIFICATION
% =============================================================================

% Spanish: subject + empty verb + adjective complement -> move adjective to subject
fix_classification(classification(statement, Components), spanish, 
                   classification(statement, FixedComponents)) :-
    member(subject(Subject), Components),
    member(verb([]), Components),
    member(complement(Complement), Components),
    Complement \= [],
    all_adjectives_spanish(Complement),
    append(Subject, Complement, NewSubject),
    select(subject(Subject), Components, subject(NewSubject), Temp1),
    select(complement(Complement), Temp1, complement([]), FixedComponents), !.

fix_classification(Classification, _, Classification).

all_adjectives_spanish([]).
all_adjectives_spanish([Word|Rest]) :-
    (adjective(_, Word) ; adjective(_, Word, _)),
    all_adjectives_spanish(Rest).

% =============================================================================
% COMPONENT TRANSLATION
% =============================================================================

translate_components([], _, _, []).
translate_components([Component|Rest], SourceLang, TargetLang, [Translated|TranslatedRest]) :-
    translate_component(Component, SourceLang, TargetLang, Translated),
    translate_components(Rest, SourceLang, TargetLang, TranslatedRest).

translate_component(fixed(Tokens), SourceLang, TargetLang, fixed(Translated)) :-
    translate_words(Tokens, SourceLang, TargetLang, Translated), !.
translate_component(qword(Words), SourceLang, TargetLang, qword(Translated)) :-
    translate_words(Words, SourceLang, TargetLang, Translated), !.
translate_component(subject(Words), SourceLang, TargetLang, subject(Translated)) :-
    translate_subject_structure(Words, SourceLang, TargetLang, Translated), !.
translate_component(verb(Words), SourceLang, TargetLang, verb(Translated)) :-
    translate_verb_structure(Words, SourceLang, TargetLang, Translated), !.
translate_component(complement(Words), SourceLang, TargetLang, complement(Translated)) :-
    translate_complement_structure(Words, SourceLang, TargetLang, Translated), !.
translate_component(auxiliary(Words), SourceLang, TargetLang, auxiliary(Translated)) :-
    translate_words(Words, SourceLang, TargetLang, Translated), !.
translate_component(negation(Words), SourceLang, TargetLang, negation(Translated)) :-
    translate_words(Words, SourceLang, TargetLang, Translated), !.
translate_component(opening(Punct), _, _, opening(Punct)) :- !.
translate_component(closing(Punct), _, _, closing(Punct)) :- !.
translate_component(punct(Punct), _, _, punct(Punct)) :- !.
translate_component(Component, _, _, Component).

% =============================================================================
% SUBJECT STRUCTURE TRANSLATION
% =============================================================================

translate_subject_structure([W1, W2, W3], SourceLang, TargetLang, [T1, T2, T3]) :-
    is_article_word(W1, SourceLang),
    is_adjective_word(W2, SourceLang),
    is_noun_word(W3, SourceLang),
    translate_as_article(W1, SourceLang, TargetLang, T1),
    translate_as_adjective(W2, SourceLang, TargetLang, T2),
    translate_as_noun(W3, SourceLang, TargetLang, T3), !.

translate_subject_structure([W1, W2, W3], SourceLang, TargetLang, [T1, T2, T3]) :-
    is_article_word(W1, SourceLang),
    is_noun_word(W2, SourceLang),
    is_adjective_word(W3, SourceLang),
    translate_as_article(W1, SourceLang, TargetLang, T1),
    translate_as_noun(W2, SourceLang, TargetLang, T2),
    translate_as_adjective(W3, SourceLang, TargetLang, T3), !.

translate_subject_structure([W1, W2], SourceLang, TargetLang, [T1, T2]) :-
    is_article_word(W1, SourceLang),
    is_noun_word(W2, SourceLang),
    translate_as_article(W1, SourceLang, TargetLang, T1),
    translate_as_noun(W2, SourceLang, TargetLang, T2), !.

translate_subject_structure([W1, W2], SourceLang, TargetLang, [T1, T2]) :-
    is_quantifier_word(W1, SourceLang),
    is_noun_word(W2, SourceLang),
    translate_as_quantifier(W1, SourceLang, TargetLang, T1),
    translate_as_noun(W2, SourceLang, TargetLang, T2), !.

translate_subject_structure([W], SourceLang, TargetLang, [T]) :-
    is_pronoun_word(W, SourceLang),
    translate_as_pronoun(W, SourceLang, TargetLang, T), !.

translate_subject_structure(Words, SourceLang, TargetLang, Translated) :-
    translate_words(Words, SourceLang, TargetLang, Translated).

% =============================================================================
% VERB STRUCTURE TRANSLATION
% =============================================================================

translate_verb_structure([Verb], SourceLang, TargetLang, [TransVerb]) :-
    is_verb_word(Verb, SourceLang),
    translate_as_verb(Verb, SourceLang, TargetLang, TransVerb), !.

translate_verb_structure([Aux, Verb], SourceLang, TargetLang, [TransAux, TransVerb]) :-
    is_auxiliary_word(Aux),
    is_verb_word(Verb, SourceLang),
    translate_word(Aux, SourceLang, TargetLang, TransAux),
    translate_as_verb(Verb, SourceLang, TargetLang, TransVerb), !.

translate_verb_structure(Words, SourceLang, TargetLang, Translated) :-
    translate_words(Words, SourceLang, TargetLang, Translated).

% =============================================================================
% COMPLEMENT STRUCTURE TRANSLATION
% =============================================================================

% [Noun] without article - add article based on plurality
translate_complement_structure([Noun], english, spanish, [los, Spanish]) :-
    is_noun_word(Noun, english),
    is_plural_noun(Noun, english),
    translate_as_noun(Noun, english, spanish, Spanish), !.

translate_complement_structure([Noun], english, spanish, [el, Spanish]) :-
    is_noun_word(Noun, english),
    translate_as_noun(Noun, english, spanish, Spanish), !.

translate_complement_structure([W1, W2, W3|Rest], SourceLang, TargetLang, [T1, T2, T3|TRest]) :-
    is_preposition_word(W1, SourceLang),
    is_article_word(W2, SourceLang),
    is_noun_word(W3, SourceLang),
    translate_as_preposition(W1, SourceLang, TargetLang, T1),
    translate_as_article(W2, SourceLang, TargetLang, T2),
    translate_as_noun(W3, SourceLang, TargetLang, T3),
    translate_complement_structure(Rest, SourceLang, TargetLang, TRest), !.

translate_complement_structure([W1, W2|Rest], SourceLang, TargetLang, [T1, T2|TRest]) :-
    is_adverb_word(W1, SourceLang),
    is_adjective_word(W2, SourceLang),
    translate_as_adverb(W1, SourceLang, TargetLang, T1),
    translate_as_adjective(W2, SourceLang, TargetLang, T2),
    translate_complement_structure(Rest, SourceLang, TargetLang, TRest), !.

translate_complement_structure([W1, W2|Rest], SourceLang, TargetLang, [T1, T2|TRest]) :-
    is_article_word(W1, SourceLang),
    is_noun_word(W2, SourceLang),
    translate_as_article(W1, SourceLang, TargetLang, T1),
    translate_as_noun(W2, SourceLang, TargetLang, T2),
    translate_complement_structure(Rest, SourceLang, TargetLang, TRest), !.

translate_complement_structure([W|Rest], SourceLang, TargetLang, [T|TRest]) :-
    is_adjective_word(W, SourceLang),
    translate_as_adjective(W, SourceLang, TargetLang, T),
    translate_complement_structure(Rest, SourceLang, TargetLang, TRest), !.

translate_complement_structure([W|Rest], SourceLang, TargetLang, [T|TRest]) :-
    is_noun_word(W, SourceLang),
    translate_as_noun(W, SourceLang, TargetLang, T),
    translate_complement_structure(Rest, SourceLang, TargetLang, TRest), !.

translate_complement_structure([], _, _, []) :- !.

translate_complement_structure([W|Rest], SourceLang, TargetLang, [T|TRest]) :-
    translate_word(W, SourceLang, TargetLang, T),
    translate_complement_structure(Rest, SourceLang, TargetLang, TRest).

% =============================================================================
% TYPE CHECKERS
% =============================================================================

is_article_word(Word, english) :- article(Word, _, _, _), !.
is_article_word(Word, spanish) :- article(_, Word, _, _), !.

is_noun_word(Word, english) :- noun(Word, _, _, _), !.
is_noun_word(Word, spanish) :- noun(_, Word, _, _), !.

is_plural_noun(Word, english) :- noun(Word, _, _, plural), !.

is_adjective_word(Word, english) :- (adjective(Word, _) ; adjective(Word, _, _)), !.
is_adjective_word(Word, spanish) :- (adjective(_, Word) ; adjective(_, Word, _)), !.

is_pronoun_word(Word, english) :- pronoun(Word, _, _), !.
is_pronoun_word(Word, spanish) :- pronoun(_, Word, _), !.

is_quantifier_word(Word, english) :- quantifier(Word, _, _, _), !.
is_quantifier_word(Word, spanish) :- quantifier(_, Word, _, _), !.

is_verb_word(Word, english) :- (irregular_form(Word, _, _, _) ; verb_infinitive(Word, _, _)), !.
is_verb_word(Word, spanish) :- (verb_infinitive(_, Word, _) ; spanish_verb(Word, _)), !.

is_auxiliary_word(Word) :- auxiliary(Word), !.

is_preposition_word(Word, english) :- preposition(Word, _), !.
is_preposition_word(Word, spanish) :- preposition(_, Word), !.

is_adverb_word(Word, english) :- adverb(Word, _), !.
is_adverb_word(Word, spanish) :- adverb(_, Word), !.

% =============================================================================
% TYPE-SPECIFIC TRANSLATION
% =============================================================================

translate_as_article(Word, english, spanish, Spanish) :- article(Word, Spanish, _, _), !.
translate_as_article(Word, spanish, english, English) :- article(English, Word, _, _), !.

translate_as_noun(Word, english, spanish, Spanish) :- noun(Word, Spanish, _, _), !.
translate_as_noun(Word, spanish, english, English) :- noun(English, Word, _, _), !.

translate_as_adjective(Word, english, spanish, Spanish) :- (adjective(Word, Spanish) ; adjective(Word, Spanish, _)), !.
translate_as_adjective(Word, spanish, english, English) :- (adjective(English, Word) ; adjective(English, Word, _)), !.

translate_as_pronoun(Word, english, spanish, Spanish) :- pronoun(Word, Spanish, _), !.
translate_as_pronoun(Word, spanish, english, English) :- pronoun(English, Word, _), !.

translate_as_quantifier(Word, english, spanish, Spanish) :- quantifier(Word, Spanish, _, _), !.
translate_as_quantifier(Word, spanish, english, English) :- quantifier(English, Word, _, _), !.

translate_as_verb(Word, english, spanish, Spanish) :- 
    (irregular_form(Word, Base, _, _) -> verb_infinitive(Base, Spanish, _) ; verb_infinitive(Word, Spanish, _)), !.
translate_as_verb(Word, spanish, english, English) :- 
    (spanish_verb(Word, English) ; verb_infinitive(English, Word, _)), !.

translate_as_preposition(Word, english, spanish, Spanish) :- preposition(Word, Spanish), !.
translate_as_preposition(Word, spanish, english, English) :- preposition(English, Word), !.

translate_as_adverb(Word, english, spanish, Spanish) :- adverb(Word, Spanish), !.
translate_as_adverb(Word, spanish, english, English) :- adverb(English, Word), !.

% =============================================================================
% GENERAL WORD TRANSLATION
% =============================================================================

translate_words([], _, _, []).
translate_words([Word|Rest], SourceLang, TargetLang, [Translated|TranslatedRest]) :-
    translate_word(Word, SourceLang, TargetLang, Translated),
    translate_words(Rest, SourceLang, TargetLang, TranslatedRest).

translate_word(Word, english, spanish, Spanish) :- pronoun(Word, Spanish, _), !.
translate_word(Word, spanish, english, English) :- pronoun(English, Word, _), !.

translate_word(Word, english, spanish, Spanish) :- article(Word, Spanish, _, _), !.
translate_word(Word, spanish, english, English) :- article(English, Word, _, _), !.

translate_word(Word, english, spanish, Spanish) :- noun(Word, Spanish, _, _), !.
translate_word(Word, spanish, english, English) :- noun(English, Word, _, _), !.

translate_word(Word, english, spanish, Spanish) :- adjective(Word, Spanish), !.
translate_word(Word, spanish, english, English) :- adjective(English, Word), !.

translate_word(Word, english, spanish, Spanish) :- adjective(Word, Spanish, _), !.
translate_word(Word, spanish, english, English) :- adjective(English, Word, _), !.

translate_word(Word, english, spanish, Spanish) :- verb_infinitive(Word, Spanish, _), !.
translate_word(Word, spanish, english, English) :- verb_infinitive(English, Word, _), !.

translate_word(Word, english, spanish, Spanish) :- 
    irregular_form(Word, Base, _, _), verb_infinitive(Base, Spanish, _), !.
translate_word(Word, spanish, english, English) :- spanish_verb(Word, English), !.

translate_word(Word, english, spanish, Spanish) :- adverb(Word, Spanish), !.
translate_word(Word, spanish, english, English) :- adverb(English, Word), !.

translate_word(Word, english, spanish, Spanish) :- preposition(Word, Spanish), !.
translate_word(Word, spanish, english, English) :- preposition(English, Word), !.

translate_word(Word, english, spanish, Spanish) :- conjunction(Word, Spanish), !.
translate_word(Word, spanish, english, English) :- conjunction(English, Word), !.

translate_word(Word, english, spanish, Spanish) :- question_word(Word, Spanish), !.
translate_word(Word, spanish, english, English) :- question_word(English, Word), !.

translate_word(Word, english, spanish, Spanish) :- negative(Word, Spanish), !.
translate_word(Word, spanish, english, English) :- negative(English, Word), !.

translate_word(Word, english, spanish, Spanish) :- quantifier(Word, Spanish, _, _), !.
translate_word(Word, spanish, english, English) :- quantifier(English, Word, _, _), !.

translate_word(Word, english, spanish, Spanish) :- common_phrase(Word, Spanish), !.
translate_word(Word, spanish, english, English) :- common_phrase(English, Word), !.

translate_word(Word, english, spanish, Spanish) :- number_word(Word, Spanish, _), !.
translate_word(Word, spanish, english, English) :- number_word(English, Word, _), !.

translate_word(Word, _, _, Word).

% =============================================================================
% FLATTEN TO TOKENS
% =============================================================================

flatten_to_tokens([], []).
flatten_to_tokens([Component|Rest], AllTokens) :-
    component_to_tokens(Component, Tokens),
    flatten_to_tokens(Rest, RestTokens),
    append(Tokens, RestTokens, AllTokens).

component_to_tokens(fixed(Words), Words) :- !.
component_to_tokens(opening(Punct), Punct) :- !.
component_to_tokens(closing(Punct), Punct) :- !.
component_to_tokens(punct(Punct), Punct) :- !.
component_to_tokens(qword(Words), Words) :- !.
component_to_tokens(subject(Words), Words) :- !.
component_to_tokens(verb(Words), Words) :- !.
component_to_tokens(complement(Words), Words) :- !.
component_to_tokens(auxiliary(Words), Words) :- !.
component_to_tokens(negation(Words), Words) :- !.
component_to_tokens(_, []).