// Desarrollado por: [Steven Saldaña Melendez]
import Foundation

var lineaUno = ["Villa El Salvador", "Parque Industrial", "Pumacahua", "Villa María",
                "María Auxiliadora", "San Juan", "Atocongo", "Jorge Chávez", "Ayacucho",
                "Cabitos", "Angamos", "San Borja Sur", "La Cultura", "Arriola", "Gamarra",
                "Miguel Grau", "El Ángel", "Presbítero Maestro", "Caja de Agua",
                "Pirámide del Sol", "Los Jardines", "Los Postes", "San Carlos",
                "San Martín", "Santa Rosa", "Bayóvar"]

var lineaDos = ["Evitamiento", "Óvalo Santa Anita", "Colectora Industrial",
                "Hermilio Valdizán", "Mercado Santa Anita"]

var tarifas: [String: (adulto: Double, medio: Double)] = [
    "Línea 1": (adulto: 1.50, medio: 0.75),
    "Línea 2": (adulto: 1.40, medio: 0.70)
]

var lineaDeEstacion: [String: String] = [:]
var conexiones: [String: [String]] = [:]
var accesibilidad: [String: (ascensor: Bool, rampa: Bool)] = [:]
var nuevasLineas: [String: [String]] = [:]

func normalizarTexto(_ texto: String) -> String {

    return texto
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .folding(
            options: [.caseInsensitive, .diacriticInsensitive],
            locale: nil
        )
}


// Busca una estación y devuelve su nombre real,
// tal como está registrado en el sistema.
func encontrarEstacion(_ nombre: String) -> String? {

    let nombreNormalizado = normalizarTexto(nombre)

    return lineaDeEstacion.keys.first {
        normalizarTexto($0) == nombreNormalizado
    }
}


// Busca la posición de una estación dentro de una línea,
// ignorando mayúsculas, minúsculas y tildes.
func indiceEstacion(
    _ nombre: String,
    en estaciones: [String]
) -> Int? {

    let nombreNormalizado = normalizarTexto(nombre)

    return estaciones.firstIndex {
        normalizarTexto($0) == nombreNormalizado
    }
}


// ============================================================
// CONSTRUIR LÍNEAS
// ============================================================

func construirLinea(_ estaciones: [String], nombreLinea: String) {

    for i in 0..<estaciones.count {

        let estacion = estaciones[i]

        lineaDeEstacion[estacion] = nombreLinea

        var vecinos: [String] = []

        if i > 0 {
            vecinos.append(estaciones[i - 1])
        }

        if i < estaciones.count - 1 {
            vecinos.append(estaciones[i + 1])
        }

        conexiones[estacion] = vecinos

        accesibilidad[estacion] = (
            ascensor: true,
            rampa: true
        )
    }
}


construirLinea(lineaUno, nombreLinea: "Línea 1")
construirLinea(lineaDos, nombreLinea: "Línea 2")


// ============================================================
// 1. BUSCAR ESTACIÓN
// ============================================================

func buscarEstacion(_ nombre: String) {

    guard let estacionEncontrada = encontrarEstacion(nombre) else {

        print("Estación no encontrada.")
        return
    }

    guard let linea = lineaDeEstacion[estacionEncontrada] else {

        print("Estación no encontrada.")
        return
    }

    let vecinos = conexiones[estacionEncontrada] ?? []

    let acc = accesibilidad[estacionEncontrada] ?? (
        ascensor: false,
        rampa: false
    )

    guard let tarifa = tarifas[linea] else {

        print("No hay tarifa registrada para esta línea.")
        return
    }

    print("\n===== \(estacionEncontrada) =====")
    print("Línea: \(linea)")
    print("Conecta directamente con: \(vecinos)")
    print("Ascensor: \(acc.ascensor ? "Sí" : "No")")
    print("Rampa eléctrica: \(acc.rampa ? "Sí" : "No")")
    print("Pasaje adulto: S/. \(tarifa.adulto)")
    print("Medio pasaje: S/. \(tarifa.medio)")

    if let referencias = referenciasEstaciones[estacionEncontrada] {

        print("\n===== REFERENCIAS CERCANAS =====")

        for referencia in referencias {
            print("- \(referencia)")
        }

    } else {

        print("\nNo hay referencias registradas para esta estación.")
    }
}


