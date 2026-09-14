# Prompts — Lab 03
## Docente: Juan Leon — Tecsup
## Herramienta: Claude

## Ejercicio 6 — Gestión de notas

### Prompt (CTRFE):
CONTEXTO: Soy estudiante de Programación en Móviles Avanzado, semana 3 de Swift,
solo conozco arrays, diccionarios, sets, bucles for/while y condicionales/switch.
No he visto struct/class/funciones avanzadas todavía.

TAREA: Crea un programa en Swift Playground que pida N alumnos con nombre y 3 notas,
las guarde en un diccionario [String: [Double]], calcule el promedio de cada alumno,
lo clasifique con switch (Excelente/Bueno/Aprobado/Desaprobado), muestre estadísticas
generales (promedio general, nota más alta/baja, % de aprobados) y ordene el ranking
por promedio de mayor a menor.

RESTRICCIONES: Solo usar contenido de semanas 1-3 (arrays, diccionarios, sets, for,
while, switch, if let). NO usar struct, class, ni funciones si no son necesarias.
Usar readLine() para leer datos del usuario.

FORMATO: Código Swift con un comentario explicando CADA línea.

EJEMPLO: Basado en el ejemplo resuelto de "Directorio de contactos" del laboratorio.

## Ejercicio 7 — Inventario con menú

### Prompt (CTRFE):
CONTEXTO: Mismo nivel que el ejercicio anterior, semana 3 de Swift.

TAREA: Crea un sistema de inventario con menú interactivo usando while, que permita:
1) ver inventario, 2) buscar producto, 3) ver stock bajo (<5), 4) ver valor total,
5) salir. Los datos se guardan en diccionarios paralelos [String: Double] para precios
y [String: Int] para stock.

RESTRICCIONES: Solo contenido de semanas 1-3, sin struct/class. Usar switch para el
menú y while para el bucle principal.

FORMATO: Código Swift comentado línea por línea.
