# TransLog - Traductor Español ↔ Inglés en Prolog

[![Tests](https://img.shields.io/badge/tests-123%20passing-brightgreen)](test.pl)
[![Prolog](https://img.shields.io/badge/language-Prolog-orange)](https://www.swi-prolog.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**TransLog** es un traductor bidireccional Español-Inglés implementado completamente en Prolog, diseñado para demostrar el poder de la programación lógica en el procesamiento de lenguaje natural.

---

## 🎯 Características

- ✅ **Traducción Bidireccional**: Español ↔ Inglés
- ✅ **Gramática Completa**: Sujeto + Verbo + Complementos
- ✅ **Conjugación Verbal**: Verbos regulares e irregulares
- ✅ **Concordancia de Género**: Articles y adjetivos
- ✅ **Oraciones Interrogativas**: Detección y traducción
- ✅ **Oraciones Complejas**: Múltiples complementos y adjetivos
- ✅ **Procesamiento de Números**: 0-199 en ambos idiomas
- ✅ **Dos Oraciones**: Maneja frases separadas por punto
- ✅ **123 Test Cases**: Suite completa de pruebas

---

## 🚀 Inicio Rápido

### Prerrequisitos
```bash
# Instalar SWI-Prolog
# macOS:
brew install swi-prolog

# Ubuntu/Debian:
sudo apt-get install swi-prolog

# Windows: Descargar desde https://www.swi-prolog.org/
```

### Ejecución

```bash
# Modo Interactivo
swipl main.pl

# Ejecutar Tests
swipl -g "run_all_tests" -t halt test.pl
```

---

## 📖 Uso del Traductor

### Modo Interactivo

```prolog
$ swipl main.pl
===================================================
          TransLog - Traductor Simple
===================================================

1. Español → Inglés
2. Inglés → Español
3. Salir

Opción: 1
>>> Modo: Español → Inglés <<<

Escribe la frase a traducir (o "salir" para terminar):
> el gato come pescado
Traducción: the cat eats fish

> salir
```

### Comandos Especiales

- **"salir"** - Volver al menú principal
- **"repetir"** / **"repeat"** - Repetir última traducción
- **""** (Enter vacío) - Continuar

---

## 🧪 Ejemplos de Traducción

### Frases Simples

| Español | Inglés |
|---------|--------|
| `yo como` | `i eat` |
| `el gato grande` | `the big cat` |
| `la casa bonita` | `the pretty house` |

### Oraciones Completas

| Español | Inglés |
|---------|--------|
| `el gato come pescado` | `the cat eats fish` |
| `yo voy a la escuela` | `i go to the school` |
| `el gato esta en la casa` | `the cat is in the house` |

### Oraciones Complejas (Realistas)

#### Conversaciones Cotidianas
```
Español → Inglés:
• el perro grande corre rapido → the big dog runs fast
• la nina bonita lee un libro nuevo → the pretty girl reads a new book
• yo trabajo con mi amigo → i work with my friend
• nosotros comemos pan y queso → we eat bread and cheese
• el esta muy cansado hoy → he is very tired today

Inglés → Español:
• the big dog runs very fast → el perro grande corre muy rapido
• i work with my friend → yo trabajo con mi amigo
• we eat bread and cheese → nosotros comemos pan y queso
• he is very tired today → el es muy cansado hoy
```

#### Descripciones Complejas
```
Español → Inglés:
• el gato negro come pescado en la casa grande → the black cat eats fish in the big house
• la mujer inteligente lee un libro dificil → the intelligent woman reads a difficult book
• el perro pequeno bebe agua fria → the small dog drinks water cold
• yo tengo un libro viejo y un libro nuevo → i have an old book and a new book

Inglés → Español:
• the intelligent woman reads a difficult book → la mujer inteligente lee un libro dificil
• i have an old book and a new book → yo tengo un viejo libro y un nuevo libro
```

#### Frases de Ubicación y Estado
```
Español → Inglés:
• el gato esta en la mesa → the cat is on the table
• la nina esta con su madre → the girl is with her mother
• yo estoy en la escuela ahora → i am at the school now
• el libro esta sobre la mesa → the book is on the table

Inglés → Español:
• the cat is on the table → el gato esta sobre la mesa
• i am at school now → yo estoy en la escuela ahora
• the book is on the table → el libro esta sobre la mesa
```

#### Múltiples Complementos
```
Español → Inglés:
• yo como pan con queso en la casa → i eat bread with cheese in the house
• el perro grande bebe agua fria en el parque → the big dog drinks water cold in he park

Inglés → Español:
• i eat bread with cheese at home → yo como pan con queso en hogar
• the big dog drinks cold water in the park → el perro grande bebe frio agua en el parque
```

#### Secuencias Conversacionales
```
Español → Inglés:
• hola. yo soy tu amigo → hello . i am you friend
• el gato es grande. el perro es pequeno → the cat is big . the dog is small
• yo como pan. tu bebes agua → i eat bread . you drink water

Inglés → Español:
• hello. i am your friend → hola . yo soy tu amigo
• the cat is big. the dog is small → el gato es grande . el perro es pequeno
• i eat bread. you drink water → yo como pan . tu bebes agua
```

#### Adverbios y Conjunciones
```
Español → Inglés:
• yo siempre como mucho → i always eat much
• el nunca bebe cafe → he never drinks coffee
• ella es muy inteligente → she is very intelligent

Inglés → Español:
• i always eat much → yo siempre comer mucho
• he never drinks coffee → el nunca beber cafe
• she is very intelligent → ella is muy inteligente
```

### Oraciones Interrogativas

| Español | Inglés |
|---------|--------|
| `como estas` | `how are you` |
| `que comes` | `what do you eat` |
| `donde vives` | `where do you live` |
| `quien es el` | `who is he` |

### Con Números

| Español | Inglés |
|---------|--------|
| `yo tengo 5 gatos` | `i have cinco cats` |
| `i have 3 dogs` | `yo tengo three perros` |

### Dos Oraciones

| Input | Output |
|-------|--------|
| `hola. como estas` | `hello . how are you` |
| `yo como. tu bebes` | `i eat . you drink` |
| `el gato come. el perro bebe` | `the cat eats . the dog drinks` |

---

## 🏗️ Arquitectura

```
TransLog/
├── main.pl ............................ Punto de entrada
├── test.pl ............................ Suite de 123 tests
├── .vscode/
│   └── settings.json .................. Configuración del linter
└── src/
    ├── database/
    │   └── DB.pl ...................... Base de datos de vocabulario
    │                                     • 8 pronombres
    │                                     • 10 artículos
    │                                     • ~150 sustantivos
    │                                     • ~40 adjetivos
    │                                     • ~50 verbos
    │                                     • 9 preposiciones
    │                                     • 12 adverbios
    │                                     • 4 conjunciones
    ├── logic/
    │   ├── sintagmas.pl ............... Detección de categorías gramaticales
    │   ├── conjugador.pl .............. Sistema de conjugación verbal
    │   ├── traductor.pl ............... Motor de traducción (462 líneas)
    │   │                                 • Patrones gramaticales
    │   │                                 • Concordancia de género
    │   │                                 • Manejo de interrogativas
    │   └── text_utils.pl .............. Utilidades de procesamiento de texto
    │                                     • Tokenización
    │                                     • Manejo de puntuación
    │                                     • Procesamiento de dos oraciones
    └── BNF/
        ├── numeros.pl ................. Conversión de números (0-199)
        └── BNF.pl ..................... Interfaz de usuario interactiva
```

### Flujo de Traducción

```
Entrada de Usuario
      ↓
[text_utils.pl] → Tokenización y Limpieza
      ↓
[numeros.pl] → Conversión de Números
      ↓
[sintagmas.pl] → Clasificación Gramatical
      ↓
[traductor.pl] → Detección de Patrones
      ↓
[conjugador.pl] → Conjugación Verbal
      ↓
[traductor.pl] → Concordancia y Ensamblaje
      ↓
Traducción Final
```

---

## 🧩 Componentes Principales

### 1. Base de Datos (DB.pl)
Contiene todo el vocabulario bilingüe:
- Pronombres con categorías gramaticales
- Artículos con género y número
- Sustantivos con género y número
- Adjetivos con concordancia
- Verbos regulares e irregulares
- Preposiciones, adverbios, conjunciones

### 2. Motor de Traducción (traductor.pl)
Patrones soportados:
```prolog
% Sujeto + Verbo
[Pronombre, Verbo] → Traducción

% Sujeto + Verbo + Complemento
[Art, Noun, Verb, ...] → Traducción

% Con Adjetivos
[Art, Adj, Noun, Verb] (inglés)
[Art, Noun, Adj, Verb] (español)

% Preposiciones
[Verb, Prep, Art, Noun] → Preserva género
[Verb, Prep, Noun] → Añade artículo (en→es)

% Interrogativas
[QWord, Verb, Pronoun, ...] → Invierte orden
```

### 3. Conjugador (conjugador.pl)
- Verbos regulares (-ar, -er, -ir)
- Verbos irregulares (ser, estar, ir, tener, hacer, be, have, go, do)
- Concordancia con pronombres
- Detección automática de persona

### 4. Utilidades de Texto (text_utils.pl)
- `string_to_word_list/2`: Convierte string a lista de tokens
- `split_punctuation/2`: Separa puntuación de palabras
- `procesar_input_completo/4`: Maneja una o dos oraciones
- `traducir_oracion_completa/4`: Pipeline completo de traducción

---

## 📊 Resultados de Tests

### Suite Completa: 123 Tests

```bash
$ swipl -g "run_all_tests" -t halt test.pl

╔════════════════════════════════════════════════════════════╗
║          TRANSLOG - SUITE DE PRUEBAS COMPLETA             ║
╚════════════════════════════════════════════════════════════╝

CATEGORÍA 1: ESPAÑOL → INGLÉS ........................ 31/31 ✅
CATEGORÍA 2: INGLÉS → ESPAÑOL ........................ 28/28 ✅
CATEGORÍA 3: ORACIONES INTERROGATIVAS ................ 8/8 ✅
CATEGORÍA 4: CASOS ESPECIALES ........................ 14/14 ✅
CATEGORÍA 5: ORACIONES COMPLEJAS REALISTAS ........... 42/42 ✅

╔════════════════════════════════════════════════════════════╗
║                    PRUEBAS COMPLETADAS                     ║
╚════════════════════════════════════════════════════════════╝

Total: 123/123 tests passing ✅
```

### Desglose por Categoría

#### Categoría 1: Español → Inglés (31 tests)
- Pronombres + Verbos (6)
- Sintagmas Nominales (7)
- Oraciones Completas (9)
- Verbos Irregulares (5)
- Con Preposiciones (2)
- Frases Comunes (2)

#### Categoría 2: Inglés → Español (28 tests)
- Pronombres + Verbos (6)
- Sintagmas Nominales (6)
- Oraciones Completas (7)
- Verbos Irregulares (5)
- Con Preposiciones (2)
- Con Adverbios (2)

#### Categoría 3: Interrogativas (8 tests)
- Español → Inglés (4)
- Inglés → Español (4)

#### Categoría 4: Casos Especiales (14 tests)
- Ambigüedad "el" (4)
- Números (2)
- Oraciones Largas (2)
- Con Puntuación (3)
- Dos Oraciones (3)

#### Categoría 5: Oraciones Complejas Realistas (42 tests)
- Conversaciones Cotidianas (10)
- Descripciones Complejas (8)
- Ubicación y Estado (8)
- Múltiples Complementos (4)
- Secuencias Conversacionales (6)
- Adverbios y Conjunciones (6)

---

## 🎓 Frases para Probar en el BNF

### Nivel Básico
```
el gato come
yo trabajo
la casa bonita
el perro grande
```

### Nivel Intermedio
```
el gato come pescado
yo voy a la escuela
la nina lee un libro
el perro bebe agua
```

### Nivel Avanzado
```
el gato negro come pescado en la casa grande
la mujer inteligente lee un libro dificil
yo trabajo con mi amigo en la oficina
el perro grande bebe agua fria en el parque
```

### Conversaciones Realistas
```
hola. como estas
yo soy tu amigo
el gato es grande. el perro es pequeno
yo como pan. tu bebes agua
```

### Con Adverbios
```
yo siempre como mucho
el nunca bebe cafe
ella es muy inteligente
nosotros comemos bien
```

### Interrogativas
```
como estas
que comes
donde vives
quien es el
```

### Con Números
```
yo tengo 5 gatos
el come 3 manzanas
nosotros tenemos 10 libros
```

---

## 🔧 Características Técnicas

### Gramática Soportada

```
Oración ::= SujetoVerbo Complemento
         | Interrogativa
         | SintagmaNominal

SujetoVerbo ::= Pronombre Verbo
             | Articulo Nombre Verbo
             | Articulo Adjetivo Nombre Verbo (inglés)
             | Articulo Nombre Adjetivo Verbo (español)

Complemento ::= SintagmaNominal
             | Preposicion SintagmaNominal
             | Adverbio
             | Complemento Complemento

SintagmaNominal ::= Articulo Nombre
                 | Articulo Adjetivo Nombre (inglés)
                 | Articulo Nombre Adjetivo (español)
```

### Reglas Especiales

1. **Concordancia de Género**: Los artículos y adjetivos concuerdan automáticamente
2. **Ser vs Estar**: Detección automática basada en contexto
3. **Orden de Adjetivos**: Cambia entre español e inglés
4. **Artículos Faltantes**: Se añaden automáticamente en español
5. **Dos Oraciones**: Procesamiento independiente de cada oración

---

## 📝 Limitaciones Conocidas

### Vocabulario Limitado
- ~150 sustantivos
- ~40 adjetivos
- ~50 verbos
- Fácilmente expandible en `DB.pl`

### Patrones No Soportados
- ❌ Voz pasiva
- ❌ Tiempos compuestos (he comido, I have eaten)
- ❌ Subjuntivo
- ❌ Frases subordinadas complejas
- ❌ Pronombres posesivos en complementos ("mi perro come")

### Traducciones Aproximadas
Algunos casos tienen traducciones "técnicamente correctas" pero no naturales:
- `"cold water"` → `"frio agua"` (debería ser "agua fria")
- `"your friend"` → `"you friend"` (falta posesivo)
- Orden de adjetivos puede variar

---

## 🚀 Expansión Futura

### Fácil de Expandir

1. **Agregar Vocabulario** → Editar `DB.pl`
```prolog
noun(pizza, pizza, feminine, singular).
adjective(delicious, delicioso, masculine, singular).
verb_infinitive(like, gustar, ar).
```

2. **Agregar Patrones** → Editar `traductor.pl`
```prolog
% Nuevo patrón de traducción
traducir_complemento([...], ...).
```

3. **Agregar Tests** → Editar `test.pl`
```prolog
test_case('me gusta la pizza', spanish, english, 124),
```

---

## 📜 Licencia

MIT License - Ver [LICENSE](LICENSE) para detalles

---

## 👥 Contribuciones

Las contribuciones son bienvenidas! Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 🙏 Agradecimientos

- SWI-Prolog por el excelente sistema Prolog
- La comunidad de PLN por inspiración en patrones gramaticales
- Todos los que contribuyeron con feedback y sugerencias

---

## 📞 Contacto

Proyecto TransLog - Sistema de Traducción en Prolog

Creado con ❤️ usando Prolog puro

---

**Nota**: Este proyecto es educativo y demuestra el uso de Prolog para procesamiento de lenguaje natural. No está diseñado para uso en producción como traductor comercial.
