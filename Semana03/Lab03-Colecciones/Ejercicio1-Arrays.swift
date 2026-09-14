// Desarrollado por: [Steven Saldaña Melendez]
import Foundation

var alumnos: [String] = []
for i in 1...5 {
    print("Nombre del alumno \(i):")
    let nombre = readLine() ?? ""
    alumnos.append(nombre)
}
print("Alumnos: \(alumnos)")

print("Buscar alumno:")
let buscar = readLine() ?? ""
if alumnos.contains(buscar) {
    print("\(buscar) está en la lista")
} else {
    print("\(buscar) NO está en la lista")
}

var notasClase: [Double] = []
for i in 1...5 {
    print("Nota del alumno \(i):")
    let nota = Double(readLine() ?? "") ?? 0
    notasClase.append(nota)
}
var aprobados = 0
var desaprobados = 0
var sumaNotas = 0.0
for nota in notasClase {
    sumaNotas += nota
    if nota >= 13 { aprobados += 1 } else { desaprobados += 1 }
}
print("Promedio: \(sumaNotas / Double(notasClase.count))")
print("Aprobados: \(aprobados), Desaprobados: \(desaprobados)")

// ===== FIX =====
var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Kiwi") // FIX 1: era Int, ahora String

var colores = ["Rojo", "Azul", "Verde"] // FIX 2: era 'let', ahora 'var'
colores.append("Amarillo")

let numeros = [10, 20, 30, 40, 50]
print(numeros[4]) // FIX 3: índice válido (0 a 4)

// ===== PREDICT =====
var lista = [1, 2, 3, 4, 5]
lista.remove(at: 0)
lista.append(6)
print(lista)       // [2, 3, 4, 5, 6]
print(lista.count) // 5

var nombres = ["Ana", "Carlos", "Beto"]
print(nombres.sorted()) // ["Ana", "Beto", "Carlos"]
print(nombres)          // ["Ana", "Carlos", "Beto"]
