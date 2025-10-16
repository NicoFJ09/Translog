% ===============================================
% COMPLETE TRANSLOG DATABASE (BD.pl)
% Spanish-English Translation Database - Ver. 1.0
% Present Tense Only
% ===============================================

% =====================
% 1. PRONOUNS (Literal)
% =====================
% pronoun(English, Spanish, Person)

pronoun(i, yo, yo).
pronoun(you, tu, tu).              % informal singular
pronoun(you, usted, usted).        % formal singular
pronoun(he, el, el).
pronoun(she, ella, ella).
pronoun(we, nosotros, nosotros).
pronoun(you_all, vosotros, vosotros).  % informal plural (Spain)
pronoun(you_all, ustedes, ustedes).    % formal plural / Latin America
pronoun(they, ellos, ellos).       % masculine
pronoun(they, ellas, ellas).       % feminine


% =====================
% 2. ARTICLES (Gender/Number Agreement Required)
% =====================
% article(English, Spanish, Gender, Number)

% Definite articles (the)
article(the, el, masculine, singular).
article(the, la, feminine, singular).
article(the, los, masculine, plural).
article(the, las, feminine, plural).

% Indefinite articles (a/an, some)
article(a, un, masculine, singular).
article(an, un, masculine, singular).
article(a, una, feminine, singular).
article(an, una, feminine, singular).
article(some, unos, masculine, plural).
article(some, unas, feminine, plural).


% =====================
% 3. NOUNS (Literal + Gender/Number Info)
% =====================
% noun(English, Spanish, Gender, Number)

% Animals
noun(cat, gato, masculine, singular).
noun(cats, gatos, masculine, plural).
noun(dog, perro, masculine, singular).
noun(dogs, perros, masculine, plural).
noun(bird, pajaro, masculine, singular).
noun(birds, pajaros, masculine, plural).
noun(fish, pez, masculine, singular).
noun(fish_plural, peces, masculine, plural).

% People
noun(man, hombre, masculine, singular).
noun(men, hombres, masculine, plural).
noun(woman, mujer, feminine, singular).
noun(women, mujeres, feminine, plural).
noun(child, nino, masculine, singular).
noun(children, ninos, masculine, plural).
noun(boy, nino, masculine, singular).
noun(girl, nina, feminine, singular).
noun(person, persona, feminine, singular).
noun(people, personas, feminine, plural).
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
noun(door, puerta, feminine, singular).
noun(window, ventana, feminine, singular).
noun(computer, computadora, feminine, singular).
noun(phone, telefono, masculine, singular).

% Food
noun(water, agua, feminine, singular).  % Note: uses 'el' but is feminine!
noun(food, comida, feminine, singular).
noun(bread, pan, masculine, singular).
noun(apple, manzana, feminine, singular).
noun(apples, manzanas, feminine, plural).
noun(coffee, cafe, masculine, singular).
noun(milk, leche, feminine, singular).

% Places
noun(park, parque, masculine, singular).
noun(school, escuela, feminine, singular).
noun(city, ciudad, feminine, singular).
noun(street, calle, feminine, singular).
noun(beach, playa, feminine, singular).
noun(mountain, montana, feminine, singular).

% Abstract
noun(time, tiempo, masculine, singular).
noun(day, dia, masculine, singular).
noun(night, noche, feminine, singular).
noun(year, ano, masculine, singular).
noun(life, vida, feminine, singular).
noun(world, mundo, masculine, singular).
noun(love, amor, masculine, singular).


% =====================
% 4. ADJECTIVES (Mostly Literal, Some Need Gender)
% =====================
% adjective(English, Spanish) - doesn't change
% adjective(English, Spanish, Gender) - changes with gender

% Adjectives that DON'T change with gender
adjective(big, grande).
adjective(large, grande).
adjective(happy, feliz).
adjective(sad, triste).
adjective(difficult, dificil).
adjective(easy, facil).
adjective(important, importante).
adjective(intelligent, inteligente).
adjective(interesting, interesante).
adjective(young, joven).

