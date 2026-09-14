// Desarrollado por: Steven Saldaña Melendez
import Foundation

var precios: [String: Double] = [:]
var stocks: [String: Int] = [:]
print("¿Cuántos productos?")
let n = Int(readLine() ?? "") ?? 0

if n > 0 {
    for i in 1...n {
        print("Producto \(i) - Nombre:")
        let nombre = readLine() ?? ""
        print("Precio:")
        let precio = Double(readLine() ?? "") ?? 0
        print("Stock:")
        let stock = Int(readLine() ?? "") ?? 0
        precios[nombre] = precio
        stocks[nombre] = stock
    }
}

var valorTotal = 0.0
for (nombre, precio) in precios {
    let stock = stocks[nombre] ?? 0
    valorTotal += precio * Double(stock)
}
print("Valor total del inventario: S/. \(valorTotal)")

print("===== STOCK BAJO =====")
for (nombre, stock) in stocks {
    if stock < 5 { print("\(nombre): \(stock) unidades") }
}
