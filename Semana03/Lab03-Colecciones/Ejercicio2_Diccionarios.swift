// Desarrollado por: Steven Saldaña Melendez
import Foundation

var productos: [String: Double] = [:]
for i in 1...4 {
    print("Producto \(i) - Nombre:")
    let nombre = readLine() ?? ""
    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0
    productos[nombre] = precio
}

print("===== CATÁLOGO =====")
for (nombre, precio) in productos {
    print("\(nombre): S/. \(precio)")
}

var valorTotal = 0.0
for (_, precio) in productos { valorTotal += precio }
print("Valor total: S/. \(valorTotal)")

print("Buscar producto:")
let buscarProd = readLine() ?? ""
if let precioEncontrado = productos[buscarProd] {
    print("\(buscarProd) cuesta S/. \(precioEncontrado)")
} else {
    print("Producto no encontrado")
}

// ===== ANALYZE =====
let edades: [String: Int] = ["Ana": 20, "Luis": 22, "María": 19]
var mayores: [String] = []
for (nombre, edad) in edades {
    if edad >= 21 { mayores.append(nombre) }
}
print("Mayores de 21: \(mayores)")
// Recorre el diccionario y agrega al array los nombres con edad >= 21.
// Solo Luis (22) cumple, así que imprime: Mayores de 21: ["Luis"]
