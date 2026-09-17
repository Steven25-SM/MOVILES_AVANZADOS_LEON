
// ===== CASO 1.5: HERENCIA Y POLIMORFISMO — LA CADENA DE SUCURSALES =====
// Desarrollado por: [Steven Saldaña Melendez]
// Docente: Juan León

enum CategoriaElectro {
    case lineaBlanca, tecnologia, pequenos
}

struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}

class Sucursal {
    let nombre: String
    let ciudad: String

    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }

    func descuento() -> Double {
        return 0.05
    }

    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }

    func cotizar(item: Electrodomestico) {
        let precioConDescuento = item.precioLista * (1 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio
        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envio S/ \(envio) = S/ \(total)")
    }
}

// ===== TODO 14: SucursalLima =====
class SucursalLima: Sucursal {
    override func descuento() -> Double {
        return 0.10
    }

    override func costoEnvio(monto: Double) -> Double {
        if monto >= 1500 {
            return 0.0
        } else {
            return 30.0
        }
    }
}

// ===== TODO 15: SucursalProvincia =====
class SucursalProvincia: Sucursal {
    // NO se sobreescribe descuento(): hereda el 5% de la base

    override func costoEnvio(monto: Double) -> Double {
        let envio = monto * 0.08
        if envio < 50.0 {
            return 50.0
        } else {
            return envio
        }
    }
}

// ===== TODO 16: SucursalOutlet =====
class SucursalOutlet: Sucursal {
    override func descuento() -> Double {
        return 0.25
    }

    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}

// ===== TODO 17: Recorrido polimórfico =====
let refrigeradora = Electrodomestico(nombre: "Refrigeradora", marca: "Frost", precioLista: 2000.0, categoria: .lineaBlanca)
let licuadora = Electrodomestico(nombre: "Licuadora", marca: "Mix", precioLista: 250.0, categoria: .pequenos)

var sucursales: [Sucursal] = [
    SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
    SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
    SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima")
]

print("===== Refrigeradora (S/ 2000.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}

print("===== Licuadora (S/ 250.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}

// ===== TODO 18: Prueba del polimorfismo — SucursalOnline =====
class SucursalOnline: Sucursal {
    override func costoEnvio(monto: Double) -> Double {
        return 15.0
    }
} // Solo necesite 4 lineas nuevas


sucursales.append(SucursalOnline(nombre: "Online", ciudad: "Lima"))


// ===== FIX =====
class SucursalMall: Sucursal {
    override func descuento() -> Double { // FIX 7: Nos faltaba "override"
        return 0.12 // Swift no nos dejaba,	 pues creìa que queriamos implementar un nuevo mètodo.
        // En realidad, queriamos reemplazar el comportamiento heredado
    }
}

class SucursalExpress: Sucursal {
    let radioKm: Int
    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm
        super.init(nombre: nombre, ciudad: ciudad) // FIX 8: faltaba llamar a super.init.
        // Toda subclase debe inicializar primero sus propias propiedades (radioKm)
        // y luego llamar a super.init() para que la clase base también quede
        // completamente inicializada (nombre y ciudad). Sin esa llamada no compila.
    }
}

// ===== PREDICT =====
let misteriosa: Sucursal = SucursalLima(nombre: "Lima Centro", ciudad: "Lima")
print(misteriosa.descuento()) // PREDICT 6: 0.10
// Aunque la variable está declarada como tipo Sucursal, Swift usa "dynamic dispatch"
// para métodos de clase: en tiempo de ejecución mira el tipo REAL del objeto
// (SucursalLima), no el tipo de la variable. Por eso llama a la versión sobreescrita.

let monto = 2000.0 * (1 - misteriosa.descuento())
print(misteriosa.costoEnvio(monto: monto)) // PREDICT 7: 0.0
// monto = 2000 * (1 - 0.10) = 1800.0 → SucursalLima.costoEnvio: 1800 >= 1500 → 0.0
