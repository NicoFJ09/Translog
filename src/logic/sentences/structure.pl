% ===============================================
% SENTENCE STRUCTURE
% Reordena componentes según idioma destino
% Trabaja con componentes TIPADOS
% ===============================================

:- consult('../../database/DB.pl').
:- consult('classifier.pl').

% =============================================================================
% ESTRUCTURACIÓN PRINCIPAL
% =============================================================================

% structure(+Classification, +TargetLanguage, -StructuredComponents)
% Retorna componentes reordenados pero SIN traducir todavía
structure(classification(Type, Components, SourceLang), TargetLang, Structured) :-
    structure_by_type(Type, Components, SourceLang, TargetLang, Structured).


% =============================================================================
% ESTRUCTURACIÓN POR TIPO
% =============================================================================

% PHRASE: no reordenar
structure_by_type(phrase, Components, _, _, Components).

% STATEMENT: reordenar adjetivos
structure_by_type(statement, Components, SourceLang, TargetLang, Structured) :-
    member(subject(Subject), Components),
    member(verb(Verb), Components),
    member(complement(Complement), Components),
    member(punct(Punct), Components),
    
    % Reordenar sujeto (adjetivos)
    reorder_noun_phrase(Subject, SourceLang, TargetLang, NewSubject),
    
    % Reordenar complemento
    reorder_complement(Complement, SourceLang, TargetLang, NewComplement),
    
    Structured = [subject(NewSubject), verb(Verb), complement(NewComplement), punct(Punct)].

% QUESTION: ajustar signos
structure_by_type(question, Components, SourceLang, TargetLang, Structured) :-
    adjust_question_structure(Components, SourceLang, TargetLang, Structured).

% NEGATIVE: ajustar auxiliares
structure_by_type(negative, Components, SourceLang, TargetLang, Structured) :-
    adjust_negative_structure(Components, SourceLang, TargetLang, Structured).


% =============================================================================
% REORDENAMIENTO DE SINTAGMAS NOMINALES
% =============================================================================

% reorder_noun_phrase(+TypedPhrase, +SourceLang, +TargetLang, -Reordered)

% Inglés -> Español: [Art, Adj, Noun] -> [Art, Noun, Adj]
reorder_noun_phrase([word(Art, article), word(Adj, adjective), word(Noun, NounType)],
                    english, spanish,
                    [word(Art, article), word(Noun, NounType), word(Adj, adjective)]) :- !.

% Español -> Inglés: [Art, Noun, Adj] -> [Art, Adj, Noun]
reorder_noun_phrase([word(Art, article), word(Noun, NounType), word(Adj, adjective)],
                    spanish, english,
                    [word(Art, article), word(Adj, adjective), word(Noun, NounType)]) :- !.

% Mismo idioma o sin adjetivo: no cambiar
reorder_noun_phrase(Phrase, _, _, Phrase).


% reorder_complement(+TypedComplement, +SourceLang, +TargetLang, -Reordered)
reorder_complement(Complement, _, _, Complement).  % Por ahora


% =============================================================================
% AJUSTE DE PREGUNTAS
% =============================================================================

% adjust_question_structure(+Components, +SourceLang, +TargetLang, -Adjusted)

adjust_question_structure(Components, english, spanish, Adjusted) :-
    % Agregar ¿ al inicio
    member(closing(Close), Components),
    select(opening(_), Components, opening(['¿']), TempComponents),
    select(closing(Close), TempComponents, closing(Close), Adjusted), !.

adjust_question_structure(Components, spanish, english, Adjusted) :-
    % Quitar ¿ del inicio
    select(opening(_), Components, opening([]), Adjusted), !.

adjust_question_structure(Components, _, _, Components).


% =============================================================================
% AJUSTE DE NEGATIVAS
% =============================================================================

% adjust_negative_structure(+Components, +SourceLang, +TargetLang, -Adjusted)

% Inglés -> Español: quitar auxiliar "do"
adjust_negative_structure(Components, english, spanish, Adjusted) :-
    select(auxiliary([word(Aux, auxiliary)]), Components, TempComponents),
    member(Aux, [do, does, did]),
    select(negation([word(not, negative)]), TempComponents, 
           negation([word(no, negative)]), Adjusted), !.

% Español -> Inglés: agregar auxiliar "do"
adjust_negative_structure(Components, spanish, english, Adjusted) :-
    select(negation([word(no, negative)]), Components,
           negation([word(not, negative)]), TempComponents),
    member(subject(Subject), TempComponents),
    select(subject(Subject), TempComponents,
           [subject(Subject), auxiliary([word(do, auxiliary)])], AdjustedList),
    flatten(AdjustedList, Adjusted), !.

adjust_negative_structure(Components, _, _, Components).