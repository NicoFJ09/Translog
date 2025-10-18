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
% 4. ADJECTIVES 
% =====================
% adjective(English, Spanish) - invariable (no gender/number change)
% adjective(English, Spanish, Gender, Number) - changes with gender/number
% =====================

% -----------------------------------------------------------------------------
% A) INVARIABLE ADJECTIVES (no cambian con género, pero SÍ con número)
% -----------------------------------------------------------------------------
% Singular
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
adjective(strong, fuerte).
adjective(weak, debil).
adjective(blue, azul).
adjective(green, verde).
adjective(orange, naranja).
adjective(brown, marron).
adjective(gray, gris).
adjective(pink, rosa).

% Plural (misma traducción inglesa, forma plural española)
adjective(big, grandes).
adjective(large, grandes).
adjective(happy, felices).
adjective(sad, tristes).
adjective(difficult, dificiles).
adjective(easy, faciles).
adjective(important, importantes).
adjective(intelligent, inteligentes).
adjective(interesting, interesantes).
adjective(young, jovenes).
adjective(strong, fuertes).
adjective(weak, debiles).
adjective(blue, azules).
adjective(green, verdes).
adjective(orange, naranjas).
adjective(brown, marrones).
adjective(gray, grises).
adjective(pink, rosas).

% -----------------------------------------------------------------------------
% B) GENDER/NUMBER VARIANT ADJECTIVES
% -----------------------------------------------------------------------------
% Format: adjective(English, Spanish, Gender, Number)

% Size adjectives
adjective(small, pequeno, masculine, singular).
adjective(small, pequena, feminine, singular).
adjective(small, pequenos, masculine, plural).
adjective(small, pequenas, feminine, plural).

% Quality adjectives
adjective(good, bueno, masculine, singular).
adjective(good, buena, feminine, singular).
adjective(good, buenos, masculine, plural).
adjective(good, buenas, feminine, plural).

adjective(bad, malo, masculine, singular).
adjective(bad, mala, feminine, singular).
adjective(bad, malos, masculine, plural).
adjective(bad, malas, feminine, plural).

adjective(beautiful, hermoso, masculine, singular).
adjective(beautiful, hermosa, feminine, singular).
adjective(beautiful, hermosos, masculine, plural).
adjective(beautiful, hermosas, feminine, plural).

adjective(pretty, bonito, masculine, singular).
adjective(pretty, bonita, feminine, singular).
adjective(pretty, bonitos, masculine, plural).
adjective(pretty, bonitas, feminine, plural).

adjective(ugly, feo, masculine, singular).
adjective(ugly, fea, feminine, singular).
adjective(ugly, feos, masculine, plural).
adjective(ugly, feas, feminine, plural).

% Age adjectives
adjective(new, nuevo, masculine, singular).
adjective(new, nueva, feminine, singular).
adjective(new, nuevos, masculine, plural).
adjective(new, nuevas, feminine, plural).

adjective(old, viejo, masculine, singular).
adjective(old, vieja, feminine, singular).
adjective(old, viejos, masculine, plural).
adjective(old, viejas, feminine, plural).

% Color adjectives
adjective(white, blanco, masculine, singular).
adjective(white, blanca, feminine, singular).
adjective(white, blancos, masculine, plural).
adjective(white, blancas, feminine, plural).

adjective(black, negro, masculine, singular).
adjective(black, negra, feminine, singular).
adjective(black, negros, masculine, plural).
adjective(black, negras, feminine, plural).

adjective(red, rojo, masculine, singular).
adjective(red, roja, feminine, singular).
adjective(red, rojos, masculine, plural).
adjective(red, rojas, feminine, plural).

adjective(yellow, amarillo, masculine, singular).
adjective(yellow, amarilla, feminine, singular).
adjective(yellow, amarillos, masculine, plural).
adjective(yellow, amarillas, feminine, plural).

% Physical characteristics
adjective(tall, alto, masculine, singular).
adjective(tall, alta, feminine, singular).
adjective(tall, altos, masculine, plural).
adjective(tall, altas, feminine, plural).

adjective(short, bajo, masculine, singular).
adjective(short, baja, feminine, singular).
adjective(short, bajos, masculine, plural).
adjective(short, bajas, feminine, plural).

adjective(fat, gordo, masculine, singular).
adjective(fat, gorda, feminine, singular).
adjective(fat, gordos, masculine, plural).
adjective(fat, gordas, feminine, plural).

adjective(thin, delgado, masculine, singular).
adjective(thin, delgada, feminine, singular).
adjective(thin, delgados, masculine, plural).
adjective(thin, delgadas, feminine, plural).

% Speed adjectives
adjective(fast, rapido, masculine, singular).
adjective(fast, rapida, feminine, singular).
adjective(fast, rapidos, masculine, plural).
adjective(fast, rapidas, feminine, plural).

adjective(slow, lento, masculine, singular).
adjective(slow, lenta, feminine, singular).
adjective(slow, lentos, masculine, plural).
adjective(slow, lentas, feminine, plural).

% Temperature adjectives
adjective(hot, caliente, masculine, singular).
adjective(hot, caliente, feminine, singular).
adjective(hot, calientes, masculine, plural).
adjective(hot, calientes, feminine, plural).

adjective(cold, frio, masculine, singular).
adjective(cold, fria, feminine, singular).
adjective(cold, frios, masculine, plural).
adjective(cold, frias, feminine, plural).

% State adjectives
adjective(clean, limpio, masculine, singular).
adjective(clean, limpia, feminine, singular).
adjective(clean, limpios, masculine, plural).
adjective(clean, limpias, feminine, plural).

