# Manual de Usuario - Translog

TransLog es un sistema de traducción bidireccional español-inglés implementado en Prolog. El sistema utiliza reglas gramaticales y una base de datos léxica para traducir oraciones en presente simple.

## REQUISITOS DEL SISTEMA

### Hardware mínimo:
- **Procesador:** 1 GHz o superior
- **RAM:** 512 MB mínimo
- **Espacio en disco:** 50 MB

### Software:
- **SWI-Prolog 8.0 o superior** (recomendado: 9.0+)
- Sistema operativo: Windows, macOS o Linux

### Instalación de SWI-Prolog:

**Windows:**
```bash
# Descargar desde: https://www.swi-prolog.org/download/stable
# Ejecutar instalador .exe
```

**macOS:**
```bash
brew install swi-prolog
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install swi-prolog
```

---

## INSTALACIÓN

### Paso 1: Descargar e iniciar el proyecto
```bash
# Clonar repositorio o descargar .zip
git clone https://github.com/NicoFJ09/Translog.git
cd translog
```

### Paso 2: Iniciar el sistema
```bash
# Abrir SWI-Prolog y ejecutar el proyecto.
swipl main.pl
```
---

## GUÍA DE USO

### Menú principal
```bash
===================================================
          TransLog - Traductor Simple              
===================================================

1. Español → Inglés
2. Inglés → Español
3. Salir

Opción:
```

### Modo de traducción

Una vez seleccionado el modo:
```
>>> Modo: Español → Inglés <<<

Escribe la frase a traducir (o "salir" para terminar):
> el gato grande come

Traducción: the big cat eats
```


## EJEMPLOS DE USO

### 1. Oraciones afirmativas simples

#### Estructura 1: S + V (Intransitivo)
```prolog
Entrada: "ella corre"
Salida:  "she runs"

Entrada: "i sleep"
Salida:  "yo duermo"
```

#### Estructura 2: S + V + O (Transitivo)
```prolog
Entrada: "yo como pan"
Salida:  "i eat bread"

Entrada: "the cat eats fish"
Salida:  "el gato come pescado"
```

#### Estructura 3: S + V + C (Copulativo)
```prolog
Entrada: "ella es feliz"
Salida:  "she is happy"

Entrada: "the dog is big"
Salida:  "el perro es grande"
```

### 2. Oraciones con adjetivos

```prolog
Entrada: "el gato grande come"
Salida:  "the big cat eats"

Entrada: "i read the good book"
Salida:  "yo leo el libro bueno"
```

### 3. Oraciones interrogativas

```prolog
Entrada: "where is he"
Salida:  "donde esta el"

Entrada: "como estas"
Salida:  "how are you"
```

### 4. Números

```prolog
Entrada: "tengo 25 gatos"
Salida:  "i have twenty-five cats"

Entrada: "i have 29 dogs"
Salida:  "yo tengo veintinueve perros"
```

---

## LIMITACIONES CONOCIDAS

### 1. **Vocabulario limitado**
- Aproximadamente 200 palabras base
- Solo verbos comunes
- Sustantivos básicos

### 2. **Tiempo verbal**
- **SOLO presente simple**
- No soporta: pasado, futuro, progresivo, perfecto, etc.

### 3. **Estructuras no soportadas**
- Oraciones subordinadas
- Voz pasiva
- Condicionales complejos
- Infinitivos como objeto (ej: "I want to eat")

### 4. **Ambigüedades**
- "el" puede ser artículo o pronombre (se resuelve por contexto)
- Algunos verbos irregulares no implementados

### 5. **Preprocesamiento**
- Los signos de puntuación se procesan pero no afectan la traducción
- Las mayúsculas se convierten a minúsculas

---
