// Desarrollado por: [Steven Saldaña Melendez]
import Foundation

print("¿Cuántos productos desea registrar?")
let cantidad = Int(readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") ?? 0

var precios: [String: Double] = [:]
var stocks: [String: Int] = [:]

if cantidad > 0 {
    for i in 1...cantidad {
        print("\nProducto \(i) - Nombre:")
        let nombre = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        print("Precio:")
        let precio = Double(readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") ?? 0
        print("Stock:")
        let stock = Int(readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") ?? 0
        precios[nombre] = precio
        stocks[nombre] = stock
    }
}

var continuar = true

while continuar {
    print("\n===== MENÚ DE INVENTARIO =====")
    print("1) Ver inventario")
    print("2) Buscar producto")
    print("3) Stock bajo")
    print("4) Valor total")
    print("5) Salir")
    print("Seleccione una opción:")
    let opcion = Int(readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") ?? 0

    switch opcion {
    case 1:
        print("\n===== INVENTARIO =====")
        for (nombre, precio) in precios {
            let stock = stocks[nombre] ?? 0
            print("\(nombre) | Precio: S/. \(precio) | Stock: \(stock)")
        }
    case 2:
        print("\nIngrese el nombre del producto:")
        let buscar = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if let precio = precios[buscar] {
            let stock = stocks[buscar] ?? 0
            print("\(buscar) | Precio: S/. \(precio) | Stock: \(stock)")
        } else {
            print("Producto no encontrado.")
        }
    case 3:
        print("\n===== STOCK BAJO =====")
        var encontrados = false
        for (nombre, stock) in stocks {
            if stock < 5 {
                print("\(nombre): \(stock) unidades")
                encontrados = true
            }
        }
        if !encontrados { print("No hay productos con stock bajo.") }
    case 4:
        var valorTotal = 0.0
        for (nombre, precio) in precios {
            let stock = stocks[nombre] ?? 0
            valorTotal += precio * Double(stock)
        }
        print("\nValor total del inventario: S/. \(String(format: "%.2f", valorTotal))")
    case 5:
        continuar = false
        print("Programa finalizado.")
    default:
        print("Opción no válida. Seleccione del 1 al 5.")
    }
}