// ============================================================
// 2. MOSTRAR LÍNEA
// ============================================================

func mostrarLinea(_ opcion: String) {

    switch opcion {

    case "1":

        print("\n===== ESTACIONES DE LÍNEA 1 =====")

        for (i, estacion) in lineaUno.enumerated() {
            print("\(i + 1). \(estacion)")
        }

    case "2":

        print("\n===== ESTACIONES DE LÍNEA 2 =====")

        for (i, estacion) in lineaDos.enumerated() {
            print("\(i + 1). \(estacion)")
        }

    default:

        print("Línea no válida.")
    }
}


// ============================================================
// 3. BUSCAR RUTA
// ============================================================

func buscarRuta(desde origen: String, hasta destino: String) {

    // Buscamos los nombres reales de las estaciones.
    // Esto permite escribirlas con o sin tildes.
    guard let origenReal = encontrarEstacion(origen),
          let destinoReal = encontrarEstacion(destino) else {

        print("Una de las estaciones no existe.")
        return
    }

    if origenReal == destinoReal {

        print("Ya estás en \(origenReal).")
        return
    }

    var visitados: Set<String> = [origenReal]
    var cola: [[String]] = [[origenReal]]

    while !cola.isEmpty {

        let rutaActual = cola.removeFirst()
        let estacionActual = rutaActual.last!

        for vecino in conexiones[estacionActual] ?? [] {

            if vecino == destinoReal {

                let rutaCompleta = rutaActual + [vecino]
                let paradas = rutaCompleta.count - 1

                let linea = lineaDeEstacion[origenReal]!

                print("\n===== RUTA ENCONTRADA =====")
                print(rutaCompleta.joined(separator: " → "))
                print("Paradas: \(paradas)")
                print("Tiempo estimado: \(paradas * 2) min")

                if let tarifa = tarifas[linea] {

                    print("Pasaje adulto: S/. \(tarifa.adulto)")
                    print("Medio pasaje: S/. \(tarifa.medio)")
                }

                return
            }

            if !visitados.contains(vecino) {

                visitados.insert(vecino)
                cola.append(rutaActual + [vecino])
            }
        }
    }

    print("No se encontró ruta entre \(origenReal) y \(destinoReal).")
}


// ============================================================
// 4. PLANIFICACIÓN DEL VIAJE
// ============================================================

func obtenerEstacionesDeLinea(_ nombreLinea: String) -> [String]? {

    if nombreLinea == "Línea 1" {
        return lineaUno
    }

    if nombreLinea == "Línea 2" {
        return lineaDos
    }

    return nuevasLineas[nombreLinea]
}


