// Desarrollado por: [Steven Saldaña Melendez]
import Foundation

print("¿Cuántos alumnos desea registrar?")
let cantidad = Int(readLine() ?? "") ?? 0

var alumnos: [String: [Double]] = [:]

if cantidad > 0 {
    for i in 1...cantidad {
        print("\nNombre del alumno \(i):")
        let nombre = readLine() ?? ""
        var notas: [Double] = []
        for j in 1...3 {
            print("Nota \(j):")
            let nota = Double(readLine() ?? "") ?? 0
            notas.append(nota)
        }
        alumnos[nombre] = notas
    }
}

print("\n===== REPORTE DE NOTAS =====")

var sumaGeneral = 0.0
var cantidadNotas = 0
var aprobadosCount = 0
var notaMayor = -Double.infinity
var notaMenor = Double.infinity
var resultados: [(nombre: String, promedio: Double)] = []

for (nombre, notas) in alumnos {
    let suma = notas.reduce(0, +)
    let promedio = suma / Double(notas.count)
    let clasificacion: String
    switch promedio {
    case 18...20: clasificacion = "Excelente"
    case 15..<18: clasificacion = "Bueno"
    case 13..<15: clasificacion = "Aprobado"
    default: clasificacion = "Desaprobado"
    }
    print("\(nombre): notas=\(notas), promedio=\(String(format: "%.2f", promedio)) → \(clasificacion)")
    sumaGeneral += suma
    cantidadNotas += notas.count
    if promedio >= 13 { aprobadosCount += 1 }
    if let maxNota = notas.max(), maxNota > notaMayor { notaMayor = maxNota }
    if let minNota = notas.min(), minNota < notaMenor { notaMenor = minNota }
    resultados.append((nombre, promedio))
}

if !alumnos.isEmpty {
    let promedioGeneral = sumaGeneral / Double(cantidadNotas)
    let porcentajeAprobados = Double(aprobadosCount) / Double(alumnos.count) * 100
    print("\n===== ESTADÍSTICAS =====")
    print("Promedio general: \(String(format: "%.2f", promedioGeneral))")
    print("Nota más alta: \(notaMayor)")
    print("Nota más baja: \(notaMenor)")
    print("Porcentaje de aprobados: \(String(format: "%.2f", porcentajeAprobados))%")

    resultados.sort { $0.promedio > $1.promedio }
    print("\n===== RANKING POR PROMEDIO =====")
    for (posicion, resultado) in resultados.enumerated() {
        print("\(posicion + 1). \(resultado.nombre) - \(String(format: "%.2f", resultado.promedio))")
    }
}
		
