# Requerimientos Funcionales

## Funciones Principales

| Función | Descripción |
| --- | --- |
| `construirLinea()` | Construye la información de una línea, registrando sus estaciones, conexiones y accesibilidad. |
| `buscarEstacion()` | Busca una estación y muestra su línea, estaciones conectadas, accesibilidad y tarifas. |
| `mostrarLinea()` | Muestra todas las estaciones correspondientes a la Línea 1 o Línea 2. |
| `buscarRuta()` | Busca una ruta entre dos estaciones y muestra las paradas, tiempo estimado y tarifa. |

---

## Funciones Nuevas

| Función | Descripción |
| --- | --- |
| `planificarViaje()` | Calcula las estaciones restantes hasta el destino o identifica posibles puntos de interconexión entre líneas. |
| `consultarSaldo()` | Muestra el saldo disponible en la tarjeta de transporte. |
| `recargarTarjeta()` | Permite aumentar el saldo disponible de la tarjeta de transporte. |
| `pagarPasaje()` | Simula el cobro de un pasaje según la línea y el tipo de pasajero. |
| `referenciasCercanas()` | Muestra lugares o referencias ubicadas alrededor de una estación. |
| `agregarEstacionFinal()` | Permite al administrador agregar una nueva estación al final de una línea existente. |
| `insertarEstacion()` | Permite insertar una nueva estación entre dos estaciones consecutivas de una línea. |
| `crearNuevaLinea()` | Permite al administrador crear una nueva línea con sus respectivas estaciones. |
| `construirConexionesLinea()` | Actualiza las conexiones entre estaciones después de modificar una línea. |
| `modoAdministrador()` | Proporciona un menú para gestionar el crecimiento y modificación de la red del Metro. |

---

## Sistema de Menú

| Módulo / Menú | Descripción |
| --- | --- |
| **Menú principal** | Permite acceder a la búsqueda de estaciones, consulta de líneas, rutas, tarifas y salida del sistema. |
| **Modo administrador** | Permite gestionar estaciones y líneas mediante las funciones de administración de la red. |
| **Gestión de tarjeta** | Permite consultar saldo, realizar recargas y simular el pago de pasajes. |