func planificarViaje(desde origen: String, hasta destino: String) {

    // Obtenemos los nombres reales registrados.
    guard let origenReal = encontrarEstacion(origen),
          let destinoReal = encontrarEstacion(destino) else {

        print("Una de las estaciones no existe.")
        return
    }

    guard let lineaOrigen = lineaDeEstacion[origenReal],
          let lineaDestino = lineaDeEstacion[destinoReal] else {

        print("No se pudo identificar la línea de una de las estaciones.")
        return
    }

    if origenReal == destinoReal {

        print("Ya estás en \(origenReal).")
        return
    }

    if lineaOrigen == lineaDestino {

        guard let estaciones = obtenerEstacionesDeLinea(lineaOrigen),
              let posicionOrigen = indiceEstacion(
                origenReal,
                en: estaciones
              ),
              let posicionDestino = indiceEstacion(
                destinoReal,
                en: estaciones
              ) else {

            print("No se pudo calcular la planificación.")
            return
        }

        let estacionesFaltantes = abs(
            posicionDestino - posicionOrigen
        )

        print("\n===== PLANIFICACIÓN DEL VIAJE =====")
        print("Origen: \(origenReal)")
        print("Destino: \(destinoReal)")
        print("Línea: \(lineaOrigen)")
        print("Estaciones que faltan: \(estacionesFaltantes)")
        print("Tiempo aproximado: \(estacionesFaltantes * 2) minutos")

    } else {

        let estacionesOrigen =
            obtenerEstacionesDeLinea(lineaOrigen) ?? []

        let estacionesDestino =
            obtenerEstacionesDeLinea(lineaDestino) ?? []

        let estacionesComunes = estacionesOrigen.filter {
            estacionesDestino.contains($0)
        }

        print("\n===== PLANIFICACIÓN DEL VIAJE =====")
        print("Origen: \(origenReal)")
        print("Destino: \(destinoReal)")
        print("Línea de origen: \(lineaOrigen)")
        print("Línea de destino: \(lineaDestino)")

        if estacionesComunes.isEmpty {

            print(
                "No existen estaciones de interconexión " +
                "registradas entre ambas líneas."
            )

        } else {

            print("Estaciones de interconexión:")

            for estacion in estacionesComunes {
                print("- \(estacion)")
            }
        }
    }
}


// ============================================================
// 5. TARJETA DE TRANSPORTE
// ============================================================

var saldoTarjeta: Double = 10.00


func consultarSaldo() {

    print("\n===== SALDO DE TARJETA =====")

    print(
        String(
            format: "Saldo actual: S/. %.2f",
            saldoTarjeta
        )
    )
}


func recargarTarjeta(_ monto: Double) {

    if monto <= 0 {

        print("El monto de recarga debe ser mayor que 0.")
        return
    }

    saldoTarjeta += monto

    print("\n===== RECARGA REALIZADA =====")

    print(
        String(
            format: "Monto recargado: S/. %.2f",
            monto
        )
    )

    print(
        String(
            format: "Nuevo saldo: S/. %.2f",
            saldoTarjeta
        )
    )
}


func pagarPasaje(linea: String, tipoPasajero: String) {

    // También normalizamos el nombre de la línea.
    let lineaNormalizada = normalizarTexto(linea)

    guard let lineaReal = tarifas.keys.first(where: {
        normalizarTexto($0) == lineaNormalizada
    }) else {

        print("La línea no tiene una tarifa registrada.")
        return
    }

    guard let tarifa = tarifas[lineaReal] else {

        print("La línea no tiene una tarifa registrada.")
        return
    }

    let tipoNormalizado = normalizarTexto(tipoPasajero)

    let precio: Double

    switch tipoNormalizado {

    case "adulto":

        precio = tarifa.adulto

    case "medio":

        precio = tarifa.medio

    default:

        print("Tipo de pasajero no válido.")
        print("Use: adulto o medio.")
        return
    }

    if saldoTarjeta < precio {

        print("\nSaldo insuficiente.")

        print(
            String(
                format: "Saldo actual: S/. %.2f",
                saldoTarjeta
            )
        )

        print(
            String(
                format: "Costo del pasaje: S/. %.2f",
                precio
            )
        )

        return
    }

    saldoTarjeta -= precio

    print("\n===== PAGO REALIZADO =====")
    print("Línea: \(lineaReal)")
    print("Tipo de pasajero: \(tipoPasajero)")

    print(
        String(
            format: "Pasaje cobrado: S/. %.2f",
            precio
        )
    )

    print(
        String(
            format: "Saldo restante: S/. %.2f",
            saldoTarjeta
        )
    )
}


// ============================================================
// 6. REFERENCIAS CERCANAS
// ============================================================

