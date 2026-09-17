// ===== CASO 2 — PARTE A: BIBLIOTECA (SIN IA) =====
// Desarrollado por: [Steven Saldaña Melendez]
// Docente: Juan León

enum EstadoLibro {
    case disponible, prestado
}

struct Libro {
    let titulo: String
    let autor: String
    var estado: EstadoLibro = .disponible
}

class Biblioteca {
    var libros: [Libro] = []

    func agregar(libro: Libro) {
        libros.append(libro)
    }

    @discardableResult
    func prestar(titulo: String) -> Bool {
        for i in 0..<libros.count {
            if libros[i].titulo == titulo {
                if libros[i].estado == .disponible {
                    libros[i].estado = .prestado
                    print("Préstamo aprobado: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) ya está prestado")
                    return false
                }
            }
        }
        print("Error: no existe \(titulo)")
        return false
    }

    @discardableResult
    func devolver(titulo: String) -> Bool {
        for i in 0..<libros.count {
            if libros[i].titulo == titulo {
                if libros[i].estado == .prestado {
                    libros[i].estado = .disponible
                    print("Devolución registrada: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) no estaba prestado")
                    return false
                }
            }
        }
        print("Error: no existe \(titulo)")
        return false
    }

    func inventario() {
        print("===== INVENTARIO =====")
        for libro in libros {
            switch libro.estado {
            case .disponible:
                print("\(libro.titulo) (\(libro.autor)) - disponible")
            case .prestado:
                print("\(libro.titulo) (\(libro.autor)) - prestado")
            }
        }
    }
}

// ===== SIMULACIÓN =====
let biblioteca = Biblioteca()
biblioteca.agregar(libro: Libro(titulo: "Cien años de soledad", autor: "Gabriel García Márquez"))
biblioteca.agregar(libro: Libro(titulo: "La ciudad y los perros", autor: "Mario Vargas Llosa"))
biblioteca.agregar(libro: Libro(titulo: "El Quijote", autor: "Miguel de Cervantes"))

biblioteca.prestar(titulo: "La ciudad y los perros")
biblioteca.prestar(titulo: "La ciudad y los perros")
biblioteca.devolver(titulo: "La ciudad y los perros")
biblioteca.prestar(titulo: "El Quijote")
biblioteca.prestar(titulo: "El Principito")

biblioteca.inventario()
