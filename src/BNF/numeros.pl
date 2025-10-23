:- encoding(utf8).

% Convertir número a palabra (0-199)
numero_a_palabra(N, Lang, Palabra) :-
    integer(N),
    N >= 0, N =< 199,
    ( Lang = english -> numero_ingles(N, Palabra)
    ; Lang = spanish -> numero_espanol(N, Palabra)
    ).

% Números en inglés 0-19
numero_ingles(0, zero).
numero_ingles(1, one).
numero_ingles(2, two).
numero_ingles(3, three).
numero_ingles(4, four).
numero_ingles(5, five).
numero_ingles(6, six).
numero_ingles(7, seven).
numero_ingles(8, eight).
numero_ingles(9, nine).
numero_ingles(10, ten).
numero_ingles(11, eleven).
numero_ingles(12, twelve).
numero_ingles(13, thirteen).
numero_ingles(14, fourteen).
numero_ingles(15, fifteen).
numero_ingles(16, sixteen).
numero_ingles(17, seventeen).
numero_ingles(18, eighteen).
numero_ingles(19, nineteen).

% Decenas en inglés
numero_ingles(20, twenty).
numero_ingles(30, thirty).
numero_ingles(40, forty).
numero_ingles(50, fifty).
numero_ingles(60, sixty).
numero_ingles(70, seventy).
numero_ingles(80, eighty).
numero_ingles(90, ninety).

% 21-99
numero_ingles(N, Palabra) :-
    N > 20, N < 100,
    Decenas is (N // 10) * 10,
    Unidades is N mod 10,
    numero_ingles(Decenas, PalabraDecenas),
    numero_ingles(Unidades, PalabraUnidades),
    atom_concat(PalabraDecenas, '-', Temp),
    atom_concat(Temp, PalabraUnidades, Palabra).

% 100-199
numero_ingles(N, Palabra) :-
    N >= 100, N < 200,
    ( N = 100 -> Palabra = 'one hundred'
    ; Resto is N - 100,
      numero_ingles(Resto, PalabraResto),
      atom_concat('one hundred ', PalabraResto, Palabra)
    ).

% Números en español 0-19
numero_espanol(0, cero).
numero_espanol(1, uno).
numero_espanol(2, dos).
numero_espanol(3, tres).
numero_espanol(4, cuatro).
numero_espanol(5, cinco).
numero_espanol(6, seis).
numero_espanol(7, siete).
numero_espanol(8, ocho).
numero_espanol(9, nueve).
numero_espanol(10, diez).
numero_espanol(11, once).
numero_espanol(12, doce).
numero_espanol(13, trece).
numero_espanol(14, catorce).
numero_espanol(15, quince).
numero_espanol(16, dieciseis).
numero_espanol(17, diecisiete).
numero_espanol(18, dieciocho).
numero_espanol(19, diecinueve).

% Decenas en español
numero_espanol(20, veinte).
numero_espanol(30, treinta).
numero_espanol(40, cuarenta).
numero_espanol(50, cincuenta).
numero_espanol(60, sesenta).
numero_espanol(70, setenta).
numero_espanol(80, ochenta).
numero_espanol(90, noventa).

% 21-29 (veinti-)
numero_espanol(N, Palabra) :-
    N > 20, N < 30,
    Unidades is N mod 10,
    numero_espanol(Unidades, PalabraUnidades),
    atom_concat(veinti, PalabraUnidades, Palabra).

% 31-99
numero_espanol(N, Palabra) :-
    N > 30, N < 100,
    Decenas is (N // 10) * 10,
    Unidades is N mod 10,
    numero_espanol(Decenas, PalabraDecenas),
    numero_espanol(Unidades, PalabraUnidades),
    atom_concat(PalabraDecenas, ' y ', Temp),
    atom_concat(Temp, PalabraUnidades, Palabra).

% 100-199
numero_espanol(N, Palabra) :-
    N >= 100, N < 200,
    ( N = 100 -> Palabra = cien
    ; Resto is N - 100,
      numero_espanol(Resto, PalabraResto),
      atom_concat('ciento ', PalabraResto, Palabra)
    ).

% Detectar si un token es número
es_numero(Token) :-
    atom(Token),
    atom_number(Token, N),
    integer(N),
    N >= 0, N =< 199.

% Procesar lista de tokens reemplazando números
procesar_numeros([], _, []).
procesar_numeros([Token|Resto], Lang, [Palabra|RestoProc]) :-
    es_numero(Token),
    atom_number(Token, N),
    numero_a_palabra(N, Lang, Palabra),
    procesar_numeros(Resto, Lang, RestoProc).
procesar_numeros([Token|Resto], Lang, [Token|RestoProc]) :-
    \+ es_numero(Token),
    procesar_numeros(Resto, Lang, RestoProc).

% Procesar numero
preprocesar(Lang, Input, Output) :-
    procesar_numeros(Input, Lang, Output).