var referenciasEstaciones: [String: [String]] = [

    "Villa El Salvador": [
        "Cerca al Parque Zonal Huáscar",
        "Cerca a la Municipalidad de Villa El Salvador"
    ],

    "Parque Industrial": [
        "Cerca a la zona industrial de Villa El Salvador",
        "Cerca a la Av. El Sol"
    ],

    "Pumacahua": [
        "Cerca a la Av. Pachacútec",
        "Cerca a la zona comercial de Villa María"
    ],

    "Villa María": [
        "Cerca a la Plaza de Villa María",
        "Cerca al Mercado de Villa María"
    ],

    "María Auxiliadora": [
        "Cerca al Hospital María Auxiliadora",
        "Cerca a la Av. Miguel Iglesias"
    ],

    "San Juan": [
        "Cerca a la Municipalidad de San Juan de Miraflores",
        "Cerca a la zona comercial de San Juan"
    ],

    "Atocongo": [
        "Cerca al Mall del Sur",
        "Cerca al Puente Atocongo"
    ],

    "Jorge Chávez": [
        "Cerca a la Av. Jorge Chávez",
        "Cerca a la zona residencial de Surco"
    ],

    "Ayacucho": [
        "Cerca a la Av. Ayacucho",
        "Cerca a la zona comercial de Surco"
    ],

    "Cabitos": [
        "Cerca al Óvalo Higuereta",
        "Cerca a la Av. Aviación"
    ],

    "Angamos": [
        "Cerca a la Av. Angamos",
        "Cerca al cruce de Angamos con Aviación"
    ],

    "San Borja Sur": [
        "Cerca a la Av. San Borja Sur",
        "Cerca al distrito de San Borja"
    ],

    "La Cultura": [
        "Cerca al Gran Teatro Nacional",
        "Cerca a la Biblioteca Nacional del Perú"
    ],

    "Arriola": [
        "Cerca a la Av. Nicolás Arriola",
        "Cerca al Mercado de Frutas"
    ],

    "Gamarra": [
        "Cerca al Emporio Comercial de Gamarra",
        "Cerca a la Av. Aviación"
    ],

    "Miguel Grau": [
        "Cerca a la Av. Miguel Grau",
        "Cerca al Hospital Nacional Dos de Mayo"
    ],

    "El Ángel": [
        "Cerca al Cementerio El Ángel",
        "Cerca a la Av. Ancash"
    ],

    "Presbítero Maestro": [
        "Cerca al Cementerio Presbítero Maestro",
        "Cerca a la Av. Ancash"
    ],

    "Caja de Agua": [
        "Cerca a la Av. Próceres de la Independencia",
        "Cerca a la zona de Caja de Agua"
    ],

    "Pirámide del Sol": [
        "Cerca a la Av. Próceres de la Independencia",
        "Cerca a la zona de Zárate"
    ],

    "Los Jardines": [
        "Cerca a la Av. Los Jardines",
        "Cerca a la zona comercial de San Juan de Lurigancho"
    ],

    "Los Postes": [
        "Cerca a la Av. Los Postes",
        "Cerca a la zona comercial de San Juan de Lurigancho"
    ],

    "San Carlos": [
        "Cerca a la Universidad Nacional Mayor de San Marcos",
        "Cerca a la Av. Próceres de la Independencia"
    ],

    "San Martín": [
        "Cerca a la zona de San Martín de Porres",
        "Cerca a la Av. Próceres de la Independencia"
    ],

    "Santa Rosa": [
        "Cerca a la zona residencial de Santa Rosa",
        "Cerca a la Av. Próceres de la Independencia"
    ],

    "Bayóvar": [
        "Cerca a la Av. Fernando Wiesse",
        "Cerca a la zona comercial de San Juan de Lurigancho"
    ],

    "Evitamiento": [
        "Cerca a la Vía de Evitamiento",
        "Cerca al intercambio vial de Evitamiento"
    ],

    "Óvalo Santa Anita": [
        "Cerca al Óvalo Santa Anita",
        "Cerca al Mercado de Productores de Santa Anita"
    ],

    "Colectora Industrial": [
        "Cerca a la zona industrial de Santa Anita",
        "Cerca a la Av. Colectora Industrial"
    ],

    "Hermilio Valdizán": [
        "Cerca a la Av. Hermilio Valdizán",
        "Cerca a la zona comercial de Santa Anita"
    ],

    "Mercado Santa Anita": [
        "Cerca al Mercado Mayorista de Lima",
        "Cerca a la Av. La Cultura"
    ]
]