% Adjectives that DO change with gender
adjective(small, pequeno, masculine).
adjective(small, pequena, feminine).
adjective(good, bueno, masculine).
adjective(good, buena, feminine).
adjective(bad, malo, masculine).
adjective(bad, mala, feminine).
adjective(new, nuevo, masculine).
adjective(new, nueva, feminine).
adjective(old, viejo, masculine).
adjective(old, vieja, feminine).
adjective(beautiful, hermoso, masculine).
adjective(beautiful, hermosa, feminine).
adjective(ugly, feo, masculine).
adjective(ugly, fea, feminine).
adjective(cold, frio, masculine).
adjective(cold, fria, feminine).
adjective(hot, caliente, masculine).
adjective(hot, caliente, feminine).
adjective(white, blanco, masculine).
adjective(white, blanca, feminine).
adjective(black, negro, masculine).
adjective(black, negra, feminine).
adjective(red, rojo, masculine).
adjective(red, roja, feminine).
adjective(tall, alto, masculine).
adjective(tall, alta, feminine).
adjective(short, bajo, masculine).
adjective(short, baja, feminine).
adjective(fast, rapido, masculine).
adjective(fast, rapida, feminine).
adjective(slow, lento, masculine).
adjective(slow, lenta, feminine).


% =====================
% 5. PREPOSITIONS (Literal)
% =====================
% preposition(English, Spanish)

preposition(in, en).
preposition(on, sobre).
preposition(at, en).
preposition(to, a).
preposition(from, de).
preposition(with, con).
preposition(without, sin).
preposition(for, para).
preposition(by, por).
preposition(of, de).
preposition(about, sobre).
preposition(under, bajo).
preposition(over, sobre).
preposition(between, entre).
preposition(behind, detras).
preposition(in_front_of, delante).
preposition(near, cerca).
preposition(far, lejos).


% =====================
% 6. ADVERBS (Literal)
% =====================
% adverb(English, Spanish)

adverb(very, muy).
adverb(much, mucho).
adverb(little, poco).
adverb(more, mas).
adverb(less, menos).
adverb(well, bien).
adverb(badly, mal).
adverb(quickly, rapidamente).
adverb(slowly, lentamente).
adverb(always, siempre).
adverb(never, nunca).
adverb(sometimes, a_veces).
adverb(today, hoy).
adverb(tomorrow, manana).
adverb(yesterday, ayer).
adverb(now, ahora).
adverb(here, aqui).
adverb(there, alli).
adverb(yes, si).
adverb(no, no).
adverb(also, tambien).
adverb(too, tambien).


% =====================
% 7. CONJUNCTIONS (Literal)
% =====================
% conjunction(English, Spanish)

conjunction(and, y).
conjunction(or, o).
conjunction(but, pero).
conjunction(because, porque).
conjunction(if, si).
conjunction(when, cuando).
conjunction(that, que).


% =====================
% 8. QUESTION WORDS (Literal)
% =====================
% question_word(English, Spanish)


question_word(what, que).
question_word(where, donde).
question_word(when, cuando).
question_word(why, por_que).
question_word(how, como).
question_word(who, quien).
question_word(whom, quien).
question_word(which, cual).
question_word(how_many, cuantos).
question_word(how_much, cuanto).


% =====================
% 9. VERBS (Uses Conjugation System)
% =====================
% See conjugation_system.pl for verb conjugation rules
% This section just defines which verbs exist

% Regular -ar verbs
verb_infinitive(to_speak, hablar, ar).
verb_infinitive(to_talk, hablar, ar).
verb_infinitive(to_walk, caminar, ar).
verb_infinitive(to_work, trabajar, ar).
verb_infinitive(to_study, estudiar, ar).
verb_infinitive(to_dance, bailar, ar).
verb_infinitive(to_sing, cantar, ar).
verb_infinitive(to_cook, cocinar, ar).
verb_infinitive(to_clean, limpiar, ar).
verb_infinitive(to_help, ayudar, ar).
verb_infinitive(to_buy, comprar, ar).
verb_infinitive(to_play, jugar, ar).    % Note: stem-changing o->ue
verb_infinitive(to_love, amar, ar).
verb_infinitive(to_look, mirar, ar).
verb_infinitive(to_listen, escuchar, ar).
verb_infinitive(to_call, llamar, ar).

