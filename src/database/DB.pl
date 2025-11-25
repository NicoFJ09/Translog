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
noun(bird, pájaro, masculine, singular).
noun(fish, pescado, masculine, singular).
noun(horse, caballo, masculine, singular).
noun(cow, vaca, feminine, singular).
noun(lion, león, masculine, singular).
noun(elephant, elefante, masculine, singular).

noun(man, hombre, masculine, singular).
noun(men, hombres, masculine, plural).
noun(woman, mujer, feminine, singular).
noun(women, mujeres, feminine, plural).
noun(boy, niño, masculine, singular).
noun(boys, niños, masculine, plural).
noun(girl, niña, feminine, singular).
noun(girls, niñas, feminine, plural).
noun(child, niño, masculine, singular).
noun(children, niños, masculine, plural).
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
noun(pencil, lápiz, masculine, singular).
noun(paper, papel, masculine, singular).
noun(computer, computadora, feminine, singular).
noun(phone, teléfono, masculine, singular).
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
noun(coffee, café, masculine, singular).
noun(tea, té, masculine, singular).

noun(day, día, masculine, singular).
noun(night, noche, feminine, singular).
noun(morning, mañana, feminine, singular).
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

% Conversacionales - Estados y emociones
noun(sleep, sueño, masculine, singular).
noun(dream, sueño, masculine, singular).
noun(hunger, hambre, feminine, singular).
noun(thirst, sed, feminine, singular).
noun(fear, miedo, masculine, singular).
noun(pain, dolor, masculine, singular).
noun(cold, frío, masculine, singular).
noun(heat, calor, masculine, singular).
noun(luck, suerte, feminine, singular).
noun(problem, problema, masculine, singular).
noun(problems, problemas, masculine, plural).
noun(solution, solución, feminine, singular).
noun(idea, idea, feminine, singular).
noun(ideas, ideas, feminine, plural).
noun(reason, razón, feminine, singular).
noun(truth, verdad, feminine, singular).
noun(lie, mentira, feminine, singular).

% Conversacionales - Actividades diarias
noun(breakfast, desayuno, masculine, singular).
noun(lunch, almuerzo, masculine, singular).
noun(dinner, cena, feminine, singular).
noun(meal, comida, feminine, singular).
noun(party, fiesta, feminine, singular).
noun(meeting, reunión, feminine, singular).
noun(class, clase, feminine, singular).
noun(classes, clases, feminine, plural).
noun(homework, tarea, feminine, singular).
noun(exam, examen, masculine, singular).
noun(test, prueba, feminine, singular).
noun(vacation, vacaciones, feminine, plural).
noun(weekend, fin_de_semana, masculine, singular).

% Conversacionales - Personas y relaciones
noun(girlfriend, novia, feminine, singular).
noun(boyfriend, novio, masculine, singular).
noun(husband, esposo, masculine, singular).
noun(wife, esposa, feminine, singular).
noun(son, hijo, masculine, singular).
noun(daughter, hija, feminine, singular).
noun(baby, bebé, masculine, singular).
noun(person, persona, feminine, singular).
noun(people, gente, feminine, singular).
noun(neighbor, vecino, masculine, singular).
noun(boss, jefe, masculine, singular).

% Conversacionales - Lugares comunes
noun(bathroom, baño, masculine, singular).
noun(bedroom, habitación, feminine, singular).
noun(kitchen, cocina, feminine, singular).
noun(living_room, sala, feminine, singular).
noun(garden, jardín, masculine, singular).
noun(beach, playa, feminine, singular).
noun(mountain, montaña, feminine, singular).
noun(river, río, masculine, singular).
noun(lake, lago, masculine, singular).
noun(mall, centro_comercial, masculine, singular).
noun(bank, banco, masculine, singular).
noun(pharmacy, farmacia, feminine, singular).
noun(supermarket, supermercado, masculine, singular).
noun(airport, aeropuerto, masculine, singular).
noun(station, estación, feminine, singular).
noun(street, calle, feminine, singular).
noun(corner, esquina, feminine, singular).

% Conversacionales - Tecnología y objetos modernos
noun(cellphone, celular, masculine, singular).
noun(email, correo, masculine, singular).
noun(internet, internet, masculine, singular).
noun(website, sitio_web, masculine, singular).
noun(password, contraseña, feminine, singular).
noun(message, mensaje, masculine, singular).
noun(photo, foto, feminine, singular).
noun(picture, imagen, feminine, singular).
noun(video, video, masculine, singular).
noun(music, música, feminine, singular).
noun(song, canción, feminine, singular).
noun(movie, película, feminine, singular).
noun(show, programa, masculine, singular).
noun(news, noticias, feminine, plural).

