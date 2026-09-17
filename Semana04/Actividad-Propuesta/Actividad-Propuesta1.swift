// ===== ACTIVIDAD PROPUESTA 01: FACTURA DE CURSOS LIBRES TECSUP =====
// Desarrollado por: [Steven Saldaña Melendez]
import Foundation

struct CursoComprado {
    let nombre: String
    let precioUnitario: Double
    let cantidad: Int
    var total: Double { precioUnitario * Double(cantidad) }
}

print("Nombre del estudiante:")
let nombre = readLine() ?? ""
print("DNI:")
let dni = readLine() ?? ""
print("¿Es alumno de Tecsup? (si/no):")
let esAlumnoTecsup = (readLine() ?? "").lowercased().hasPrefix("s")

print("¿Cuántos cursos diferentes va a inscribir?")
let cantidadCursos = Int(readLine() ?? "") ?? 0

var cursos: [CursoComprado] = []
if cantidadCursos > 0 {
    for i in 1...cantidadCursos {
        print("\nCurso \(i) - Nombre:")
        let nombreCurso = readLine() ?? ""
        print("Precio unitario:")
        let precio = Double(readLine() ?? "") ?? 0
        print("Cantidad:")
        let cantidad = Int(readLine() ?? "") ?? 0
        cursos.append(CursoComprado(nombre: nombreCurso, precioUnitario: precio, cantidad: cantidad))
    }
}

var subtotal = 0.0
for curso in cursos { subtotal += curso.total }
let igv = subtotal * 0.18
let totalConIGV = subtotal + igv

var descuentoCantidad = 0.0
var descuentoTecsup = 0.0
if cursos.count >= 3 {
    descuentoCantidad = totalConIGV * 0.10
}
if esAlumnoTecsup && cursos.count >= 3 {
    descuentoTecsup = 400.0
}
let totalFinal = totalConIGV - descuentoCantidad - descuentoTecsup

let sep = String(repeating: "-", count: 30)
print("\n📚 FACTURA DE CURSOS")
print("Estudiante: \(nombre)")
print("DNI: \(dni)")
print("Alumno de Tecsup: \(esAlumnoTecsup ? "Sí ✅" : "No")")
print(sep)
for curso in cursos {
    print("\(curso.nombre) x\(curso.cantidad) - S/ \(curso.total)")
}
print(sep)
print("Subtotal: S/ \(subtotal)")
print("IGV (18%): S/ \(igv)")
print("Total con IGV: S/ \(totalConIGV)")
if descuentoCantidad > 0 { print("Descuento 10% por cantidad: -S/ \(descuentoCantidad) ✅") }
if descuentoTecsup > 0 { print("Descuento especial Tecsup: -S/ \(descuentoTecsup) ✅") }
print(sep)
print("💰 TOTAL FINAL A PAGAR: S/ \(totalFinal)")
