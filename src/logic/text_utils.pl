:- encoding(utf8).

% ===============================================
% TEXT_UTILS.PL - Shared Text Processing Utilities
% ===============================================
% Note: This file provides text processing utilities
% It depends on: numeros.pl (preprocesar) and traductor.pl (traducir_oracion)
% IMPORTANT: These dependencies must be loaded BEFORE this file

% =============================================================================
% STRING TO WORD LIST
% =============================================================================

string_to_word_list(String, WordList) :-
    string_lower(String, LowerCase),
    split_string(LowerCase, " ", " \t\n", Parts),
    maplist(split_punctuation, Parts, NestedTokens),
    flatten(NestedTokens, FlatTokens),
    filter_empty(FlatTokens, FilteredTokens),
    maplist(atom_string, WordList, FilteredTokens).

% =============================================================================
% FILTER EMPTY STRINGS
% =============================================================================

filter_empty([], []).
filter_empty([H|T], Result) :-
    (H = "" ; H = empty),
    !,
    filter_empty(T, Result).
filter_empty([H|T], [H|Result]) :-
    filter_empty(T, Result).

% =============================================================================
% SPLIT PUNCTUATION
% =============================================================================

split_punctuation("", [empty]) :- !.
split_punctuation(Word, Tokens) :-
    string_chars(Word, Chars),
    (   append(WordChars, [Last], Chars),
        member(Last, ['.', ',', '?', '!', ';', ':'])
    ->  string_chars(Stem, WordChars),
        ( Stem = "" -> Tokens = [Last] ; Tokens = [Stem, Last] )
    ;   Tokens = [Word]
    ), !.

% =============================================================================
% PROCESS COMPLETE INPUT (handles single or two-sentence inputs)
% =============================================================================

procesar_input_completo(InputStr, LangOrigen, LangDestino, Traduccion) :-
    string_lower(InputStr, StringLower),

    % Check if contains period (two sentences)
    (sub_string(StringLower, Before, _, After, "."), After > 0 ->
        % Split into two sentences
        sub_string(StringLower, 0, Before, _, Sentence1Str),
        BeforeAfter is Before + 1,
        sub_string(StringLower, BeforeAfter, _, 0, Sentence2Str),

        % Trim whitespace
        normalize_space(string(Sent1Clean), Sentence1Str),
        normalize_space(string(Sent2Clean), Sentence2Str),

        % Translate both sentences
        traducir_oracion_completa(Sent1Clean, LangOrigen, LangDestino, Trad1),
        traducir_oracion_completa(Sent2Clean, LangOrigen, LangDestino, Trad2),

        % Combine with period
        append(Trad1, ['.'], Trad1Punto),
        append(Trad1Punto, Trad2, Traduccion)
    ;
        % Single sentence
        traducir_oracion_completa(StringLower, LangOrigen, LangDestino, Traduccion)
    ).

% Helper to translate a complete sentence
traducir_oracion_completa(OracionStr, LangOrigen, LangDestino, Traduccion) :-
    string_to_word_list(OracionStr, Tokens),
    preprocesar(LangOrigen, Tokens, Preprocesado),
    traducir_oracion(Preprocesado, LangOrigen, LangDestino, Traduccion).
