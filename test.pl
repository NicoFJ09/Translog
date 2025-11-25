:- encoding(utf8).

:- consult('src/database/DB.pl').
:- consult('src/logic/sintagmas.pl').
:- consult('src/logic/conjugador.pl').
:- consult('src/logic/traductor.pl').
:- consult('src/BNF/numeros.pl').
:- consult('src/logic/text_utils.pl').

% ===============================================
% TEST_SUITE.PL - SIMPLIFICADO
% ===============================================

run_all_tests :-
    write('╔════════════════════════════════════════════════════════════╗'), nl,
    write('║          TRANSLOG - SUITE DE PRUEBAS COMPLETA             ║'), nl,
    write('╚════════════════════════════════════════════════════════════╝'), nl, nl,
    test_spanish_to_english,
    nl, nl,
    test_english_to_spanish,
    nl, nl,
    test_interrogativas,
    nl, nl,
    test_edge_cases,
    nl, nl,
    test_advanced_realistic,
    nl, nl,
    write('╔════════════════════════════════════════════════════════════╗'), nl,
    write('║                    PRUEBAS COMPLETADAS                     ║'), nl,
    write('╚════════════════════════════════════════════════════════════╝'), nl.

% =============================================================================
% TESTS: ESPAÑOL → INGLÉS
% =============================================================================

test_spanish_to_english :-
    write('═══════════════════════════════════════════════════════════'), nl,
    write('CATEGORÍA 1: ESPAÑOL → INGLÉS'), nl,
    write('═══════════════════════════════════════════════════════════'), nl, nl,
    
    write('--- Pronombres + Verbos ---'), nl,
    test_case('yo como', spanish, english, 1),
    test_case('tu comes', spanish, english, 2),
    test_case('el come', spanish, english, 3),
    test_case('ella come', spanish, english, 4),
    test_case('nosotros comemos', spanish, english, 5),
    test_case('ellos comen', spanish, english, 6),
    nl,
    
    write('--- Sintagmas Nominales Simples ---'), nl,
    test_case('el gato', spanish, english, 7),
    test_case('la casa', spanish, english, 8),
    test_case('los perros', spanish, english, 9),
    test_case('un libro', spanish, english, 10),
    nl,
    
    write('--- Sintagmas Nominales con Adjetivos ---'), nl,
    test_case('el gato grande', spanish, english, 11),
    test_case('la casa bonita', spanish, english, 12),
    test_case('un libro nuevo', spanish, english, 13),
    nl,
    
    write('--- Oraciones Simples (SN + Verbo) ---'), nl,
    test_case('el gato come', spanish, english, 14),
    test_case('la nina canta', spanish, english, 15),
    test_case('yo trabajo', spanish, english, 16),
    nl,
    
    write('--- Oraciones Completas (SN + Verbo + SN) ---'), nl,
    test_case('el gato come pescado', spanish, english, 17),
    test_case('yo como pan', spanish, english, 18),
    test_case('la nina lee un libro', spanish, english, 19),
    test_case('el perro grande bebe agua', spanish, english, 20),
    nl,
    
    write('--- Verbos Irregulares ---'), nl,
    test_case('yo soy feliz', spanish, english, 21),
    test_case('tu eres inteligente', spanish, english, 22),
    test_case('el esta cansado', spanish, english, 23),
    test_case('nosotros vamos a la escuela', spanish, english, 24),
    test_case('ellos tienen un perro', spanish, english, 25),
    nl,
    
    write('--- Con Adverbios ---'), nl,
    test_case('yo como mucho', spanish, english, 26),
    test_case('el corre rapido', spanish, english, 27),
    nl,
    
    write('--- Con Preposiciones ---'), nl,
    test_case('el gato esta en la casa', spanish, english, 28),
    test_case('yo voy a la escuela', spanish, english, 29),
    nl,
    
    write('--- Frases Comunes ---'), nl,
    test_case('hola', spanish, english, 30),
    test_case('gracias', spanish, english, 31).

