:- encoding(utf8).

% ===============================================
% TRANSLOG DATABASE
% ===============================================

% =============================================================================
% PRONOUNS - pronoun(English, Spanish, Category, Priority)
% =============================================================================

pronoun(i, yo, first_singular, 1).
pronoun(you, tu, second_singular, 1).
pronoun(he, el, third_singular_masculine, 1).
pronoun(she, ella, third_singular_feminine, 1).
pronoun(it, eso, third_singular_neuter, 1).
pronoun(we, nosotros, first_plural, 1).
pronoun(they, ellos, third_plural_masculine, 1).
pronoun(they, ellas, third_plural_feminine, 1).

% =============================================================================
% POSSESSIVE ADJECTIVES
% =============================================================================

possessive_adjective(my, mi, first_singular).
possessive_adjective(your, tu, second_singular).
possessive_adjective(his, su, third_singular_masculine).
possessive_adjective(her, su, third_singular_feminine).
possessive_adjective(our, nuestro, first_plural_masculine).
possessive_adjective(our, nuestra, first_plural_feminine).
possessive_adjective(their, su, third_plural).

% =============================================================================
% ARTICLES - article(English, Spanish, Gender, Number)
% =============================================================================

article(the, el, masculine, singular).
article(the, la, feminine, singular).
article(the, los, masculine, plural).
article(the, las, feminine, plural).
article(a, un, masculine, singular).
article(a, una, feminine, singular).
article(an, un, masculine, singular).
article(an, una, feminine, singular).
article(some, unos, masculine, plural).
article(some, unas, feminine, plural).

% =============================================================================
% NOUNS - noun(English, Spanish, Gender, Number)
% =============================================================================

noun(cat, gato, masculine, singular).
noun(cats, gatos, masculine, plural).
noun(dog, perro, masculine, singular).
noun(dogs, perros, masculine, plural).
noun(bird, pajaro, masculine, singular).
noun(fish, pescado, masculine, singular).
noun(horse, caballo, masculine, singular).
noun(cow, vaca, feminine, singular).
noun(lion, leon, masculine, singular).
noun(elephant, elefante, masculine, singular).

noun(man, hombre, masculine, singular).
noun(men, hombres, masculine, plural).
noun(woman, mujer, feminine, singular).
noun(women, mujeres, feminine, plural).
noun(boy, nino, masculine, singular).
noun(boys, ninos, masculine, plural).
noun(girl, nina, feminine, singular).
noun(girls, ninas, feminine, plural).
noun(child, nino, masculine, singular).
noun(children, ninos, masculine, plural).
noun(friend, amigo, masculine, singular).
noun(friends, amigos, masculine, plural).
noun(teacher, maestro, masculine, singular).
noun(student, estudiante, masculine, singular).
noun(doctor, doctor, masculine, singular).
noun(father, padre, masculine, singular).
noun(mother, madre, feminine, singular).
noun(brother, hermano, masculine, singular).
noun(sister, hermana, feminine, singular).
noun(family, familia, feminine, singular).

noun(house, casa, feminine, singular).
noun(houses, casas, feminine, plural).
noun(home, hogar, masculine, singular).
noun(room, cuarto, masculine, singular).
noun(kitchen, cocina, feminine, singular).
noun(school, escuela, feminine, singular).
noun(hospital, hospital, masculine, singular).
noun(store, tienda, feminine, singular).
noun(restaurant, restaurante, masculine, singular).
noun(park, parque, masculine, singular).
noun(city, ciudad, feminine, singular).
noun(street, calle, feminine, singular).
noun(office, oficina, feminine, singular).

noun(car, coche, masculine, singular).
noun(cars, coches, masculine, plural).
noun(book, libro, masculine, singular).
noun(books, libros, masculine, plural).
noun(pen, pluma, feminine, singular).
noun(pencil, lapiz, masculine, singular).
noun(paper, papel, masculine, singular).
noun(computer, computadora, feminine, singular).
noun(phone, telefono, masculine, singular).
noun(table, mesa, feminine, singular).
noun(tables, mesas, feminine, plural).
noun(chair, silla, feminine, singular).
noun(chairs, sillas, feminine, plural).
noun(door, puerta, feminine, singular).
noun(window, ventana, feminine, singular).
noun(bed, cama, feminine, singular).
noun(key, llave, feminine, singular).
noun(cup, taza, feminine, singular).
noun(glass, vaso, masculine, singular).
noun(plate, plato, masculine, singular).

noun(food, comida, feminine, singular).
noun(bread, pan, masculine, singular).
noun(rice, arroz, masculine, singular).
noun(meat, carne, feminine, singular).
noun(egg, huevo, masculine, singular).
noun(cheese, queso, masculine, singular).
noun(milk, leche, feminine, singular).
noun(fruit, fruta, feminine, singular).
noun(apple, manzana, feminine, singular).
noun(apples, manzanas, feminine, plural).
noun(orange, naranja, feminine, singular).
noun(vegetable, verdura, feminine, singular).
noun(tomato, tomate, masculine, singular).
noun(salad, ensalada, feminine, singular).
noun(soup, sopa, feminine, singular).
noun(water, agua, feminine, singular).
noun(juice, jugo, masculine, singular).
noun(coffee, cafe, masculine, singular).
noun(tea, te, masculine, singular).

