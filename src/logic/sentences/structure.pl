% ===============================================
% SENTENCE STRUCTURE
% ===============================================

:- consult('../../database/DB.pl').
:- consult('classifier.pl').

structure(classification(Type, Components), SourceLang, TargetLang, Structured) :-
    structure_by_type(Type, Components, SourceLang, TargetLang, Structured).

structure_by_type(phrase, Components, _, _, Components).

structure_by_type(statement, Components, SourceLang, TargetLang, Structured) :-
    member(subject(Subject), Components),
    member(verb(Verb), Components),
    member(complement(Complement), Components),
    member(punct(Punct), Components),
    reorder_subject(Subject, SourceLang, TargetLang, NewSubject),
    reorder_complement(Complement, SourceLang, TargetLang, NewComplement),
    Structured = [subject(NewSubject), verb(Verb), complement(NewComplement), punct(Punct)].

structure_by_type(question, Components, SourceLang, TargetLang, Structured) :-
    adjust_question_punct(Components, SourceLang, TargetLang, Structured).

structure_by_type(negative, Components, SourceLang, TargetLang, Structured) :-
    adjust_negative(Components, SourceLang, TargetLang, Structured).

% =============================================================================
% SUBJECT REORDERING
% =============================================================================

% [Art, Adj, Noun] - English order, keep as is
reorder_subject([Art, Adj, Noun], english, spanish, [Art, Noun, Adj]) :- !.

% [Art, Noun, Adj] - Spanish order, reorder to English
reorder_subject([Art, Noun, Adj], spanish, english, [Art, Adj, Noun]) :- !.

% Any other structure - no change
reorder_subject(Phrase, _, _, Phrase).

% =============================================================================
% COMPLEMENT REORDERING
% =============================================================================

% Single adjective in complement - if Spanish to English and there was no verb
% This handles: [el,gato,grande] where "grande" is in complement
reorder_complement([Adj], spanish, english, [Adj]) :- !.

% Any other - no change
reorder_complement(Complement, _, _, Complement).

% =============================================================================
% QUESTION PUNCTUATION
% =============================================================================

adjust_question_punct(Components, english, spanish, Adjusted) :-
    select(opening(_), Components, opening(['¿']), Adjusted), !.
adjust_question_punct(Components, spanish, english, Adjusted) :-
    select(opening(_), Components, opening([]), Adjusted), !.
adjust_question_punct(Components, _, _, Components).

% =============================================================================
% NEGATIVE ADJUSTMENT
% =============================================================================

adjust_negative(Components, english, spanish, Adjusted) :-
    select(auxiliary(_), Components, Adjusted), !.

adjust_negative(Components, spanish, english, Adjusted) :-
    member(subject(Subject), Components),
    select(subject(Subject), Components, Temp),
    Adjusted = [subject(Subject), auxiliary([do])|Temp], !.

adjust_negative(Components, _, _, Components).