// ============================================================
// 7. FUNCIONES DEL ADMINISTRADOR
// ============================================================

func construirConexionesLinea(
    _ estaciones: [String],
    nombreLinea: String
) {

    for i in 0..<estaciones.count {

        let estacion = estaciones[i]

        lineaDeEstacion[estacion] = nombreLinea

        var vecinos: [String] = []

        if i > 0 {
            vecinos.append(estaciones[i - 1])
        }

        if i < estaciones.count - 1 {
            vecinos.append(estaciones[i + 1])
        }

        conexiones[estacion] = vecinos

        if accesibilidad[estacion] == nil {

            accesibilidad[estacion] = (
                ascensor: true,
                rampa: true
            )
        }
    }
}


func agregarEstacionFinal(
    nombre: String,
    linea: String
) {

    let nombreLimpio = nombre.trimmingCharacters(
        in: .whitespacesAndNewlines
    )

    guard !nombreLimpio.isEmpty else {

        print("El nombre de la estación no puede estar vacío.")
        return
    }

    // Evita duplicados aunque se escriban sin tildes
    // o con diferentes mayúsculas.
    if encontrarEstacion(nombreLimpio) != nil {

        print("La estación ya existe.")
        return
    }

    switch linea {

    case "Línea 1":

        lineaUno.append(nombreLimpio)

        construirConexionesLinea(
            lineaUno,
            nombreLinea: "Línea 1"
        )

        print("Estación agregada correctamente a Línea 1.")

    case "Línea 2":

        lineaDos.append(nombreLimpio)

        construirConexionesLinea(
            lineaDos,
            nombreLinea: "Línea 2"
        )

        print("Estación agregada correctamente a Línea 2.")

    default:

        guard nuevasLineas[linea] != nil else {

            print("Línea no válida.")
            return
        }

        nuevasLineas[linea]!.append(nombreLimpio)

        construirConexionesLinea(
            nuevasLineas[linea]!,
            nombreLinea: linea
        )

        print(
            "Estación agregada correctamente a \(linea)."
        )
    }
}


func insertarEstacion(
    nombre: String,
    entre estacionA: String,
    y estacionB: String,
    linea: String
) {

    let nombreLimpio = nombre.trimmingCharacters(
        in: .whitespacesAndNewlines
    )

    guard !nombreLimpio.isEmpty else {

        print("El nombre de la estación no puede estar vacío.")
        return
    }

    if encontrarEstacion(nombreLimpio) != nil {

        print("La estación ya existe.")
        return
    }

    guard var estaciones = obtenerEstacionesDeLinea(linea) else {

        print("La línea no existe.")
        return
    }

    // Buscar las estaciones ignorando tildes y mayúsculas.
    guard let indiceA = indiceEstacion(
              estacionA,
              en: estaciones
          ),
          let indiceB = indiceEstacion(
              estacionB,
              en: estaciones
          ) else {

        print("Una de las estaciones no existe en esa línea.")
        return
    }

    guard abs(indiceA - indiceB) == 1 else {

        print("Las estaciones deben ser consecutivas.")
        return
    }

    let posicion = max(indiceA, indiceB)

    estaciones.insert(
        nombreLimpio,
        at: posicion
    )

    if linea == "Línea 1" {

        lineaUno = estaciones

    } else if linea == "Línea 2" {

        lineaDos = estaciones

    } else {

        nuevasLineas[linea] = estaciones
    }

    construirConexionesLinea(
        estaciones,
        nombreLinea: linea
    )

    print(
        "Estación insertada correctamente en \(linea)."
    )
}