test_english_to_spanish :-
    write('═══════════════════════════════════════════════════════════'), nl,
    write('CATEGORÍA 2: INGLÉS → ESPAÑOL'), nl,
    write('═══════════════════════════════════════════════════════════'), nl, nl,
    
    write('--- Pronombres + Verbos ---'), nl,
    test_case('i eat', english, spanish, 32),
    test_case('you eat', english, spanish, 33),
    test_case('he eats', english, spanish, 34),
    test_case('she eats', english, spanish, 35),
    test_case('we eat', english, spanish, 36),
    test_case('they eat', english, spanish, 37),
    nl,
    
    write('--- Sintagmas Nominales Simples ---'), nl,
    test_case('the cat', english, spanish, 38),
    test_case('the house', english, spanish, 39),
    test_case('a book', english, spanish, 40),
    nl,
    
    write('--- Sintagmas Nominales con Adjetivos ---'), nl,
    test_case('the big cat', english, spanish, 41),
    test_case('the pretty house', english, spanish, 42),
    test_case('a new book', english, spanish, 43),
    nl,
    
    write('--- Oraciones Simples ---'), nl,
    test_case('the cat eats', english, spanish, 44),
    test_case('the girl sings', english, spanish, 45),
    test_case('i work', english, spanish, 46),
    nl,
    
    write('--- Oraciones Completas ---'), nl,
    test_case('the cat eats fish', english, spanish, 47),
    test_case('i eat bread', english, spanish, 48),
    test_case('the girl reads a book', english, spanish, 49),
    test_case('the big dog drinks water', english, spanish, 50),
    nl,
    
    write('--- Verbos Irregulares ---'), nl,
    test_case('i am happy', english, spanish, 51),
    test_case('you are intelligent', english, spanish, 52),
    test_case('he is tired', english, spanish, 53),
    test_case('we go to school', english, spanish, 54),
    test_case('they have a dog', english, spanish, 55),
    nl,
    
    write('--- Con Adverbios ---'), nl,
    test_case('i eat much', english, spanish, 56),
    test_case('he runs fast', english, spanish, 57),
    nl,
    
    write('--- Con Preposiciones ---'), nl,
    test_case('the cat is in the house', english, spanish, 58),
    test_case('i go to school', english, spanish, 59).

test_interrogativas :-
    write('═══════════════════════════════════════════════════════════'), nl,
    write('CATEGORÍA 3: ORACIONES INTERROGATIVAS'), nl,
    write('═══════════════════════════════════════════════════════════'), nl, nl,
    
    write('--- Español → Inglés ---'), nl,
    test_case('como estas', spanish, english, 60),
    test_case('que comes', spanish, english, 61),
    test_case('donde vives', spanish, english, 62),
    test_case('quien es el', spanish, english, 63),
    nl,
    
    write('--- Inglés → Español ---'), nl,
    test_case('how are you', english, spanish, 64),
    test_case('what do you eat', english, spanish, 65),
    test_case('where do you live', english, spanish, 66),
    test_case('who is he', english, spanish, 67).

test_edge_cases :-
    write('═══════════════════════════════════════════════════════════'), nl,
    write('CATEGORÍA 4: CASOS ESPECIALES'), nl,
    write('═══════════════════════════════════════════════════════════'), nl, nl,

    write('--- Ambigüedad "el" ---'), nl,
    test_case('el come pan', spanish, english, 68),
    test_case('el gato come', spanish, english, 69),
    test_case('el es grande', spanish, english, 70),
    test_case('el perro es grande', spanish, english, 71),
    nl,

    write('--- Números (ya procesados) ---'), nl,
    test_case('yo tengo 5 gatos', spanish, english, 72),
    test_case('i have 3 dogs', english, spanish, 73),
    nl,

    write('--- Oraciones Largas ---'), nl,
    test_case('el gato grande come pescado en la casa', spanish, english, 74),
    test_case('yo como pan con queso', spanish, english, 75),
    nl,

    write('--- Con Puntuación ---'), nl,
    test_case('hola.', spanish, english, 76),
    test_case('como estas?', spanish, english, 77),
    test_case('yo como pan.', spanish, english, 78),
    nl,

    write('--- Dos Oraciones (REQUISITO CLAVE) ---'), nl,
    test_case('hola. como estas', spanish, english, 79),
    test_case('yo como. tu bebes', spanish, english, 80),
    test_case('el gato come. el perro bebe', spanish, english, 81).

