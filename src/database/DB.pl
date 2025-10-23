:- encoding(utf8).

% ===============================================
% TRANSLOG DATABASE (BD.pl)
% Spanish-English Translation - Present Tense
% ===============================================

% =============================================================================
% 1. PRONOUNS
% =============================================================================
% pronoun(English, Spanish, Person)

pronoun(i, yo, first_singular).
pronoun(you, tu, second_singular).
pronoun(he, el, third_singular_masculine).
pronoun(she, ella, third_singular_feminine).
pronoun(we, nosotros, first_plural).
pronoun(they, ellos, third_plural_masculine).
pronoun(they, ellas, third_plural_feminine).

% =============================================================================
% 1.B POSSESSIVE ADJECTIVES
% =============================================================================
% possessive_adjective(English, Spanish, Person)

possessive_adjective(my, mi, first_singular).
possessive_adjective(your, tu, second_singular).
possessive_adjective(his, su, third_singular_masculine).
possessive_adjective(her, su, third_singular_feminine).
possessive_adjective(our, nuestro, first_plural).          % masculine form
possessive_adjective(our, nuestra, first_plural).          % feminine form
possessive_adjective(their, su, third_plural).

% =============================================================================
% 2. ARTICLES
% =============================================================================
% article(English, Spanish, Gender, Number)

% Definite
article(the, el, masculine, singular).
article(the, la, feminine, singular).
article(the, los, masculine, plural).
article(the, las, feminine, plural).

% Indefinite
article(a, un, masculine, singular).
article(a, una, feminine, singular).
article(some, unos, masculine, plural).
article(some, unas, feminine, plural).

% =============================================================================
% 3. NOUNS
% =============================================================================
% noun(English, Spanish, Gender, Number)

% Animals
noun(cat, gato, masculine, singular).
noun(cats, gatos, masculine, plural).
noun(dog, perro, masculine, singular).
noun(dogs, perros, masculine, plural).
noun(bird, pajaro, masculine, singular).
noun(fish, pez, masculine, singular).

% People
noun(man, hombre, masculine, singular).
noun(woman, mujer, feminine, singular).
noun(boy, nino, masculine, singular).
noun(girl, nina, feminine, singular).
noun(friend, amigo, masculine, singular).
noun(friends, amigos, masculine, plural).

% Things
noun(house, casa, feminine, singular).
noun(houses, casas, feminine, plural).
noun(car, coche, masculine, singular).
noun(cars, coches, masculine, plural).
noun(book, libro, masculine, singular).
noun(books, libros, masculine, plural).
noun(table, mesa, feminine, singular).
noun(tables, mesas, feminine, plural).
noun(chair, silla, feminine, singular).
noun(chairs, sillas, feminine, plural).

% Food
noun(food, comida, feminine, singular).
noun(water, agua, feminine, singular).
noun(bread, pan, masculine, singular).
noun(apple, manzana, feminine, singular).
noun(coffee, cafe, masculine, singular).
noun(rice, arroz, masculine, singular).
noun(fish, pescado, masculine, singular).

% Places
noun(park, parque, masculine, singular).
noun(school, escuela, feminine, singular).
noun(city, ciudad, feminine, singular).

% Abstract
noun(day, dia, masculine, singular).
noun(night, noche, feminine, singular).
noun(life, vida, feminine, singular).
noun(name, nombre, masculine, singular).
noun(animal, animal, masculine, singular).
noun(animals, animales, masculine, plural).
noun(brother, hermano, masculine, singular).
noun(brothers, hermanos, masculine, plural).
noun(sister, hermana, feminine, singular).
noun(sisters, hermanas, feminine, plural).

% =============================================================================
% 4. ADJECTIVES
% =============================================================================
% adjective(English, Spanish, Gender, Number)

% Invariable (same form for masculine/feminine) - duplicated for both genders
adjective(big, grande, masculine, singular).
adjective(big, grande, feminine, singular).
adjective(big, grandes, masculine, plural).
adjective(big, grandes, feminine, plural).

adjective(happy, feliz, masculine, singular).
adjective(happy, feliz, feminine, singular).
adjective(happy, felices, masculine, plural).
adjective(happy, felices, feminine, plural).

adjective(sad, triste, masculine, singular).
adjective(sad, triste, feminine, singular).
adjective(sad, tristes, masculine, plural).
adjective(sad, tristes, feminine, plural).

adjective(easy, facil, masculine, singular).
adjective(easy, facil, feminine, singular).
adjective(easy, faciles, masculine, plural).
adjective(easy, faciles, feminine, plural).

