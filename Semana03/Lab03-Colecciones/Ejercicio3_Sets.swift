// Desarrollado por: Steven Saldaña Melendez
import Foundation

var numeros: [Int] = []
for i in 1...8 {
    print("Número \(i):")
    let n = Int(readLine() ?? "") ?? 0
    numeros.append(n)
}
print("Con duplicados: \(numeros)")
let sinDuplicados = Array(Set(numeros)).sorted()
print("Sin duplicados: \(sinDuplicados)")

var lunes: Set<String> = []
var martes: Set<String> = []
print("===== ASISTENCIA LUNES =====")
for i in 1...4 {
    print("Alumno \(i):")
    lunes.insert(readLine() ?? "")
}
print("===== ASISTENCIA MARTES =====")
for i in 1...4 {
    print("Alumno \(i):")
    martes.insert(readLine() ?? "")
}
print("Ambos días: \(lunes.intersection(martes))")
print("Solo lunes: \(lunes.subtracting(martes))")
print("Solo martes: \(martes.subtracting(lunes))")

// ===== PREDICT =====
let a: Set = [1, 2, 3, 4, 5]
let b: Set = [4, 5, 6, 7, 8]
print(a.intersection(b)) // [4, 5]
print(a.union(b).count)  // 8
print(a.subtracting(b))  // [1, 2, 3]

let repetidos: Set = ["A", "B", "A", "C", "B"]
print(repetidos.count) // 3
