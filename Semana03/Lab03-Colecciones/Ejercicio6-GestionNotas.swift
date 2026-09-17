// Desarrollado por: [Steven Saldaña Melendez]
import Foundation // Importa Foundation

print("¿Cuántos alumnos desea registrar?") // Pide la cantidad
let cantidad = Int(readLine() ?? "") ?? 0 // Convierte a Int

var alumnos: [String: [Double]] = [:] // Diccionario nombre -> 3 notas

if cantidad > 0 { // Evita crash si ingresan 0
    for i in 1...cantidad { // Repite por cada alumno
        print("\nNombre del alumno \(i):") // Pide nombre
        let nombre = readLine() ?? "" // Lee nombre
        var notas: [Double] = [] // Array temporal de notas
        for j in 1...3 { // Pide 3 notas
            print("Nota \(j):") // Pide nota j
            let nota = Double(readLine() ?? "") ?? 0 // Convierte a Double
            notas.append(nota) // Agrega la nota
        }
        alumnos[nombre] = notas // Guarda las notas del alumno
    }
}

print("\n===== REPORTE DE NOTAS =====") // Encabezado

var sumaGeneral = 0.0 // Acumulador de todas las notas
var cantidadNotas = 0 // Contador de notas totales
var aprobadosCount = 0 // Contador de aprobados
var notaMayor = -Double.infinity // Nota más alta encontrada
var notaMenor = Double.infinity // Nota más baja encontrada
var resultados: [(nombre: String, promedio: Double)] = [] // Para el ranking

for (nombre, notas) in alumnos { // Recorre cada alumno
    let suma = notas.reduce(0, +) // Suma sus notas
    let promedio = suma / Double(notas.count) // Calcula promedio
    let clasificacion: String // Variable de clasificación
    switch promedio { // Clasifica según rango
    case 18...20: clasificacion = "Excelente"
    case 15..<18: clasificacion = "Bueno"
    case 13..<15: clasificacion = "Aprobado"
    default: clasificacion = "Desaprobado"
    }
    print("\(nombre): notas=\(notas), promedio=\(String(format: "%.2f", promedio)) → \(clasificacion)") // Muestra reporte
    sumaGeneral += suma // Acumula para el general
    cantidadNotas += notas.count // Cuenta las notas
    if promedio >= 13 { aprobadosCount += 1 } // Cuenta aprobados
    if let maxNota = notas.max(), maxNota > notaMayor { notaMayor = maxNota } // Actualiza la más alta
    if let minNota = notas.min(), minNota < notaMenor { notaMenor = minNota } // Actualiza la más baja
    resultados.append((nombre, promedio)) // Guarda para ordenar después
}

if !alumnos.isEmpty { // Solo si hay alumnos registrados
    let promedioGeneral = sumaGeneral / Double(cantidadNotas) // Promedio general
    let porcentajeAprobados = Double(aprobadosCount) / Double(alumnos.count) * 100 // % aprobados
    print("\n===== ESTADÍSTICAS =====") // Encabezado
    print("Promedio general: \(String(format: "%.2f", promedioGeneral))") // Muestra promedio general
    print("Nota más alta: \(notaMayor)") // Muestra la más alta
    print("Nota más baja: \(notaMenor)") // Muestra la más baja
    print("Porcentaje de aprobados: \(String(format: "%.2f", porcentajeAprobados))%") // Muestra el %

    resultados.sort { $0.promedio > $1.promedio } // Ordena de mayor a menor
    print("\n===== RANKING POR PROMEDIO =====") // Encabezado
    for (posicion, resultado) in resultados.enumerated() { // Recorre ya ordenado
        print("\(posicion + 1). \(resultado.nombre) - \(String(format: "%.2f", resultado.promedio))") // Muestra ranking
    }
}