test_advanced_realistic :-
    write('═══════════════════════════════════════════════════════════'), nl,
    write('CATEGORÍA 5: ORACIONES COMPLEJAS REALISTAS'), nl,
    write('═══════════════════════════════════════════════════════════'), nl, nl,

    write('--- Conversaciones Cotidianas (Español → Inglés) ---'), nl,
    test_case('el perro grande corre rapido', spanish, english, 82),
    test_case('la nina bonita lee un libro nuevo', spanish, english, 83),
    test_case('yo trabajo con mi amigo', spanish, english, 84),
    test_case('nosotros comemos pan y queso', spanish, english, 85),
    test_case('el esta muy cansado hoy', spanish, english, 86),
    nl,

    write('--- Descripciones Complejas (Español → Inglés) ---'), nl,
    test_case('el gato negro come pescado en la casa grande', spanish, english, 87),
    test_case('la mujer inteligente lee un libro dificil', spanish, english, 88),
    test_case('el perro pequeno bebe agua fria', spanish, english, 89),
    test_case('yo tengo un libro viejo y un libro nuevo', spanish, english, 90),
    nl,

    write('--- Frases de Ubicación y Estado (Español → Inglés) ---'), nl,
    test_case('el gato esta en la mesa', spanish, english, 91),
    test_case('la nina esta con su madre', spanish, english, 92),
    test_case('yo estoy en la escuela ahora', spanish, english, 93),
    test_case('el libro esta sobre la mesa', spanish, english, 94),
    nl,

    write('--- Conversaciones Cotidianas (Inglés → Español) ---'), nl,
    test_case('the big dog runs very fast', english, spanish, 95),
    test_case('the pretty girl reads a new book', english, spanish, 96),
    test_case('i work with my friend', english, spanish, 97),
    test_case('we eat bread and cheese', english, spanish, 98),
    test_case('he is very tired today', english, spanish, 99),
    nl,

    write('--- Descripciones Complejas (Inglés → Español) ---'), nl,
    test_case('the black cat eats fish in the big house', english, spanish, 100),
    test_case('the intelligent woman reads a difficult book', english, spanish, 101),
    test_case('the small dog drinks cold water', english, spanish, 102),
    test_case('i have an old book and a new book', english, spanish, 103),
    nl,

    write('--- Frases de Ubicación y Estado (Inglés → Español) ---'), nl,
    test_case('the cat is on the table', english, spanish, 104),
    test_case('the girl is with her mother', english, spanish, 105),
    test_case('i am at school now', english, spanish, 106),
    test_case('the book is on the table', english, spanish, 107),
    nl,

    write('--- Oraciones con Múltiples Complementos ---'), nl,
    test_case('yo como pan con queso en la casa', spanish, english, 108),
    test_case('el perro grande bebe agua fria en el parque', spanish, english, 109),
    test_case('i eat bread with cheese at home', english, spanish, 110),
    test_case('the big dog drinks cold water in the park', english, spanish, 111),
    nl,

    write('--- Secuencias Conversacionales Realistas ---'), nl,
    test_case('hola. yo soy tu amigo', spanish, english, 112),
    test_case('el gato es grande. el perro es pequeno', spanish, english, 113),
    test_case('yo como pan. tu bebes agua', spanish, english, 114),
    test_case('hello. i am your friend', english, spanish, 115),
    test_case('the cat is big. the dog is small', english, spanish, 116),
    test_case('i eat bread. you drink water', english, spanish, 117),
    nl,

    write('--- Frases con Adverbios y Conjunciones ---'), nl,
    test_case('yo siempre como mucho', spanish, english, 118),
    test_case('el nunca bebe cafe', spanish, english, 119),
    test_case('ella es muy inteligente', spanish, english, 120),
    test_case('i always eat much', english, spanish, 121),
    test_case('he never drinks coffee', english, spanish, 122),
    test_case('she is very intelligent', english, spanish, 123),
    nl,

    write('--- CONVERSACIONALES REALISTAS (Vocabulario Expandido) ---'), nl,
    
    write('- Estados y Sentimientos -'), nl,
    test_case('yo tengo mucho sueno', spanish, english, 124),
    test_case('ella tiene hambre', spanish, english, 125),
    test_case('yo estoy muy cansado', spanish, english, 126),
    test_case('el esta muy feliz hoy', spanish, english, 127),
    test_case('i am very sleepy', english, spanish, 128),
    test_case('she is very hungry', english, spanish, 129),
    test_case('we are very tired', english, spanish, 130),
    nl,

    write('- Actividades Diarias -'), nl,
    test_case('yo como el desayuno', spanish, english, 131),
    test_case('nosotros tenemos un examen hoy', spanish, english, 132),
    test_case('ella va a la fiesta', spanish, english, 133),
    test_case('el hace la tarea', spanish, english, 134),
    test_case('i eat breakfast', english, spanish, 135),
    test_case('we have an exam today', english, spanish, 136),
    test_case('she goes to the party', english, spanish, 137),
    nl,

    write('- Lugares y Movimiento -'), nl,
    test_case('yo voy a la playa', spanish, english, 138),
    test_case('ella esta en la playa', spanish, english, 139),
    test_case('nosotros vamos a la escuela', spanish, english, 140),
    test_case('el trabaja en el banco', spanish, english, 141),
    test_case('i go to the beach', english, spanish, 142),
    test_case('she is at the beach', english, spanish, 143),
    test_case('we go to the school', english, spanish, 144),
    nl,

    write('- Tecnologia y Modernidad -'), nl,
    test_case('yo uso el celular', spanish, english, 145),
    test_case('ella lee el correo', spanish, english, 146),
    test_case('nosotros miramos la pelicula', spanish, english, 147),
    test_case('el escucha la musica', spanish, english, 148),
    test_case('i use the cellphone', english, spanish, 149),
    test_case('she reads the email', english, spanish, 150),
    test_case('we watch the movie', english, spanish, 151),
    nl,

    write('- Compras y Dinero -'), nl,
    test_case('yo compro un regalo', spanish, english, 152),
    test_case('el paga con tarjeta', spanish, english, 153),
    test_case('ella necesita dinero', spanish, english, 154),
    test_case('i buy a gift', english, spanish, 155),
    test_case('he pays with credit card', english, spanish, 156),
    test_case('she needs money', english, spanish, 157),
    nl,

    write('- Conversaciones Complejas Realistas -'), nl,
    test_case('yo tengo mucho sueno y estoy cansado', spanish, english, 158),
    test_case('ella va a la fiesta', spanish, english, 159),
    test_case('nosotros comemos el desayuno en la cocina', spanish, english, 160),
    test_case('yo siempre uso el celular', spanish, english, 161),
    test_case('i am very sleepy', english, spanish, 162),
    test_case('she goes to the party', english, spanish, 163),
    test_case('we eat breakfast in the kitchen', english, spanish, 164),
    test_case('i always use the cellphone', english, spanish, 165).

% =============================================================================
% FUNCIÓN AUXILIAR
% =============================================================================

test_case(Input, LangOrigen, LangDestino, NumeroTest) :-
    write('Test #'), write(NumeroTest), write(': '), nl,
    write('  Input:  "'), write(Input), write('"'), nl,

    catch(
        call_with_time_limit(
            2.0,
            (
                procesar_input_completo(Input, LangOrigen, LangDestino, Traduccion),
                atomic_list_concat(Traduccion, ' ', OutputStr),
                write('  Output: "'), write(OutputStr), write('"')
            )
        ),
        Error,
        (
            write('  Output: ERROR - '),
            (Error = time_limit_exceeded ->
                write('TIMEOUT')
            ;
                write(Error)
            )
        )
    ),
    nl, !.

test_case(Input, _, _, NumeroTest) :-
    write('Test #'), write(NumeroTest), write(': '), nl,
    write('  Input:  "'), write(Input), write('"'), nl,
    write('  Output: FAILED'), nl, nl.

% Note: String processing utilities are now in text_utils.pl