% Regular -er verbs
verb_infinitive(to_eat, comer, er).
verb_infinitive(to_drink, beber, er).
verb_infinitive(to_read, leer, er).
verb_infinitive(to_run, correr, er).
verb_infinitive(to_sell, vender, er).
verb_infinitive(to_learn, aprender, er).
verb_infinitive(to_understand, comprender, er).

% Regular -ir verbs
verb_infinitive(to_live, vivir, ir).
verb_infinitive(to_write, escribir, ir).
verb_infinitive(to_open, abrir, ir).
verb_infinitive(to_receive, recibir, ir).
verb_infinitive(to_decide, decidir, ir).

% Irregular verbs (most common)
verb_infinitive(to_be, ser, irregular).
verb_infinitive(to_be_located, estar, irregular).
verb_infinitive(to_have, tener, irregular).
verb_infinitive(to_do, hacer, irregular).
verb_infinitive(to_make, hacer, irregular).
verb_infinitive(to_go, ir, irregular).
verb_infinitive(to_say, decir, irregular).
verb_infinitive(to_see, ver, irregular).
verb_infinitive(to_give, dar, irregular).
verb_infinitive(to_know, saber, irregular).
verb_infinitive(to_want, querer, irregular).
verb_infinitive(to_come, venir, irregular).
verb_infinitive(to_be_able, poder, irregular).
verb_infinitive(can, poder, irregular).


% =====================
% 10. COMMON PHRASES (Literal)
% =====================
% phrase(English, Spanish)

common_phrase(hello, hola).
common_phrase(goodbye, adios).
common_phrase(please, por_favor).
common_phrase(thank_you, gracias).
common_phrase(you_are_welcome, de_nada).
common_phrase(excuse_me, perdon).
common_phrase(good_morning, buenos_dias).
common_phrase(good_afternoon, buenas_tardes).
common_phrase(good_night, buenas_noches).
common_phrase(how_are_you, como_estas).
common_phrase(what_is_your_name, como_te_llamas).
common_phrase(my_name_is, me_llamo).


% =====================
% 11. NUMBERS (Literal)
% =====================
% number_word(English, Spanish, Value)

number_word(zero, cero, 0).
number_word(one, uno, 1).
number_word(two, dos, 2).
number_word(three, tres, 3).
number_word(four, cuatro, 4).
number_word(five, cinco, 5).
number_word(six, seis, 6).
number_word(seven, siete, 7).
number_word(eight, ocho, 8).
number_word(nine, nueve, 9).
number_word(ten, diez, 10).
number_word(eleven, once, 11).
number_word(twelve, doce, 12).
number_word(thirteen, trece, 13).
number_word(fourteen, catorce, 14).
number_word(fifteen, quince, 15).
number_word(twenty, veinte, 20).
number_word(thirty, treinta, 30).
number_word(forty, cuarenta, 40).
number_word(fifty, cincuenta, 50).
number_word(hundred, cien, 100).


% =====================
% 12. POSSESSIVE ADJECTIVES (Gender/Number Agreement)
% =====================
% possessive(English, Spanish, Gender, Number)

% My
possessive(my, mi, _, singular).
possessive(my, mis, _, plural).

% Your (informal tú)
possessive(your, tu, _, singular).
possessive(your, tus, _, plural).

% Your (formal usted) / His / Her
possessive(his, su, _, singular).
possessive(her, su, _, singular).
possessive(your_formal, su, _, singular).
possessive(his, sus, _, plural).
possessive(her, sus, _, plural).
possessive(your_formal, sus, _, plural).