noun(day, dia, masculine, singular).
noun(night, noche, feminine, singular).
noun(morning, manana, feminine, singular).
noun(time, tiempo, masculine, singular).
noun(life, vida, feminine, singular).
noun(world, mundo, masculine, singular).
noun(thing, cosa, feminine, singular).
noun(things, cosas, feminine, plural).
noun(name, nombre, masculine, singular).
noun(word, palabra, feminine, singular).
noun(question, pregunta, feminine, singular).
noun(answer, respuesta, feminine, singular).
noun(work, trabajo, masculine, singular).
noun(place, lugar, masculine, singular).

noun(head, cabeza, feminine, singular).
noun(eye, ojo, masculine, singular).
noun(eyes, ojos, masculine, plural).
noun(hand, mano, feminine, singular).
noun(hands, manos, feminine, plural).

% =============================================================================
% ADJECTIVES - adjective(English, Spanish, Gender, Number)
% =============================================================================

adjective(big, grande, masculine, singular).
adjective(big, grande, feminine, singular).
adjective(big, grandes, masculine, plural).
adjective(big, grandes, feminine, plural).
adjective(small, pequeno, masculine, singular).
adjective(small, pequena, feminine, singular).
adjective(tall, alto, masculine, singular).
adjective(tall, alta, feminine, singular).
adjective(short, bajo, masculine, singular).
adjective(short, baja, feminine, singular).

adjective(good, bueno, masculine, singular).
adjective(good, buena, feminine, singular).
adjective(bad, malo, masculine, singular).
adjective(bad, mala, feminine, singular).
adjective(beautiful, hermoso, masculine, singular).
adjective(beautiful, hermosa, feminine, singular).
adjective(pretty, bonito, masculine, singular).
adjective(pretty, bonita, feminine, singular).
adjective(ugly, feo, masculine, singular).
adjective(ugly, fea, feminine, singular).
adjective(nice, agradable, masculine, singular).
adjective(nice, agradable, feminine, singular).

adjective(happy, feliz, masculine, singular).
adjective(happy, feliz, feminine, singular).
adjective(sad, triste, masculine, singular).
adjective(sad, triste, feminine, singular).
adjective(angry, enojado, masculine, singular).
adjective(angry, enojada, feminine, singular).
adjective(tired, cansado, masculine, singular).
adjective(tired, cansada, feminine, singular).

adjective(new, nuevo, masculine, singular).
adjective(new, nueva, feminine, singular).
adjective(old, viejo, masculine, singular).
adjective(old, vieja, feminine, singular).
adjective(young, joven, masculine, singular).
adjective(young, joven, feminine, singular).
adjective(clean, limpio, masculine, singular).
adjective(clean, limpia, feminine, singular).

adjective(white, blanco, masculine, singular).
adjective(white, blanca, feminine, singular).
adjective(black, negro, masculine, singular).
adjective(black, negra, feminine, singular).
adjective(red, rojo, masculine, singular).
adjective(red, roja, feminine, singular).
adjective(blue, azul, masculine, singular).
adjective(blue, azul, feminine, singular).
adjective(green, verde, masculine, singular).
adjective(green, verde, feminine, singular).

adjective(fast, rapido, masculine, singular).
adjective(fast, rapida, feminine, singular).
adjective(slow, lento, masculine, singular).
adjective(slow, lenta, feminine, singular).
adjective(easy, facil, masculine, singular).
adjective(easy, facil, feminine, singular).
adjective(difficult, dificil, masculine, singular).
adjective(difficult, dificil, feminine, singular).

adjective(hot, caliente, masculine, singular).
adjective(hot, caliente, feminine, singular).
adjective(cold, frio, masculine, singular).
adjective(cold, fria, feminine, singular).

adjective(important, importante, masculine, singular).
adjective(important, importante, feminine, singular).
adjective(intelligent, inteligente, masculine, singular).
adjective(intelligent, inteligente, feminine, singular).
adjective(favorite, favorito, masculine, singular).
adjective(favorite, favorita, feminine, singular).

% =============================================================================
% VERBS - REGULAR - verb_infinitive(English, Spanish, Type)
% =============================================================================

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
verb_infinitive(dance, bailar, ar).
verb_infinitive(sing, cantar, ar).
verb_infinitive(listen, escuchar, ar).
verb_infinitive(look, mirar, ar).
verb_infinitive(watch, mirar, ar).
verb_infinitive(search, buscar, ar).
verb_infinitive(clean, limpiar, ar).
verb_infinitive(travel, viajar, ar).
verb_infinitive(wait, esperar, ar).
verb_infinitive(need, necesitar, ar).
verb_infinitive(use, usar, ar).
verb_infinitive(remember, recordar, ar).
verb_infinitive(teach, ensenar, ar).
verb_infinitive(ask, preguntar, ar).
verb_infinitive(answer, contestar, ar).
verb_infinitive(take, tomar, ar).
verb_infinitive(visit, visitar, ar).