% Conversacionales - Clima y naturaleza
noun(weather, clima, masculine, singular).
noun(rain, lluvia, feminine, singular).
noun(sun, sol, masculine, singular).
noun(cloud, nube, feminine, singular).
noun(wind, viento, masculine, singular).
noun(snow, nieve, feminine, singular).
noun(storm, tormenta, feminine, singular).
noun(tree, árbol, masculine, singular).
noun(flower, flor, feminine, singular).
noun(plant, planta, feminine, singular).

% Conversacionales - Ropa y apariencia
noun(clothes, ropa, feminine, singular).
noun(shirt, camisa, feminine, singular).
noun(pants, pantalones, masculine, plural).
noun(dress, vestido, masculine, singular).
noun(shoes, zapatos, masculine, plural).
noun(jacket, chaqueta, feminine, singular).
noun(hat, sombrero, masculine, singular).
noun(glasses, gafas, feminine, plural).

% Conversacionales - Dinero y compras
noun(money, dinero, masculine, singular).
noun(dollar, dólar, masculine, singular).
noun(price, precio, masculine, singular).
noun(discount, descuento, masculine, singular).
noun(gift, regalo, masculine, singular).
noun(bag, bolsa, feminine, singular).
noun(wallet, cartera, feminine, singular).
noun(credit_card, tarjeta, feminine, singular).

% Alias sin tildes (acepta español sin tilde, mismo inglés)
noun(boy, nino, masculine, singular).
noun(boys, ninos, masculine, plural).
noun(girl, nina, feminine, singular).
noun(girls, ninas, feminine, plural).
noun(bird, pajaro, masculine, singular).
noun(lion, leon, masculine, singular).
noun(pencil, lapiz, masculine, singular).
noun(phone, telefono, masculine, singular).
noun(coffee, cafe, masculine, singular).
noun(day, dia, masculine, singular).
noun(morning, manana, feminine, singular).
noun(tea, te, masculine, singular).

% Alias conversacionales sin tildes
noun(sleep, sueno, masculine, singular).
noun(dream, sueno, masculine, singular).
noun(baby, bebe, masculine, singular).
noun(reason, razon, feminine, singular).
noun(meeting, reunion, feminine, singular).
noun(solution, solucion, feminine, singular).
noun(weekend, fin_de_semana, masculine, singular).
noun(station, estacion, feminine, singular).
noun(song, cancion, feminine, singular).
noun(movie, pelicula, feminine, singular).
noun(tree, arbol, masculine, singular).
noun(dollar, dolar, masculine, singular).

% =============================================================================
% ADJECTIVES - adjective(English, Spanish, Gender, Number)
% =============================================================================

adjective(big, grande, masculine, singular).
adjective(big, grande, feminine, singular).
adjective(big, grandes, masculine, plural).
adjective(big, grandes, feminine, plural).
adjective(small, pequeño, masculine, singular).
adjective(small, pequeña, feminine, singular).
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
adjective(angry, enojados, masculine, plural).
adjective(angry, enojadas, feminine, plural).
adjective(tired, cansado, masculine, singular).
adjective(tired, cansada, feminine, singular).
adjective(tired, cansados, masculine, plural).
adjective(tired, cansadas, feminine, plural).

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

adjective(fast, rápido, masculine, singular).
adjective(fast, rápida, feminine, singular).
adjective(slow, lento, masculine, singular).
adjective(slow, lenta, feminine, singular).
adjective(easy, fácil, masculine, singular).
adjective(easy, fácil, feminine, singular).
adjective(difficult, difícil, masculine, singular).
adjective(difficult, difícil, feminine, singular).

adjective(hot, caliente, masculine, singular).
adjective(hot, caliente, feminine, singular).
adjective(cold, frío, masculine, singular).
adjective(cold, fría, feminine, singular).

adjective(important, importante, masculine, singular).
adjective(important, importante, feminine, singular).
adjective(intelligent, inteligente, masculine, singular).
adjective(intelligent, inteligente, feminine, singular).
adjective(favorite, favorito, masculine, singular).
adjective(favorite, favorita, feminine, singular).