% Our
possessive(our, nuestro, masculine, singular).
possessive(our, nuestra, feminine, singular).
possessive(our, nuestros, masculine, plural).
possessive(our, nuestras, feminine, plural).

% Your (informal vosotros - Spain)
possessive(your_plural, vuestro, masculine, singular).
possessive(your_plural, vuestra, feminine, singular).
possessive(your_plural, vuestros, masculine, plural).
possessive(your_plural, vuestras, feminine, plural).

% Their / Your (formal ustedes)
possessive(their, su, _, singular).
possessive(their, sus, _, plural).


% =====================
% 13. DEMONSTRATIVE ADJECTIVES (Gender/Number Agreement)
% =====================
% demonstrative(English, Spanish, Gender, Number, Distance)

% This / These (near)
demonstrative(this, este, masculine, singular, near).
demonstrative(this, esta, feminine, singular, near).
demonstrative(these, estos, masculine, plural, near).
demonstrative(these, estas, feminine, plural, near).

% That / Those (far)
demonstrative(that, ese, masculine, singular, medium).
demonstrative(that, esa, feminine, singular, medium).
demonstrative(those, esos, masculine, plural, medium).
demonstrative(those, esas, feminine, plural, medium).



% =====================
% 14. OBJECT PRONOUNS (Direct and Indirect)
% =====================
% object_pronoun(English, Spanish, Type, Person)

% Direct object pronouns
object_pronoun(me, me, direct, first_singular).
object_pronoun(you, te, direct, second_singular).
object_pronoun(him, lo, direct, third_singular_masculine).
object_pronoun(her, la, direct, third_singular_feminine).
object_pronoun(it, lo, direct, third_singular_masculine).  % for masculine things
object_pronoun(it, la, direct, third_singular_feminine).   % for feminine things
object_pronoun(us, nos, direct, first_plural).
object_pronoun(you_all, os, direct, second_plural).
object_pronoun(them, los, direct, third_plural_masculine).
object_pronoun(them, las, direct, third_plural_feminine).

% Indirect object pronouns
object_pronoun(to_me, me, indirect, first_singular).
object_pronoun(to_you, te, indirect, second_singular).
object_pronoun(to_him, le, indirect, third_singular).
object_pronoun(to_her, le, indirect, third_singular).
object_pronoun(to_us, nos, indirect, first_plural).
object_pronoun(to_you_all, os, indirect, second_plural).
object_pronoun(to_them, les, indirect, third_plural).



% =====================
% 15. NEGATIVE WORDS
% =====================
% negative(English, Spanish)

negative(no, no).
negative(not, no).
negative(never, nunca).
negative(nothing, nada).
negative(nobody, nadie).
negative(no_one, nadie).
negative(none, ninguno).
negative(neither, tampoco).
negative(nor, ni).


% =====================
% 17. QUANTIFIERS
% =====================
% quantifier(English, Spanish)

quantifier(many, muchos, masculine, plural).
quantifier(many, muchas, feminine, plural).
quantifier(much, mucho, masculine, singular).
quantifier(much, mucha, feminine, singular).
quantifier(few, pocos, masculine, plural).
quantifier(few, pocas, feminine, plural).
quantifier(little, poco, masculine, singular).
quantifier(little, poca, feminine, singular).
quantifier(several, varios, masculine, plural).
quantifier(several, varias, feminine, plural).
quantifier(some, algunos, masculine, plural).
quantifier(some, algunas, feminine, plural).
quantifier(all, todos, masculine, plural).
quantifier(all, todas, feminine, plural).
quantifier(each, cada, _, singular).
quantifier(every, cada, _, singular).
quantifier(both, ambos, masculine, plural).
quantifier(both, ambas, feminine, plural).
quantifier(enough, suficiente, _, singular).
quantifier(enough, suficientes, _, plural).
quantifier(too_much, demasiado, masculine, singular).
quantifier(too_much, demasiada, feminine, singular).
quantifier(too_many, demasiados, masculine, plural).
quantifier(too_many, demasiadas, feminine, plural).