func crearNuevaLinea(
    nombreLinea: String,
    estaciones: [String]
) {

    let nombreLineaLimpio = nombreLinea.trimmingCharacters(
        in: .whitespacesAndNewlines
    )

    if nombreLineaLimpio.isEmpty {

        print("El nombre de la línea no puede estar vacío.")
        return
    }

    if nombreLineaLimpio == "Línea 1" ||
       nombreLineaLimpio == "Línea 2" ||
       nuevasLineas[nombreLineaLimpio] != nil {

        print("La línea ya existe.")
        return
    }

    if estaciones.isEmpty {

        print("La línea debe tener al menos una estación.")
        return
    }

    for estacion in estaciones {

        if encontrarEstacion(estacion) != nil {

            print(
                "La estación \(estacion) ya pertenece a otra línea."
            )

            return
        }
    }

    nuevasLineas[nombreLineaLimpio] = estaciones

    tarifas[nombreLineaLimpio] = (
        adulto: 1.50,
        medio: 0.75
    )

    construirConexionesLinea(
        estaciones,
        nombreLinea: nombreLineaLimpio
    )

    print("\n===== NUEVA LÍNEA CREADA =====")
    print("Línea: \(nombreLineaLimpio)")
    print("Estaciones:")

    for (i, estacion) in estaciones.enumerated() {

        print("\(i + 1). \(estacion)")
    }
}


// ============================================================
// 8. MODO ADMINISTRADOR
// ============================================================

func modoAdministrador() {

    var continuarAdmin = true

    while continuarAdmin {

        print("\n===== MODO ADMINISTRADOR =====")
        print("1) Agregar estación al final de una línea")
        print("2) Insertar estación entre dos estaciones")
        print("3) Crear una línea nueva")
        print("4) Salir del modo administrador")
        print("Seleccione una opción:")

        let opcion = readLine() ?? ""

        switch opcion {

        case "1":

            print("Nombre de la nueva estación:")

            let nombre = readLine() ?? ""

            print("¿A qué línea pertenece?")
            print("1) Línea 1")
            print("2) Línea 2")
            print("También puede escribir el nombre de una línea nueva.")

            let opcionLinea = readLine() ?? ""

            if opcionLinea == "1" {

                agregarEstacionFinal(
                    nombre: nombre,
                    linea: "Línea 1"
                )

            } else if opcionLinea == "2" {

                agregarEstacionFinal(
                    nombre: nombre,
                    linea: "Línea 2"
                )

            } else {

                agregarEstacionFinal(
                    nombre: nombre,
                    linea: opcionLinea
                )
            }


        case "2":

            print("Nombre de la nueva estación:")

            let nombre = readLine() ?? ""

            print("Primera estación:")

            let estacionA = readLine() ?? ""

            print("Segunda estación:")

            let estacionB = readLine() ?? ""

            print("¿En qué línea?")
            print("1) Línea 1")
            print("2) Línea 2")
            print("También puede escribir el nombre de una línea nueva.")

            let opcionLinea = readLine() ?? ""

            var nombreLinea = opcionLinea

            if opcionLinea == "1" {
                nombreLinea = "Línea 1"
            }

            if opcionLinea == "2" {
                nombreLinea = "Línea 2"
            }

            insertarEstacion(
                nombre: nombre,
                entre: estacionA,
                y: estacionB,
                linea: nombreLinea
            )


        case "3":

            print("Nombre de la nueva línea:")

            let nombreLinea = readLine() ?? ""

            print("¿Cuántas estaciones tendrá?")

            let cantidadTexto = readLine() ?? ""

            guard let cantidad = Int(cantidadTexto),
                  cantidad > 0 else {

                print("Cantidad no válida.")
                continue
            }

            var estaciones: [String] = []

            for i in 1...cantidad {

                print("Nombre de la estación \(i):")

                let estacion = readLine() ?? ""

                if !estacion.isEmpty {

                    estaciones.append(estacion)
                }
            }

            crearNuevaLinea(
                nombreLinea: nombreLinea,
                estaciones: estaciones
            )


        case "4":

            print("Saliendo del modo administrador...")
            continuarAdmin = false


        default:

            print("Opción no válida.")
        }
    }
}


