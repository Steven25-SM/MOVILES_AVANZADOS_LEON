// ===== CASO 2 — PARTE B: BIBLIOTECA (CON IA) =====
// Desarrollado por: [Steven Saldaña Melendez]
// Docente: Juan León

enum EstadoLibro { // Define los dos posibles estados de un libro
    case disponible, prestado // disponible: se puede prestar / prestado: ya está afuera
}

struct Libro { // Modelo de un libro individual (tipo valor, se copia al pasarlo)
    let titulo: String // Título del libro, no cambia
    let autor: String // Autor del libro, no cambia
    var estado: EstadoLibro = .disponible // Empieza siempre disponible
}

class Biblioteca { // La biblioteca es una clase porque debe ser UNA sola instancia compartida
    var libros: [Libro] = [] // Arreglo que guarda todos los libros registrados

    func agregar(libro: Libro) { // Añade un nuevo libro al arreglo
        libros.append(libro) // Lo agrega al final de la lista
    }

    func prestar(titulo: String) -> Bool { // Intenta prestar un libro por su título
        for i in 0..<libros.count { // Recorre el arreglo por índice (no por copia)
            if libros[i].titulo == titulo { // Compara el título de cada libro
                if libros[i].estado == .disponible { // Si está disponible
                    libros[i].estado = .prestado // Modifica el struct DENTRO del array (una copia no serviría)
                    print("Préstamo aprobado: \(titulo)") // Confirma el préstamo
                    return true // Indica que la operación fue exitosa
                } else { // Si ya estaba prestado
                    print("Error: \(titulo) ya está prestado") // Muestra el error
                    return false // Indica que falló
                }
            }
        }
        print("Error: no existe \(titulo)") // Si terminó el for sin encontrarlo
        return false // Indica que no se pudo prestar
    }

    func devolver(titulo: String) -> Bool { // Intenta devolver un libro por su título
        for i in 0..<libros.count { // Recorre el arreglo por índice
            if libros[i].titulo == titulo { // Encuentra el libro por título
                if libros[i].estado == .prestado { // Solo se puede devolver si estaba prestado
                    libros[i].estado = .disponible // Lo marca de nuevo como disponible
                    print("Devolución registrada: \(titulo)") // Confirma la devolución
                    return true // Operación exitosa
                } else { // Si ya estaba disponible
                    print("Error: \(titulo) no estaba prestado") // Muestra el error
                    return false // Indica que falló
                }
            }
        }
        print("Error: no existe \(titulo)") // Si no se encontró el libro
        return false // Indica que no se pudo devolver
    }

    func inventario() { // Muestra el estado de todos los libros
        print("===== INVENTARIO =====") // Encabezado del reporte
        for libro in libros { // Recorre todos los libros
            switch libro.estado { // Evalúa el estado de cada libro
            case .disponible: // Si está disponible
                print("\(libro.titulo) (\(libro.autor)) - disponible") // Lo muestra como disponible
            case .prestado: // Si está prestado
                print("\(libro.titulo) (\(libro.autor)) - prestado") // Lo muestra como prestado
            }
        }
    }
}

// ===== SIMULACIÓN ===== // Sección de prueba del sistema completo
let biblioteca = Biblioteca() // Crea la instancia única de la biblioteca

biblioteca.agregar(libro: Libro(titulo: "Cien años de soledad", autor: "Gabriel García Márquez")) // Agrega el primer libro
biblioteca.agregar(libro: Libro(titulo: "La ciudad y los perros", autor: "Mario Vargas Llosa")) // Agrega el segundo libro
biblioteca.agregar(libro: Libro(titulo: "El Quijote", autor: "Miguel de Cervantes")) // Agrega el tercer libro

biblioteca.prestar(titulo: "La ciudad y los perros") // Primer préstamo, debe funcionar
biblioteca.prestar(titulo: "La ciudad y los perros") // Segundo intento, debe fallar (ya prestado)
biblioteca.devolver(titulo: "La ciudad y los perros") // Devuelve el libro
biblioteca.prestar(titulo: "El Quijote") // Presta otro libro distinto
biblioteca.prestar(titulo: "El Principito") // Intenta prestar uno que no existe

biblioteca.inventario() // Muestra el estado final de todos los libros
	