% Conversacionales - Estados y sentimientos
adjective(sleepy, somnoliento, masculine, singular).
adjective(sleepy, somnolienta, feminine, singular).
adjective(sleepy, somnolientos, masculine, plural).
adjective(sleepy, somnolientas, feminine, plural).
adjective(hungry, hambriento, masculine, singular).
adjective(hungry, hambrienta, feminine, singular).
adjective(hungry, hambrientos, masculine, plural).
adjective(hungry, hambrientas, feminine, plural).
adjective(thirsty, sediento, masculine, singular).
adjective(thirsty, sedienta, feminine, singular).
adjective(sick, enfermo, masculine, singular).
adjective(sick, enferma, feminine, singular).
adjective(sick, enfermos, masculine, plural).
adjective(sick, enfermas, feminine, plural).
adjective(healthy, sano, masculine, singular).
adjective(healthy, sana, feminine, singular).
adjective(healthy, sanos, masculine, plural).
adjective(healthy, sanas, feminine, plural).
adjective(nervous, nervioso, masculine, singular).
adjective(nervous, nerviosa, feminine, singular).
adjective(nervous, nerviosos, masculine, plural).
adjective(nervous, nerviosas, feminine, plural).
adjective(worried, preocupado, masculine, singular).
adjective(worried, preocupada, feminine, singular).
adjective(worried, preocupados, masculine, plural).
adjective(worried, preocupadas, feminine, plural).
adjective(excited, emocionado, masculine, singular).
adjective(excited, emocionada, feminine, singular).
adjective(excited, emocionados, masculine, plural).
adjective(excited, emocionadas, feminine, plural).
adjective(bored, aburrido, masculine, singular).
adjective(bored, aburrida, feminine, singular).
adjective(bored, aburridos, masculine, plural).
adjective(bored, aburridas, feminine, plural).
adjective(busy, ocupado, masculine, singular).
adjective(busy, ocupada, feminine, singular).
adjective(busy, ocupados, masculine, plural).
adjective(busy, ocupadas, feminine, plural).
adjective(free, libre, masculine, singular).
adjective(free, libre, feminine, singular).
adjective(ready, listo, masculine, singular).
adjective(ready, lista, feminine, singular).

% Conversacionales - Descripciones comunes
adjective(expensive, caro, masculine, singular).
adjective(expensive, cara, feminine, singular).
adjective(cheap, barato, masculine, singular).
adjective(cheap, barata, feminine, singular).
adjective(empty, vacío, masculine, singular).
adjective(empty, vacía, feminine, singular).
adjective(full, lleno, masculine, singular).
adjective(full, llena, feminine, singular).
adjective(wet, mojado, masculine, singular).
adjective(wet, mojada, feminine, singular).
adjective(dry, seco, masculine, singular).
adjective(dry, seca, feminine, singular).
adjective(strong, fuerte, masculine, singular).
adjective(strong, fuerte, feminine, singular).
adjective(weak, débil, masculine, singular).
adjective(weak, débil, feminine, singular).
adjective(loud, ruidoso, masculine, singular).
adjective(loud, ruidosa, feminine, singular).
adjective(quiet, tranquilo, masculine, singular).
adjective(quiet, tranquila, feminine, singular).
adjective(bright, brillante, masculine, singular).
adjective(bright, brillante, feminine, singular).
adjective(dark, oscuro, masculine, singular).
adjective(dark, oscura, feminine, singular).
adjective(near, cercano, masculine, singular).
adjective(near, cercana, feminine, singular).
adjective(far, lejano, masculine, singular).
adjective(far, lejana, feminine, singular).
adjective(early, temprano, masculine, singular).
adjective(early, temprana, feminine, singular).
adjective(late, tarde, masculine, singular).
adjective(late, tarde, feminine, singular).
adjective(next, próximo, masculine, singular).
adjective(next, próxima, feminine, singular).
adjective(last, último, masculine, singular).
adjective(last, última, feminine, singular).
adjective(same, mismo, masculine, singular).
adjective(same, misma, feminine, singular).
adjective(different, diferente, masculine, singular).
adjective(different, diferente, feminine, singular).
adjective(special, especial, masculine, singular).
adjective(special, especial, feminine, singular).
adjective(normal, normal, masculine, singular).
adjective(normal, normal, feminine, singular).
adjective(strange, extraño, masculine, singular).
adjective(strange, extraña, feminine, singular).
adjective(perfect, perfecto, masculine, singular).
adjective(perfect, perfecta, feminine, singular).
adjective(terrible, terrible, masculine, singular).
adjective(terrible, terrible, feminine, singular).
adjective(delicious, delicioso, masculine, singular).
adjective(delicious, deliciosa, feminine, singular).
adjective(wonderful, maravilloso, masculine, singular).
adjective(wonderful, maravillosa, feminine, singular).

