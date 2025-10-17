% ===============================================
% SENTENCE CLASSIFIER
% ===============================================

:- consult('../../database/DB.pl').


% Si la oración inicia con un saludo o frase común, sepáralo y clasifica el resto
classify([First|Rest], classification(mixed, [fixed([First])|OtherComponents])) :-
    (common_phrase(First, _) ; common_phrase(_, First)),
    Rest \= [],
    classify(Rest, classification(Type, OtherComponents)),
    Type \= phrase, !.

classify(Tokens, classification(Type, Components)) :-
    classify_type(Tokens, Type),
    extract_components(Tokens, Type, Components).

classify_type(Tokens, phrase) :-
    remove_punctuation(Tokens, Clean),
    length(Clean, Len),
    Len =< 2,
    Clean = [First|_],
    (common_phrase(First, _) ; common_phrase(_, First)), !.

classify_type(Tokens, question) :-
    (member('?', Tokens) ; member('¿', Tokens)), !.

classify_type(Tokens, negative) :-
    member(Word, Tokens),
    (negative(Word, _) ; negative(_, Word)), !.

classify_type(_, statement).

extract_components(Tokens, phrase, [fixed(Tokens)]).

extract_components(Tokens, statement, Components) :-
    remove_final_punct(Tokens, Punct, WithoutPunct),
    extract_subject(WithoutPunct, Subject, Rest1),
    extract_verb(Rest1, Verb, Rest2),
    extract_complement(Rest2, Complement),
    Components = [subject(Subject), verb(Verb), complement(Complement), punct(Punct)].

extract_components(Tokens, question, Components) :-
    remove_punct_marks(Tokens, OpenPunct, ClosePunct, Clean),
    (starts_with_qword(Clean) ->
        extract_wh_question(Clean, Comp)
    ;
        extract_yn_question(Clean, Comp)
    ),
    append([[opening(OpenPunct)], Comp, [closing(ClosePunct)]], Components).

extract_components(Tokens, negative, Components) :-
    remove_final_punct(Tokens, Punct, WithoutPunct),
    extract_subject(WithoutPunct, Subject, Rest1),
    extract_auxiliary(Rest1, Aux, Rest2),
    extract_negation(Rest2, Neg, Rest3),
    extract_verb(Rest3, Verb, Rest4),
    extract_complement(Rest4, Complement),
    Components = [subject(Subject), auxiliary(Aux), negation(Neg), 
                  verb(Verb), complement(Complement), punct(Punct)].

extract_subject([Art, Adj, Noun|Rest], [Art, Adj, Noun], Rest) :-
    is_article(Art),
    is_adjective(Adj),
    is_noun(Noun), !.

extract_subject([Art, Noun|Rest], [Art, Noun], Rest) :-
    is_article(Art),
    is_noun(Noun), !.

extract_subject([Word|Rest], [Word], Rest) :-
    is_pronoun(Word), !.

extract_subject([Quant, Noun|Rest], [Quant, Noun], Rest) :-
    is_quantifier(Quant),
    is_noun(Noun), !.

extract_subject(Tokens, [], Tokens).

extract_verb([Verb|Rest], [Verb], Rest) :-
    is_verb(Verb), !.
extract_verb(Tokens, [], Tokens).

extract_auxiliary([Aux|Rest], [Aux], Rest) :-
    auxiliary(Aux), !.
extract_auxiliary(Tokens, [], Tokens).

extract_negation([Word|Rest], [Word], Rest) :-
    (negative(Word, _) ; negative(_, Word)), !.
extract_negation(Tokens, [], Tokens).

extract_complement([], []).
extract_complement([Token|Rest], [Token|RestTokens]) :-
    extract_complement(Rest, RestTokens).

extract_wh_question([QWord|Rest], Components) :-
    is_question_word(QWord),
    extract_verb(Rest, Verb, Rest2),
    extract_subject(Rest2, Subject, Rest3),
    extract_complement(Rest3, Complement),
    Components = [qword([QWord]), verb(Verb), subject(Subject), complement(Complement)].

extract_yn_question([Aux|Rest], Components) :-
    auxiliary(Aux),
    extract_subject(Rest, Subject, Rest2),
    extract_verb(Rest2, Verb, Rest3),
    extract_complement(Rest3, Complement),
    Components = [auxiliary([Aux]), subject(Subject), verb(Verb), complement(Complement)].

is_article(Word) :- (article(Word, _, _, _) ; article(_, Word, _, _)), !.
is_adjective(Word) :- (adjective(Word, _) ; adjective(_, Word) ; 
                       adjective(Word, _, _) ; adjective(_, Word, _)), !.
is_noun(Word) :- (noun(Word, _, _, _) ; noun(_, Word, _, _)), !.
is_pronoun(Word) :- (pronoun(Word, _, _) ; pronoun(_, Word, _)), !.
is_verb(Word) :- (irregular_form(Word, _, _, _) ; 
                  verb_infinitive(Word, _, _) ; 
                  verb_infinitive(_, Word, _) ;
                  spanish_verb(Word, _)), !.
is_quantifier(Word) :- (quantifier(Word, _, _, _) ; quantifier(_, Word, _, _)), !.
is_question_word(Word) :- (question_word(Word, _) ; question_word(_, Word)), !.

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

starts_with_qword([Word|_]) :- is_question_word(Word).