:- encoding(utf8).

% ===============================================
% TEXT_UTILS.PL - Shared Text Processing Utilities
% ===============================================
% Note: This file provides text processing utilities
% It depends on: numeros.pl (preprocesar) and traductor.pl (traducir_oracion)
% IMPORTANT: These dependencies must be loaded BEFORE this file

/*
 * string_to_word_list(+String, -WordList)
 * 
 * Summary: Convierte un string en una lista de palabras (tokens).
 * Convierte a minúsculas, divide por espacios, y maneja puntuación.
 * 
 * @param String      - String a procesar (ej: "The cat eats fish")
 * @return WordList   - Lista de palabras [the, cat, eats, fish]
 * 
 * Ejemplos:
 *   ?- string_to_word_list("The cat eats", L).
 *   L = [the, cat, eats].
 *   
 *   ?- string_to_word_list("Hello, world!", L).
 *   L = [hello, ',', world, '!'].
 */
string_to_word_list(String, WordList) :-
    string_lower(String, LowerCase),
    split_string(LowerCase, " ", " \t\n", Parts),
    maplist(split_punctuation, Parts, NestedTokens),
    flatten(NestedTokens, FlatTokens),
    filter_empty(FlatTokens, FilteredTokens),
    maplist(atom_string, WordList, FilteredTokens).

/*
 * filter_empty(+List, -FilteredList)
 * 
 * Summary: Filtra strings vacíos de una lista.
 * 
 * @param List          - Lista a filtrar
 * @return FilteredList - Lista sin strings vacíos
 * 
 * Ejemplos:
 *   ?- filter_empty(["hello", "", "world"], L).
 *   L = [hello, world].
 */
filter_empty([], []).
filter_empty([H|T], Result) :-
    (H = "" ; H = empty),
    !,
    filter_empty(T, Result).
filter_empty([H|T], [H|Result]) :-
    filter_empty(T, Result).

/*
 * split_punctuation(+Word, -Tokens)
 * 
 * Summary: Separa la puntuación de una palabra.
 * Si la palabra termina con . , ? ! ; : se separa en [palabra, puntuación]
 * 
 * @param Word    - Palabra posiblemente con puntuación (ej: "hello.", "cat!")
 * @return Tokens - Lista [palabra, puntuación] o solo [palabra]
 * 
 * Ejemplos:
 *   ?- split_punctuation("hello.", T).
 *   T = [hello, '.'].
 *   
 *   ?- split_punctuation("hello", T).
 *   T = [hello].
 */
split_punctuation("", [empty]) :- !.
split_punctuation(Word, Tokens) :-
    string_chars(Word, Chars),
    (   append(WordChars, [Last], Chars),
        member(Last, ['.', ',', '?', '!', ';', ':'])
    ->  string_chars(Stem, WordChars),
        ( Stem = "" -> Tokens = [Last] ; Tokens = [Stem, Last] )
    ;   Tokens = [Word]
    ), !.

/*
 * procesar_input_completo(+InputStr, +LangOrigen, +LangDestino, -Traduccion)
 * 
 * Summary: Procesa una entrada completa que puede contener una o dos oraciones.
 * Si hay punto (.), divide en dos oraciones, traduce cada una por separado, y las une.
 * 
 * @param InputStr    - String de entrada (ej: "hola. cómo estás?")
 * @param LangOrigen  - Idioma origen (spanish, english)
 * @param LangDestino - Idioma destino (spanish, english)
 * @return Traduccion - Lista de palabras traducidas
 * 
 * Ejemplos:
 *   ?- procesar_input_completo("hello. how are you?", english, spanish, T).
 *   T = [hola, '.', cómo, estás, '?'].
 */
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

/*
 * traducir_oracion_completa(+OracionStr, +LangOrigen, +LangDestino, -Traduccion)
 * 
 * Summary: Traduce una oración completa procesando tokens y aplicando reglas de traduccción.
 * 
 * @param OracionStr  - String de la oración (ej: "the cat eats")
 * @param LangOrigen  - Idioma origen
 * @param LangDestino - Idioma destino
 * @return Traduccion - Lista de palabras traducidas
 */
% Helper to translate a complete sentence
traducir_oracion_completa(OracionStr, LangOrigen, LangDestino, Traduccion) :-
    string_to_word_list(OracionStr, Tokens),
    preprocesar(LangOrigen, Tokens, Preprocesado),
    traducir_oracion(Preprocesado, LangOrigen, LangDestino, Traduccion).