% Alias sin tildes (mismo inglés, pero acepta español sin tilde)
adjective(small, pequeno, masculine, singular).
adjective(small, pequena, feminine, singular).
adjective(fast, rapido, masculine, singular).
adjective(fast, rapida, feminine, singular).
adjective(easy, facil, masculine, singular).
adjective(easy, facil, feminine, singular).
adjective(difficult, dificil, masculine, singular).
adjective(difficult, dificil, feminine, singular).
adjective(cold, frio, masculine, singular).
adjective(cold, fria, feminine, singular).

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
verb_infinitive(teach, enseñar, ar).
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

% Conversacionales - Acciones comunes del día a día
verb_infinitive(sleep, dormir, ir).
verb_infinitive(wake, despertar, ar).
verb_infinitive(rest, descansar, ar).
verb_infinitive(start, empezar, ar).
verb_infinitive(finish, terminar, ar).
verb_infinitive(continue, continuar, ar).
verb_infinitive(stop, parar, ar).
verb_infinitive(try, intentar, ar).
verb_infinitive(think, pensar, ar).
verb_infinitive(believe, creer, er).
verb_infinitive(know, saber, er).
verb_infinitive(understand, entender, er).
verb_infinitive(forget, olvidar, ar).
verb_infinitive(remember, recordar, ar).
verb_infinitive(want, querer, er).
verb_infinitive(prefer, preferir, ir).
verb_infinitive(like, gustar, ar).
verb_infinitive(love, amar, ar).
verb_infinitive(hate, odiar, ar).
verb_infinitive(feel, sentir, ir).
verb_infinitive(seem, parecer, er).
verb_infinitive(hope, esperar, ar).
verb_infinitive(wish, desear, ar).
verb_infinitive(dream, soñar, ar).

% Conversacionales - Comunicación
verb_infinitive(say, decir, ir).
verb_infinitive(tell, contar, ar).
verb_infinitive(talk, hablar, ar).
verb_infinitive(speak, hablar, ar).
verb_infinitive(explain, explicar, ar).
verb_infinitive(answer, responder, er).
verb_infinitive(ask, preguntar, ar).
verb_infinitive(call, llamar, ar).
verb_infinitive(text, enviar_mensaje, ar).
verb_infinitive(email, enviar_correo, ar).
verb_infinitive(chat, chatear, ar).

% Conversacionales - Movimiento y transporte
verb_infinitive(go, ir, ir).
verb_infinitive(come, venir, ir).
verb_infinitive(arrive, llegar, ar).
verb_infinitive(leave, salir, ir).
verb_infinitive(return, regresar, ar).
verb_infinitive(enter, entrar, ar).
verb_infinitive(exit, salir, ir).
verb_infinitive(walk, caminar, ar).
verb_infinitive(run, correr, er).
verb_infinitive(drive, manejar, ar).
verb_infinitive(travel, viajar, ar).
verb_infinitive(fly, volar, ar).

% Conversacionales - Actividades cotidianas
verb_infinitive(wake_up, despertar, ar).
verb_infinitive(get_up, levantar, ar).
verb_infinitive(shower, duchar, ar).
verb_infinitive(dress, vestir, ir).
verb_infinitive(prepare, preparar, ar).
verb_infinitive(make, hacer, er).
verb_infinitive(do, hacer, er).
verb_infinitive(cook, cocinar, ar).
verb_infinitive(wash, lavar, ar).
verb_infinitive(clean, limpiar, ar).
verb_infinitive(organize, organizar, ar).
verb_infinitive(fix, arreglar, ar).
verb_infinitive(break, romper, er).
verb_infinitive(lose, perder, er).
verb_infinitive(find, encontrar, ar).
verb_infinitive(search, buscar, ar).
verb_infinitive(look_for, buscar, ar).

% Conversacionales - Compras y dinero
verb_infinitive(buy, comprar, ar).
verb_infinitive(sell, vender, er).
verb_infinitive(pay, pagar, ar).
verb_infinitive(cost, costar, ar).
verb_infinitive(spend, gastar, ar).
verb_infinitive(save, ahorrar, ar).
verb_infinitive(lend, prestar, ar).
verb_infinitive(borrow, pedir_prestado, ar).
verb_infinitive(owe, deber, er).

