// Desarrollado por: [Steven Saldaña Melendez]
import Foundation

let lineaUno = ["Villa El Salvador","Parque Industrial","Pumacahua","Villa María",
                "María Auxiliadora","San Juan","Atocongo","Jorge Chávez","Ayacucho",
                "Cabitos","Angamos","San Borja Sur","La Cultura","Arriola","Gamarra",
                "Miguel Grau","El Ángel","Presbítero Maestro","Caja de Agua",
                "Pirámide del Sol","Los Jardines","Los Postes","San Carlos",
                "San Martín","Santa Rosa","Bayóvar"]

let lineaDos = ["Evitamiento","Óvalo Santa Anita","Colectora Industrial",
                "Hermilio Valdizán","Mercado Santa Anita"]

let tarifas: [String: (adulto: Double, medio: Double)] = [
    "Línea 1": (adulto: 1.50, medio: 0.75),
    "Línea 2": (adulto: 1.40, medio: 0.70)
]

var lineaDeEstacion: [String: String] = [:]
var conexiones: [String: [String]] = [:]
var accesibilidad: [String: (ascensor: Bool, rampa: Bool)] = [:]

func construirLinea(_ estaciones: [String], nombreLinea: String) {
    for i in 0..<estaciones.count {
        let estacion = estaciones[i]
        lineaDeEstacion[estacion] = nombreLinea
        var vecinos: [String] = []
        if i > 0 { vecinos.append(estaciones[i - 1]) }
        if i < estaciones.count - 1 { vecinos.append(estaciones[i + 1]) }
        conexiones[estacion] = vecinos
        accesibilidad[estacion] = (ascensor: true, rampa: true)
    }
}

construirLinea(lineaUno, nombreLinea: "Línea 1")
construirLinea(lineaDos, nombreLinea: "Línea 2")

func buscarEstacion(_ nombre: String) {
    guard let linea = lineaDeEstacion[nombre] else {
        print("Estación no encontrada")
        return
    }
    let vecinos = conexiones[nombre] ?? []
    let acc = accesibilidad[nombre] ?? (ascensor: false, rampa: false)
    let tarifa = tarifas[linea]!

    print("\n===== \(nombre) =====")
    print("Línea: \(linea)")
    print("Conecta directamente con: \(vecinos)")
    print("Ascensor: \(acc.ascensor ? "Sí" : "No") | Rampa eléctrica: \(acc.rampa ? "Sí" : "No")")
    print("Pasaje adulto: S/. \(tarifa.adulto) | Medio pasaje: S/. \(tarifa.medio)")
}

func mostrarLinea(_ nombreLinea: String) {
    let estacionesLinea = nombreLinea == "Línea 1" ? lineaUno : lineaDos
    print("\n===== ESTACIONES DE \(nombreLinea) =====")
    for (i, estacion) in estacionesLinea.enumerated() {
        print("\(i + 1). \(estacion)")
    }
}

func buscarRuta(desde origen: String, hasta destino: String) {
    guard lineaDeEstacion[origen] != nil, lineaDeEstacion[destino] != nil else {
        print("Una de las estaciones no existe")
        return
    }
    if origen == destino {
        print("Ya estás en \(origen)")
        return
    }

    var visitados: Set<String> = [origen]
    var cola: [[String]] = [[origen]]

    while !cola.isEmpty {
        let rutaActual = cola.removeFirst()
        let estacionActual = rutaActual.last!

        for vecino in conexiones[estacionActual] ?? [] {
            if vecino == destino {
                let rutaCompleta = rutaActual + [vecino]
                let paradas = rutaCompleta.count - 1
                let linea = lineaDeEstacion[origen]!
                let tarifa = tarifas[linea]!

                print("\n===== RUTA ENCONTRADA =====")
                print(rutaCompleta.joined(separator: " → "))
                print("Paradas: \(paradas)")
                print("Tiempo estimado: \(paradas * 2) min (aprox. 2 min entre estaciones)")
                print("Pasaje adulto: S/. \(tarifa.adulto) | Medio pasaje: S/. \(tarifa.medio)")
                return
            }
            if !visitados.contains(vecino) {
                visitados.insert(vecino)
                cola.append(rutaActual + [vecino])
            }
        }
    }
    print("No se encontró ruta entre \(origen) y \(destino) (no hay transbordo entre líneas todavía)")
}

var continuar = true
while continuar {
    print("\n===== SISTEMA DE CONSULTAS - METRO DE LIMA =====")
    print("1) Buscar estación")
    print("2) Ver estaciones de una línea")
    print("3) Buscar ruta entre dos estaciones")
    print("4) Ver tarifas por línea")
    print("5) Salir")
    print("Seleccione una opción:")
    let opcion = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

    switch opcion {
    case "1":
        print("Nombre de la estación:")
        let estacion = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        buscarEstacion(estacion)

    case "2":
        print("¿Qué línea? (Línea 1 / Línea 2)")
        let linea = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        mostrarLinea(linea)

    case "3":
        print("Estación de origen:")
        let origen = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        print("Estación de destino:")
        let destino = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        buscarRuta(desde: origen, hasta: destino)

    case "4":
        print("\n===== TARIFAS =====")
        for (linea, tarifa) in tarifas {
            print("\(linea): Adulto S/. \(tarifa.adulto) | Medio pasaje S/. \(tarifa.medio)")
        }

    case "5":
        print("Saliendo...")
        continuar = false

    default:
        print("Opción no válida")
    }
}