adjective(difficult, dificil, masculine, singular).
adjective(difficult, dificil, feminine, singular).
adjective(difficult, dificiles, masculine, plural).
adjective(difficult, dificiles, feminine, plural).

adjective(important, importante, masculine, singular).
adjective(important, importante, feminine, singular).
adjective(important, importantes, masculine, plural).
adjective(important, importantes, feminine, plural).

adjective(intelligent, inteligente, masculine, singular).
adjective(intelligent, inteligente, feminine, singular).
adjective(intelligent, inteligentes, masculine, plural).
adjective(intelligent, inteligentes, feminine, plural).

% Variable (change with gender)
adjective(small, pequeno, masculine, singular).
adjective(small, pequena, feminine, singular).
adjective(small, pequenos, masculine, plural).
adjective(small, pequenas, feminine, plural).

adjective(good, bueno, masculine, singular).
adjective(good, buena, feminine, singular).
adjective(bad, malo, masculine, singular).
adjective(bad, mala, feminine, singular).

adjective(beautiful, hermoso, masculine, singular).
adjective(beautiful, hermosa, feminine, singular).
adjective(pretty, bonito, masculine, singular).
adjective(pretty, bonita, feminine, singular).

adjective(new, nuevo, masculine, singular).
adjective(new, nueva, feminine, singular).
adjective(old, viejo, masculine, singular).
adjective(old, vieja, feminine, singular).

adjective(white, blanco, masculine, singular).
adjective(white, blanca, feminine, singular).
adjective(black, negro, masculine, singular).
adjective(black, negra, feminine, singular).
adjective(red, rojo, masculine, singular).
adjective(red, roja, feminine, singular).

adjective(tall, alto, masculine, singular).
adjective(tall, alta, feminine, singular).
adjective(short, bajo, masculine, singular).
adjective(short, baja, feminine, singular).

adjective(fast, rapido, masculine, singular).
adjective(fast, rapida, feminine, singular).
adjective(slow, lento, masculine, singular).
adjective(slow, lenta, feminine, singular).

adjective(favorite, favorito, masculine, singular).
adjective(favorite, favorita, feminine, singular).
adjective(favorite, favoritos, masculine, plural).
adjective(favorite, favoritas, feminine, plural).

adjective(sad, triste, masculine, singular).
adjective(sad, triste, feminine, singular).
adjective(sad, tristes, masculine, plural).
adjective(sad, tristes, feminine, plural).

% =============================================================================
% 5. VERBS - REGULAR
% =============================================================================
% verb_infinitive(English, Spanish, Type)

% -AR verbs
verb_infinitive(speak, hablar, ar).
verb_infinitive(talk, hablar, ar).
verb_infinitive(walk, caminar, ar).
verb_infinitive(work, trabajar, ar).
verb_infinitive(study, estudiar, ar).
verb_infinitive(play, jugar, ar).
verb_infinitive(love, amar, ar).
verb_infinitive(help, ayudar, ar).
verb_infinitive(buy, comprar, ar).
verb_infinitive(call, llamar, ar).
verb_infinitive(cook, cocinar, ar).

% -ER verbs
verb_infinitive(eat, comer, er).
verb_infinitive(drink, beber, er).
verb_infinitive(read, leer, er).
verb_infinitive(run, correr, er).
verb_infinitive(sell, vender, er).
verb_infinitive(learn, aprender, er).

% -IR verbs
verb_infinitive(live, vivir, ir).
verb_infinitive(write, escribir, ir).
verb_infinitive(open, abrir, ir).

% =============================================================================
% 6. VERBS - IRREGULAR (ENGLISH)
% =============================================================================
% irregular_form(Conjugated, Infinitive, Person, Tense)

% BE
irregular_form(am, be, first_singular, present).
irregular_form(are, be, second_singular, present).
irregular_form(is, be, third_singular, present).
irregular_form(are, be, plural, present).

% HAVE
irregular_form(have, have, first_singular, present).
irregular_form(have, have, second_singular, present).
irregular_form(has, have, third_singular, present).
irregular_form(have, have, plural, present).

% DO
irregular_form(do, do, first_singular, present).
irregular_form(do, do, second_singular, present).
irregular_form(does, do, third_singular, present).
irregular_form(do, do, plural, present).

% GO
irregular_form(go, go, first_singular, present).
irregular_form(go, go, second_singular, present).
irregular_form(goes, go, third_singular, present).
irregular_form(go, go, plural, present).

% =============================================================================
% 7. VERBS - IRREGULAR (SPANISH)
% =============================================================================
% irregular_form_spanish(Conjugated, Infinitive, Person, Tense)