verb_infinitive(eat, comer, er).
verb_infinitive(drink, beber, er).
verb_infinitive(read, leer, er).
verb_infinitive(run, correr, er).
verb_infinitive(sell, vender, er).
verb_infinitive(learn, aprender, er).
verb_infinitive(understand, entender, er).
verb_infinitive(see, ver, er).

verb_infinitive(live, vivir, ir).
verb_infinitive(write, escribir, ir).
verb_infinitive(open, abrir, ir).
verb_infinitive(receive, recibir, ir).

% =============================================================================
% VERBS - IRREGULAR ENGLISH
% =============================================================================

irregular_form(am, be, first_singular, present).
irregular_form(are, be, second_singular, present).
irregular_form(is, be, third_singular, present).
irregular_form(are, be, plural, present).

irregular_form(have, have, first_singular, present).
irregular_form(have, have, second_singular, present).
irregular_form(has, have, third_singular, present).
irregular_form(have, have, plural, present).

irregular_form(do, do, first_singular, present).
irregular_form(do, do, second_singular, present).
irregular_form(does, do, third_singular, present).
irregular_form(do, do, plural, present).

irregular_form(go, go, first_singular, present).
irregular_form(go, go, second_singular, present).
irregular_form(goes, go, third_singular, present).
irregular_form(go, go, plural, present).

% =============================================================================
% VERBS - IRREGULAR SPANISH
% =============================================================================

irregular_form_spanish(soy, ser, yo, present).
irregular_form_spanish(eres, ser, tu, present).
irregular_form_spanish(es, ser, el, present).
irregular_form_spanish(somos, ser, nosotros, present).
irregular_form_spanish(son, ser, ellos, present).

irregular_form_spanish(estoy, estar, yo, present).
irregular_form_spanish(estas, estar, tu, present).
irregular_form_spanish(esta, estar, el, present).
irregular_form_spanish(estamos, estar, nosotros, present).
irregular_form_spanish(estan, estar, ellos, present).

irregular_form_spanish(voy, ir, yo, present).
irregular_form_spanish(vas, ir, tu, present).
irregular_form_spanish(va, ir, el, present).
irregular_form_spanish(vamos, ir, nosotros, present).
irregular_form_spanish(van, ir, ellos, present).

irregular_form_spanish(tengo, tener, yo, present).
irregular_form_spanish(tienes, tener, tu, present).
irregular_form_spanish(tiene, tener, el, present).
irregular_form_spanish(tenemos, tener, nosotros, present).
irregular_form_spanish(tienen, tener, ellos, present).

irregular_form_spanish(hago, hacer, yo, present).
irregular_form_spanish(haces, hacer, tu, present).
irregular_form_spanish(hace, hacer, el, present).
irregular_form_spanish(hacemos, hacer, nosotros, present).
irregular_form_spanish(hacen, hacer, ellos, present).

% =============================================================================
% IRREGULAR VERB PAIRS
% =============================================================================

irregular_verb_pair(ser, be).
irregular_verb_pair(estar, be).
irregular_verb_pair(ir, go).
irregular_verb_pair(tener, have).
irregular_verb_pair(hacer, do).

% =============================================================================
% PREPOSITIONS - preposition(English, Spanish)
% =============================================================================

preposition(in, en).
preposition(on, sobre).
preposition(at, en).
preposition(to, a).
preposition(from, de).
preposition(with, con).
preposition(of, de).
preposition(for, para).
preposition(about, sobre).

% =============================================================================
% ADVERBS - adverb(English, Spanish)
% =============================================================================

adverb(very, muy).
adverb(well, bien).
adverb(fast, rapido).
adverb(always, siempre).
adverb(never, nunca).
adverb(now, ahora).
adverb(today, hoy).
adverb(here, aqui).
adverb(there, alli).
adverb(much, mucho).
adverb(more, mas).
adverb(less, menos).

% =============================================================================
% CONJUNCTIONS - conjunction(English, Spanish)
% =============================================================================

conjunction(and, y).
conjunction(or, o).
conjunction(but, pero).
conjunction(because, porque).

% =============================================================================
% QUESTION WORDS - question_word(English, Spanish)
% =============================================================================

question_word(what, que).
question_word(where, donde).
question_word(when, cuando).
question_word(who, quien).
question_word(why, por_que).

% =============================================================================
% NEGATIVES - negative(English, Spanish)
% =============================================================================

negative(no, no).
negative(not, no).
negative(never, nunca).

% =============================================================================
% COMMON PHRASES - common_phrase(English, Spanish)
% =============================================================================

common_phrase(hello, hola).
common_phrase(hi, hola).
common_phrase(goodbye, adios).
common_phrase(bye, adios).
common_phrase(please, por_favor).
common_phrase(thanks, gracias).
common_phrase(thank_you, gracias).
common_phrase(yes, si).
common_phrase(ok, ok).

% =============================================================================
% AUXILIARIES
% =============================================================================

auxiliary(do).
auxiliary(does).
auxiliary(is).
auxiliary(are).
auxiliary(am).