adjective(dirty, sucio, masculine, singular).
adjective(dirty, sucia, feminine, singular).
adjective(dirty, sucios, masculine, plural).
adjective(dirty, sucias, feminine, plural).


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
% 9. VERBS (Infinitives and Common Forms)
% =====================
% verb_infinitive(English, Spanish, Type)

% =============================================================================
% REGULAR -AR VERBS
% =============================================================================
verb_infinitive(speak, hablar, ar).
verb_infinitive(talk, hablar, ar).
verb_infinitive(walk, caminar, ar).
verb_infinitive(work, trabajar, ar).
verb_infinitive(study, estudiar, ar).
verb_infinitive(dance, bailar, ar).
verb_infinitive(sing, cantar, ar).
verb_infinitive(cook, cocinar, ar).
verb_infinitive(clean, limpiar, ar).
verb_infinitive(help, ayudar, ar).
verb_infinitive(buy, comprar, ar).
verb_infinitive(play, jugar, ar).
verb_infinitive(love, amar, ar).
verb_infinitive(look, mirar, ar).
verb_infinitive(listen, escuchar, ar).
verb_infinitive(call, llamar, ar).

% =============================================================================
% REGULAR -ER VERBS
% =============================================================================
verb_infinitive(eat, comer, er).
verb_infinitive(drink, beber, er).
verb_infinitive(read, leer, er).
verb_infinitive(run, correr, er).
verb_infinitive(sell, vender, er).
verb_infinitive(learn, aprender, er).
verb_infinitive(understand, comprender, er).

% =============================================================================
% REGULAR -IR VERBS
% =============================================================================
verb_infinitive(live, vivir, ir).
verb_infinitive(write, escribir, ir).
verb_infinitive(open, abrir, ir).
verb_infinitive(receive, recibir, ir).
verb_infinitive(decide, decidir, ir).
% =============================================================================
% IRREGULAR VERBS - INFINITIVES
% =============================================================================
verb_infinitive(be, ser, irregular).
verb_infinitive(have, tener, irregular).
verb_infinitive(do, hacer, irregular).
verb_infinitive(make, hacer, irregular).
verb_infinitive(go, ir, irregular).
verb_infinitive(say, decir, irregular).
verb_infinitive(see, ver, irregular).
verb_infinitive(give, dar, irregular).
verb_infinitive(know, saber, irregular).
verb_infinitive(want, querer, irregular).
verb_infinitive(come, venir, irregular).
verb_infinitive(can, poder, irregular).
verb_infinitive(like, gustar, irregular).  % Especial en español


% =============================================================================
% IRREGULAR VERBS - COMMON CONJUGATED FORMS (English)
% =============================================================================
% irregular_form(ConjugatedForm, Infinitive, Person, Tense)

% BE (ser/estar)
irregular_form(am, be, first_singular, present).
irregular_form(are, be, second_singular, present).
irregular_form(is, be, third_singular, present).
irregular_form(are, be, plural, present).

% HAVE (tener/haber)
irregular_form(have, have, first_singular, present).
irregular_form(have, have, second_singular, present).
irregular_form(has, have, third_singular, present).
irregular_form(have, have, plural, present).

% DO (hacer)
irregular_form(do, do, first_singular, present).
irregular_form(do, do, second_singular, present).
irregular_form(does, do, third_singular, present).
irregular_form(do, do, plural, present).

% GO (ir)
irregular_form(go, go, first_singular, present).
irregular_form(go, go, second_singular, present).
irregular_form(goes, go, third_singular, present).
irregular_form(go, go, plural, present).

% COME (venir)
irregular_form(come, come, first_singular, present).
irregular_form(come, come, second_singular, present).
irregular_form(comes, come, third_singular, present).
irregular_form(come, come, plural, present).

% SEE (ver)
irregular_form(see, see, first_singular, present).
irregular_form(see, see, second_singular, present).
irregular_form(sees, see, third_singular, present).
irregular_form(see, see, plural, present).

% MAKE (hacer)
irregular_form(make, make, first_singular, present).
irregular_form(make, make, second_singular, present).
irregular_form(makes, make, third_singular, present).
irregular_form(make, make, plural, present).

% SAY (decir)
irregular_form(say, say, first_singular, present).
irregular_form(say, say, second_singular, present).
irregular_form(says, say, third_singular, present).
irregular_form(say, say, plural, present).

% GIVE (dar)
irregular_form(give, give, first_singular, present).
irregular_form(give, give, second_singular, present).
irregular_form(gives, give, third_singular, present).
irregular_form(give, give, plural, present).

% KNOW (saber)
irregular_form(know, know, first_singular, present).
irregular_form(know, know, second_singular, present).
irregular_form(knows, know, third_singular, present).
irregular_form(know, know, plural, present).

% WANT (querer) - Técnicamente regular, pero incluido por consistencia
irregular_form(want, want, first_singular, present).
irregular_form(want, want, second_singular, present).
irregular_form(wants, want, third_singular, present).
irregular_form(want, want, plural, present).

% CAN (poder) - Modal verb
irregular_form(can, can, first_singular, present).
irregular_form(can, can, second_singular, present).
irregular_form(can, can, third_singular, present).
irregular_form(can, can, plural, present).

% LIKE (gustar)
irregular_form(like, like, first_singular, present).
irregular_form(like, like, second_singular, present).
irregular_form(likes, like, third_singular, present).
irregular_form(like, like, plural, present).


% =============================================================================
% HELPER: Check if word is irregular form
% =============================================================================
% is_irregular_verb_form(+Word, -Infinitive, -Person, -Tense)
is_irregular_verb_form(Word, Infinitive, Person, Tense) :-
    irregular_form(Word, Infinitive, Person, Tense).


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