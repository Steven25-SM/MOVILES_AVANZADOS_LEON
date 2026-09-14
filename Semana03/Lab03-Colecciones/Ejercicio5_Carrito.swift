// Desarrollado por: Steven Saldaña Melendez
import Foundation

var nombres: [String] = []
var precios: [Double] = []
var cantidades: [Int] = []

print("¿Cuántos productos va a comprar?")
let totalProductos = Int(readLine() ?? "") ?? 0

if totalProductos > 0 {
    for i in 1...totalProductos {
        print("\nProducto \(i) - Nombre:")
        nombres.append(readLine() ?? "")
        print("Precio unitario:")
        precios.append(Double(readLine() ?? "") ?? 0)
        print("Cantidad:")
        cantidades.append(Int(readLine() ?? "") ?? 0)
    }
}

var subtotales: [Double] = []
for i in 0..<nombres.count {
    subtotales.append(precios[i] * Double(cantidades[i]))
}

var totalCarrito = 0.0
for subtotal in subtotales { totalCarrito += subtotal }

print("\nNombre del cliente:")
let cliente = readLine() ?? ""

var descPct = 0.0
if totalCarrito >= 5000 { descPct = 0.15 }
else if totalCarrito >= 2000 { descPct = 0.10 }
else if totalCarrito >= 500 { descPct = 0.05 }

let descuento = totalCarrito * descPct
let totalConDesc = totalCarrito - descuento
let igv = totalConDesc * 0.18
let totalFinal = totalConDesc + igv

var categoria = ""
switch Int(totalCarrito) {
case 0..<500: categoria = "Regular"
case 500..<2000: categoria = "Frecuente"
case 2000..<5000: categoria = "VIP"
default: categoria = "Premium"
}

let sep = String(repeating: "=", count: 45)
print(sep)
print(" TICKET DE COMPRA 2.0")
print(" Cliente: \(cliente) (\(categoria))")
print(sep)
for i in 0..<nombres.count {
    print("\(nombres[i]) x\(cantidades[i]) S/. \(subtotales[i])")
}
print(sep)
print("Subtotal: S/. \(totalCarrito)")
if descPct > 0 {
    print("Descuento (\(descPct * 100)%): -S/. \(descuento)")
}
print("IGV (18%): S/. \(igv)")
print(sep)
print("TOTAL: S/. \(totalFinal)")
print(sep)
print("¡Gracias por su compra, \(cliente)!")
