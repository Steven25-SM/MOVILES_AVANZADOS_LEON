# Prompts utilizados — Laboratorio 04

## Herramienta de IA utilizada
Gemini

## Caso 2B — Biblioteca

### Prompt 1:
CONTEXTO: Soy estudiante de Swift, en mi cuarta semana, trabajando en un Xcode Playground.
TAREA: Genera el código para un sistema de biblioteca con enum EstadoLibro (.disponible, .prestado), struct Libro (titulo, autor, estado) y class Biblioteca (arreglo de libros, métodos agregar, prestar, devolver e inventario).
RESTRICCIONES: Usa únicamente struct, class, enums, arrays, bucles for por índice y condicionales (if/switch). Queda estrictamente prohibido usar optionals, guard let, firstIndex(where:), didSet, propiedades calculadas, genéricos o closures.
FORMATO: Dame solo el código fuente. Agrega obligatoriamente un comentario explicativo al final de CADA línea de código.
EJEMPLO DE SALIDA ESPERADA:
Préstamo aprobado: La ciudad y los perros
Error: La ciudad y los perros ya está prestado
Devolución registrada: La ciudad y los perros
Préstamo aprobado: El Quijote
Error: no existe El Principito
===== INVENTARIO =====
Cien años de soledad (Gabriel García Márquez) - disponible
La ciudad y los perros (Mario Vargas Llosa) - disponible
El Quijote (Miguel de Cervantes) - prestado

### Respuesta de la IA:
La IA generó las estructuras `EstadoLibro`, `Libro` y `Biblioteca` utilizando únicamente bucles por índice (`for i in 0..<libros.count`) para permitir la mutación de los `struct` dentro del arreglo, añadiendo comentarios detallados en absolutamente cada línea.

### ¿Funcionó a la primera?
Sí. Al incluir las restricciones explícitas de no usar `firstIndex(where:)` ni `guard let` en el prompt inicial, la IA no utilizó características avanzadas y generó la lógica requerida al primer intento.

### ¿Usó algo que no hemos visto en clase?
No. La solución se mantuvo 100% dentro de los temas vistos: tipos de valor (`struct`), tipos de referencia (`class`), enumeraciones, arreglos, condicionales `if/switch` y bucles por índice.

---

## Mi versión (Parte A) vs. la versión de la IA (Parte B)

### ¿Qué hizo distinto la IA respecto a mi solución?
La lógica interna y el flujo de ejecución son idénticos. La diferencia principal radica en que la IA comentó cada línea individual de código explicando el porqué de cada instrucción (como el valor por copia de los structs). Además, en mi versión (Parte A) incluí la anotación `@discardableResult` para evitar los *warnings* al llamar a métodos con retorno `Bool`, algo que la IA omitió por defecto.

### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?
Entiendo todas las líneas. La sentencia `libros[i].estado = .prestado` mediante acceso directo al índice es totalmente clara, ya que modifica la propiedad del struct mutando la colección original de la clase `Biblioteca`.

### ¿Qué me pareció mejor de MI versión?
Mi versión es visualmente más limpia y legible sin el exceso de comentarios en cada línea. Asimismo, cuenta con la anotación `@discardableResult`, garantizando una compilación 100% limpia sin advertencias en la consola.

### ¿Qué me pareció mejor de la versión de la IA?
Los comentarios explicativos detallados en cada línea resultan muy útiles como guía de estudio rápida para repasar conceptos como el comportamiento de pasaje por valor vs. referencia.