// ============================================================
// MENÚ PRINCIPAL
// ============================================================

var continuar = true

while continuar {

    print("\n===== SISTEMA DE CONSULTAS - METRO DE LIMA =====")
    print("1) Buscar estación")
    print("2) Ver estaciones de una línea")
    print("3) Buscar ruta entre dos estaciones")
    print("4) Ver tarifas por línea")
    print("5) Planificar viaje")
    print("6) Gestionar tarjeta de transporte")
    print("7) Modo administrador")
    print("8) Salir")
    print("Seleccione una opción:")

    let opcion = readLine()?
        .trimmingCharacters(
            in: .whitespacesAndNewlines
        ) ?? ""

    switch opcion {

    case "1":

        print("Nombre de la estación:")

        let estacion = readLine()?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? ""

        buscarEstacion(estacion)


    case "2":

        print("¿Qué línea? (1 o 2)")

        let linea = readLine()?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? ""

        mostrarLinea(linea)


    case "3":

        print("Estación de origen:")

        let origen = readLine()?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? ""

        print("Estación de destino:")

        let destino = readLine()?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? ""

        buscarRuta(
            desde: origen,
            hasta: destino
        )


    case "4":

        print("\n===== TARIFAS =====")

        for (linea, tarifa) in tarifas {

            print(
                "\(linea): Adulto S/. \(tarifa.adulto) | " +
                "Medio pasaje S/. \(tarifa.medio)"
            )
        }


    case "5":

        print("\n===== PLANIFICACIÓN DEL VIAJE =====")

        print("Estación de origen:")

        let origen = readLine()?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? ""

        print("Estación de destino:")

        let destino = readLine()?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? ""

        planificarViaje(
            desde: origen,
            hasta: destino
        )


    case "6":

        var continuarTarjeta = true

        while continuarTarjeta {

            print("\n===== TARJETA DE TRANSPORTE =====")
            print("1) Consultar saldo")
            print("2) Recargar saldo")
            print("3) Pagar pasaje")
            print("4) Volver")
            print("Seleccione una opción:")

            let opcionTarjeta = readLine() ?? ""

            switch opcionTarjeta {

            case "1":

                consultarSaldo()


            case "2":

                print("Monto a recargar:")

                let montoTexto = readLine() ?? ""

                if let monto = Double(montoTexto) {

                    recargarTarjeta(monto)

                } else {

                    print("Monto no válido.")
                }


            case "3":

                print("Línea:")
                print("1) Línea 1")
                print("2) Línea 2")

                let linea = readLine() ?? ""

                var nombreLinea = ""

                if linea == "1" {

                    nombreLinea = "Línea 1"

                } else if linea == "2" {

                    nombreLinea = "Línea 2"

                } else {

                    nombreLinea = linea
                }

                print("Tipo de pasajero:")
                print("adulto / medio")

                let tipo = readLine() ?? ""

                pagarPasaje(
                    linea: nombreLinea,
                    tipoPasajero: tipo
                )


            case "4":

                continuarTarjeta = false


            default:

                print("Opción no válida.")
            }
        }


    case "7":

        modoAdministrador()


    case "8":

        print("Saliendo...")
        continuar = false


    default:

        print("Opción no válida.")
    }
}