% SER (to be - permanent)
irregular_form_spanish(soy, ser, yo, present).
irregular_form_spanish(eres, ser, tu, present).
irregular_form_spanish(es, ser, el, present).
irregular_form_spanish(somos, ser, nosotros, present).
irregular_form_spanish(son, ser, ellos, present).

% ESTAR (to be - temporary/location)
irregular_form_spanish(estoy, estar, yo, present).
irregular_form_spanish(estas, estar, tu, present).
irregular_form_spanish(esta, estar, el, present).
irregular_form_spanish(estamos, estar, nosotros, present).
irregular_form_spanish(estan, estar, ellos, present).

% IR (to go)
irregular_form_spanish(voy, ir, yo, present).
irregular_form_spanish(vas, ir, tu, present).
irregular_form_spanish(va, ir, el, present).
irregular_form_spanish(vamos, ir, nosotros, present).
irregular_form_spanish(van, ir, ellos, present).

% TENER (to have)
irregular_form_spanish(tengo, tener, yo, present).
irregular_form_spanish(tienes, tener, tu, present).
irregular_form_spanish(tiene, tener, el, present).
irregular_form_spanish(tenemos, tener, nosotros, present).
irregular_form_spanish(tienen, tener, ellos, present).

% HACER (to do/make)
irregular_form_spanish(hago, hacer, yo, present).
irregular_form_spanish(haces, hacer, tu, present).
irregular_form_spanish(hace, hacer, el, present).
irregular_form_spanish(hacemos, hacer, nosotros, present).
irregular_form_spanish(hacen, hacer, ellos, present).

% =============================================================================
% 7.1 IRREGULAR VERB PAIRS (Spanish-English equivalences)(things that may cause confusion)
% =============================================================================
% irregular_verb_pair(Spanish_Infinitive, English_Infinitive)

irregular_verb_pair(ser, be).
irregular_verb_pair(estar, be).
irregular_verb_pair(ir, go).
irregular_verb_pair(tener, have).
irregular_verb_pair(hacer, do).

% =============================================================================
% 8. OTHER WORD CLASSES
% =============================================================================

% PREPOSITIONS
preposition(in, en).
preposition(on, sobre).
preposition(to, a).
preposition(from, de).
preposition(with, con).
preposition(for, para).
preposition(at, en).

% ADVERBS
adverb(very, muy).
adverb(well, bien).
adverb(fast, rapido).
adverb(always, siempre).
adverb(never, nunca).
adverb(now, ahora).
adverb(today, hoy).
adverb(here, aqui).
adverb(there, alli).

% CONJUNCTIONS
conjunction(and, y).
conjunction(or, o).
conjunction(but, pero).
conjunction(because, porque).

% QUESTION WORDS
question_word(what, que).
question_word(where, donde).
question_word(when, cuando).
question_word(how, como).
question_word(who, quien).
question_word(why, por_que).

% NEGATIVES
negative(no, no).
negative(not, no).
negative(never, nunca).

% COMMON PHRASES
common_phrase(hello, hola).
common_phrase(goodbye, adios).
common_phrase(please, por_favor).
common_phrase(thanks, gracias).
common_phrase(good_morning, buenos_dias).

% SYNONYMS (Requisito #10)
synonym(big, large).
synonym(large, big).
synonym(small, little).
synonym(little, small).
synonym(speak, talk).
synonym(talk, speak).
synonym(beautiful, pretty).
synonym(pretty, beautiful).

% AUXILIARIES
auxiliary(do).
auxiliary(does).
auxiliary(is).
auxiliary(are).
auxiliary(can).
auxiliary(will).
auxiliary(have).
auxiliary(has).

% 9. NUMBERS

number_word(zero, cero).
number_word(one, uno).
number_word(two, dos).
number_word(three, tres).
number_word(four, cuatro).
number_word(five, cinco).
number_word(six, seis).
number_word(seven, siete).
number_word(eight, ocho).
number_word(nine, nueve).
number_word(ten, diez).
number_word(eleven, once).
number_word(twelve, doce).
number_word(thirteen, trece).
number_word(fourteen, catorce).
number_word(fifteen, quince).
number_word(sixteen, dieciseis).
number_word(seventeen, diecisiete).
number_word(eighteen, dieciocho).
number_word(nineteen, diecinueve).
number_word(twenty, veinte).
number_word(twentyone, veintiuno).
number_word(thirty, treinta).
number_word(forty, cuarenta).
number_word(fifty, cincuenta).
number_word(sixty, sesenta).
number_word(seventy, setenta).
number_word(eighty, ochenta).
number_word(ninety, noventa).
number_word(hundred, cien).