% Conversacionales - Estudio y trabajo
verb_infinitive(study, estudiar, ar).
verb_infinitive(learn, aprender, er).
verb_infinitive(teach, enseñar, ar).
verb_infinitive(practice, practicar, ar).
verb_infinitive(work, trabajar, ar).
verb_infinitive(help, ayudar, ar).
verb_infinitive(solve, resolver, er).
verb_infinitive(pass, pasar, ar).
verb_infinitive(fail, fallar, ar).

% Conversacionales - Tecnología
verb_infinitive(use, usar, ar).
verb_infinitive(click, hacer_clic, ar).
verb_infinitive(download, descargar, ar).
verb_infinitive(upload, subir, ir).
verb_infinitive(send, enviar, ar).
verb_infinitive(receive, recibir, ir).
verb_infinitive(share, compartir, ir).
verb_infinitive(post, publicar, ar).
verb_infinitive(like, gustar, ar).
verb_infinitive(follow, seguir, ir).

% Conversacionales - Entretenimiento
verb_infinitive(play, jugar, ar).
verb_infinitive(watch, mirar, ar).
verb_infinitive(listen, escuchar, ar).
verb_infinitive(read, leer, er).
verb_infinitive(dance, bailar, ar).
verb_infinitive(sing, cantar, ar).
verb_infinitive(enjoy, disfrutar, ar).
verb_infinitive(celebrate, celebrar, ar).
verb_infinitive(laugh, reír, ir).
verb_infinitive(cry, llorar, ar).
verb_infinitive(smile, sonreír, ir).

% Conversacionales - Salud y cuidado
verb_infinitive(hurt, doler, er).
verb_infinitive(heal, sanar, ar).
verb_infinitive(cure, curar, ar).
verb_infinitive(exercise, ejercitar, ar).
verb_infinitive(relax, relajar, ar).
verb_infinitive(breathe, respirar, ar).

% Conversacionales - Dar y recibir
verb_infinitive(give, dar, ar).
verb_infinitive(receive, recibir, ir).
verb_infinitive(take, tomar, ar).
verb_infinitive(bring, traer, er).
verb_infinitive(carry, llevar, ar).
verb_infinitive(get, obtener, er).
verb_infinitive(put, poner, er).
verb_infinitive(place, colocar, ar).
verb_infinitive(throw, tirar, ar).
verb_infinitive(catch, atrapar, ar).

% Alias sin tildes (acepta español sin tilde, mismo inglés)
verb_infinitive(teach, ensenar, ar).

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
irregular_form_spanish(es, ser, ella, present).
irregular_form_spanish(somos, ser, nosotros, present).
irregular_form_spanish(son, ser, ellos, present).
irregular_form_spanish(son, ser, ellas, present).

irregular_form_spanish(estoy, estar, yo, present).
irregular_form_spanish(estas, estar, tu, present).
irregular_form_spanish(esta, estar, el, present).
irregular_form_spanish(esta, estar, ella, present).
irregular_form_spanish(estamos, estar, nosotros, present).
irregular_form_spanish(estan, estar, ellos, present).
irregular_form_spanish(estan, estar, ellas, present).

irregular_form_spanish(voy, ir, yo, present).
irregular_form_spanish(vas, ir, tu, present).
irregular_form_spanish(va, ir, el, present).
irregular_form_spanish(va, ir, ella, present).
irregular_form_spanish(vamos, ir, nosotros, present).
irregular_form_spanish(van, ir, ellos, present).
irregular_form_spanish(van, ir, ellas, present).

irregular_form_spanish(tengo, tener, yo, present).
irregular_form_spanish(tienes, tener, tu, present).
irregular_form_spanish(tiene, tener, el, present).
irregular_form_spanish(tiene, tener, ella, present).
irregular_form_spanish(tenemos, tener, nosotros, present).
irregular_form_spanish(tienen, tener, ellos, present).
irregular_form_spanish(tienen, tener, ellas, present).

irregular_form_spanish(hago, hacer, yo, present).
irregular_form_spanish(haces, hacer, tu, present).
irregular_form_spanish(hace, hacer, el, present).
irregular_form_spanish(hace, hacer, ella, present).
irregular_form_spanish(hacemos, hacer, nosotros, present).
irregular_form_spanish(hacen, hacer, ellos, present).
irregular_form_spanish(hacen, hacer, ellas, present).

