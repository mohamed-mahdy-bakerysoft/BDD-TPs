# Ejercicio: Juegos Olímpicos

### Esquema de BD:

**JUEGO** `<año_olimpiada, pais_olimpiada, nombre_deportista, pais_deportista, nombre_disciplina, asistente>`

### Restricciones

- **a.** `pais_olimpiada` es el país donde se realizó el juego olímpico del año correspondiente.
- **b.** `pais_deportista` es el país que representa el deportista.
- **c.** Un deportista representa en todos los juegos olímpicos siempre al mismo país. Por un país, participan varios deportistas en cada juego olímpico.
- **d.** En un año determinado, se celebran los juegos olímpicos en un solo país, pero en un país pueden haberse jugado varios juegos olímpicos en diferentes años.
- **e.** Cada deportista puede participar en varios juegos olímpicos y en varias disciplinas en diferentes juegos olímpicos. Sin embargo, en un juego olímpico participa solamente en una disciplina.
- **f.** Un deportista tiene un asistente en cada juego olímpico, pero el asistente puede variar en diferentes juegos.

---

## Paso 1: Determinar las Dependencias Funcionales (DFs)

A partir del esquema y las restricciones dadas, podemos determinar las siguientes dependencias funcionales:

1. **`año_olimpiada → pais_olimpiada`:** En un año determinado, los juegos olímpicos se realizan en un solo país, por lo que `pais_olimpiada` depende funcionalmente de `año_olimpiada`.

2. **`nombre_deportista → pais_deportista`:** Un deportista representa siempre al mismo país en todos los juegos olímpicos, por lo que `pais_deportista` depende de `nombre_deportista`.

3. **`año_olimpiada, nombre_deportista → nombre_disciplina`:** `nombre_disciplina` depende funcionalmente de la combinación entre `año_olimpiada` y `nombre_deportista`, ya que cada deportista puede participar en varios juegos olímpicos y en varias disciplinas en diferentes juegos olímpicos, pero en un juego olímpico solo participa en una disciplina.

4. **`año_olimpiada, nombre_deportista → asistente`:** Un deportista tiene un asistente en cada juego olímpico, pero el asistente puede variar dependiendo del año.

---

## Paso 2: Determinar las Claves Candidatas

Para determinar las claves candidatas, necesitamos encontrar un conjunto de atributos que puedan identificar de manera única cada fila de la tabla `JUEGOS`.

La combinación de `año_olimpiada` y `nombre_deportista` es suficiente para identificar de manera única cada registro en la tabla.

- `año_olimpiada` identifica el año en que se realizó el evento.
- `nombre_deportista` identifica el deportista que participó en ese año.

Entonces, la clave candidata queda de la siguiente forma:

- **(año_olimpiada, nombre_deportista)**

---

## Paso 3: Diseño en Tercera Forma Normal (3FN)

La tabla original se dividió en tres tablas (`Juego`, `Deportista`, `Participacion`) para eliminar dependencias transitivas y garantizar que cada atributo no clave dependa únicamente de la clave primaria completa.

### Nuevo diseño en 3FN

#### Tabla **Juego**

- `año_olimpiada` (clave primaria)
- `pais_olimpiada`

#### Tabla **Deportista**

- `nombre_deportista` (clave primaria)
- `pais_deportista`

#### Tabla **Participacion**

- `año_olimpiada` (clave foránea que referencia a `Juego`)
- `nombre_deportista` (clave foránea que referencia a `Deportista`)
- `nombre_disciplina`
- `asistente`
- Clave primaria compuesta: **(año_olimpiada, nombre_deportista)**