% Forms of "beber" (to drink) - marked as irregular to prioritize over noun "bebe" (baby)
irregular_form_spanish(bebo, beber, yo, present).
irregular_form_spanish(bebes, beber, tu, present).
irregular_form_spanish(bebe, beber, el, present).
irregular_form_spanish(bebe, beber, ella, present).
irregular_form_spanish(bebemos, beber, nosotros, present).
irregular_form_spanish(beben, beber, ellos, present).
irregular_form_spanish(beben, beber, ellas, present).

% =============================================================================
% IRREGULAR VERB PAIRS
% =============================================================================

irregular_verb_pair(ser, be).
irregular_verb_pair(estar, be).
irregular_verb_pair(ir, go).
irregular_verb_pair(tener, have).
irregular_verb_pair(hacer, do).
irregular_verb_pair(beber, drink).

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
adverb(fast, rápido).
adverb(always, siempre).
adverb(never, nunca).
adverb(now, ahora).
adverb(today, hoy).
adverb(here, aquí).
adverb(there, allí).
adverb(much, mucho).
adverb(more, más).
adverb(less, menos).

% Conversacionales - Frecuencia y tiempo
adverb(sometimes, a_veces).
adverb(often, a_menudo).
adverb(rarely, raramente).
adverb(daily, diariamente).
adverb(usually, usualmente).
adverb(normally, normalmente).
adverb(recently, recientemente).
adverb(soon, pronto).
adverb(later, luego).
adverb(already, ya).
adverb(still, todavía).
adverb(yet, aún).
adverb(again, otra_vez).
adverb(finally, finalmente).
adverb(immediately, inmediatamente).
adverb(suddenly, repentinamente).

% Conversacionales - Manera e intensidad
adverb(really, realmente).
adverb(truly, verdaderamente).
adverb(almost, casi).
adverb(quite, bastante).
adverb(too, demasiado).
adverb(enough, suficiente).
adverb(totally, totalmente).
adverb(completely, completamente).
adverb(perfectly, perfectamente).
adverb(clearly, claramente).
adverb(easily, fácilmente).
adverb(hardly, apenas).
adverb(barely, apenas).
adverb(exactly, exactamente).
adverb(probably, probablemente).
adverb(maybe, quizás).
adverb(perhaps, tal_vez).
adverb(certainly, ciertamente).
adverb(definitely, definitivamente).
adverb(absolutely, absolutamente).
adverb(obviously, obviamente).

% Conversacionales - Lugar (aunque algunos son preposiciones)
adverb(everywhere, en_todas_partes).
adverb(nowhere, en_ninguna_parte).
adverb(somewhere, en_alguna_parte).
adverb(outside, afuera).
adverb(inside, adentro).
adverb(upstairs, arriba).
adverb(downstairs, abajo).
adverb(nearby, cerca).
adverb(away, lejos).
adverb(together, juntos).
adverb(alone, solo).

% Alias sin tildes (mismo inglés, acepta español sin tilde)
adverb(fast, rapido).
adverb(here, aqui).
adverb(there, alli).
adverb(more, mas).

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

question_word(what, qué).
question_word(where, dónde).
question_word(when, cuándo).
question_word(who, quién).
question_word(why, por_que).

% Alias sin tildes (acepta español sin tilde -> output en inglés igual)
% Las question words se manejan en el traductor.pl directamente

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
common_phrase(goodbye, adiós).
common_phrase(bye, adiós).
common_phrase(please, por_favor).
common_phrase(thanks, gracias).
common_phrase(thank_you, gracias).
common_phrase(yes, sí).
common_phrase(ok, ok).

% Alias sin tildes (acepta español sin tilde, mismo inglés)
common_phrase(goodbye, adios).
common_phrase(bye, adios).
common_phrase(yes, si).

% =============================================================================
% AUXILIARIES
% =============================================================================

auxiliary(do).
auxiliary(does).
auxiliary(is).
auxiliary(are).
auxiliary(am).

% =============================================================================
% NUMBER WORDS - number_word(English, Spanish)
% =============================================================================

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
number_word(thirty, treinta).
number_word(forty, cuarenta).
number_word(fifty, cincuenta).
number_word(sixty, sesenta).
number_word(seventy, setenta).
number_word(eighty, ochenta).
number_word(ninety, noventa).
number_word(hundred, cien).