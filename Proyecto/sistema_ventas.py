import pymysql

connection = pymysql.connect(
    host="localhost",
    user="root",
    password="12345",
    database="SistemaVentas"
)

cursor = connection.cursor()

# Funciones del sistema
def menu_principal():
    while True:
        print("\nMenú Principal:")
        print("1. Gestión de Productos")
        print("2. Gestión de Clientes")
        print("3. Procesamiento de Órdenes")
        print("4. Búsquedas Avanzadas")
        print("5. Reporte de Productos Más Vendidos")
        print("6. Modificar Valor de un Producto")
        print("0. Salir")
        
        opcion = input("Seleccione una opción: ")
        
        if opcion == "1":
            gestion_productos()
        elif opcion == "2":
            gestion_clientes()
        elif opcion == "3":
            procesamiento_ordenes()
        elif opcion == "4":
            busquedas_avanzadas()
        elif opcion == "5":
            reporte_productos_mas_vendidos()
        elif opcion == "6":
            modificar_valor_producto()
        elif opcion == "0":
            print("Saliendo del sistema...")
            break
        else:
            print("Opción inválida. Intente nuevamente.")

def gestion_productos():
    print("\nGestión de Productos:")
    print("1. Agregar Producto")
    print("2. Actualizar Producto")
    print("3. Ver Productos")
    print("4. Eliminar Producto")
    
    opcion = input("Seleccione una opción: ")
    
    if opcion == "1":
        nombre = input("Nombre del producto: ")
        categoria = input("Categoría: ")
        precio = float(input("Precio: "))
        stock = int(input("Stock: "))
        cursor.execute("INSERT INTO Productos (Nombre, Categoría, Precio, Stock) VALUES (%s, %s, %s, %s)", (nombre, categoria, precio, stock))
        connection.commit()
        print("Producto agregado correctamente.")
    elif opcion == "2":
        producto_id = int(input("ID del producto a actualizar: "))
        nuevo_precio = float(input("Nuevo precio: "))
        nuevo_stock = int(input("Nuevo stock: "))
        cursor.execute("UPDATE Productos SET Precio = %s, Stock = %s WHERE ProductoID = %s", (nuevo_precio, nuevo_stock, producto_id))
        connection.commit()
        print("Producto actualizado correctamente.")
    elif opcion == "3":
        cursor.execute("SELECT * FROM Productos")
        for producto in cursor.fetchall():
            print(producto)
    elif opcion == "4":
        producto_id = int(input("ID del producto a eliminar: "))
        cursor.execute("DELETE FROM Productos WHERE ProductoID = %s", (producto_id,))
        connection.commit()
        print("Producto eliminado correctamente.")
    else:
        print("Opción inválida.")

def gestion_clientes():
    print("\nGestión de Clientes:")
    print("1. Registrar Cliente")
    print("2. Actualizar Cliente")
    print("3. Ver Clientes")
    
    opcion = input("Seleccione una opción: ")
    
    if opcion == "1":
        nombre = input("Nombre del cliente: ")
        email = input("Email: ")
        telefono = input("Teléfono: ")
        direccion = input("Dirección: ")
        cursor.execute("INSERT INTO Clientes (Nombre, Email, Teléfono, Dirección) VALUES (%s, %s, %s, %s)", (nombre, email, telefono, direccion))
        connection.commit()
        print("Cliente registrado correctamente.")
    elif opcion == "2":
        cliente_id = int(input("ID del cliente a actualizar: "))
        nuevo_telefono = input("Nuevo teléfono: ")
        nueva_direccion = input("Nueva dirección: ")
        cursor.execute("UPDATE Clientes SET Teléfono = %s, Dirección = %s WHERE ClienteID = %s", (nuevo_telefono, nueva_direccion, cliente_id))
        connection.commit()
        print("Cliente actualizado correctamente.")
    elif opcion == "3":
        cursor.execute("SELECT * FROM Clientes")
        for cliente in cursor.fetchall():
            print(cliente)
    else:
        print("Opción inválida.")

def procesamiento_ordenes():
    cliente_id = int(input("Ingrese el ID del cliente: "))
    cursor.execute("""
        SELECT Órdenes.OrdenID, Órdenes.Fecha, Productos.Nombre, DetalleOrden.Cantidad
        FROM Órdenes
        JOIN DetalleOrden ON Órdenes.OrdenID = DetalleOrden.OrdenID
        JOIN Productos ON DetalleOrden.ProductoID = Productos.ProductoID
        WHERE Órdenes.ClienteID = %s
    """, (cliente_id,))
    for orden in cursor.fetchall():
        print(orden)

def busquedas_avanzadas():
    print("\nBúsquedas Avanzadas:")
    print("1. Productos más vendidos")
    print("2. Clientes con más órdenes")
    
    opcion = input("Seleccione una opción: ")
    
    if opcion == "1":
        cursor.execute("""
            SELECT Productos.Nombre, SUM(DetalleOrden.Cantidad) AS Total
            FROM DetalleOrden
            JOIN Productos ON DetalleOrden.ProductoID = Productos.ProductoID
            GROUP BY Productos.ProductoID
            ORDER BY Total DESC
        """)
        for producto in cursor.fetchall():
            print(producto)
    elif opcion == "2":
        cursor.execute("""
            SELECT Clientes.Nombre, COUNT(Órdenes.OrdenID) AS Total
            FROM Órdenes
            JOIN Clientes ON Órdenes.ClienteID = Clientes.ClienteID
            GROUP BY Clientes.ClienteID
            ORDER BY Total DESC
        """)
        for cliente in cursor.fetchall():
            print(cliente)
    else:
        print("Opción inválida.")

def reporte_productos_mas_vendidos():
    cursor.execute("""
        SELECT Productos.Nombre, SUM(DetalleOrden.Cantidad) AS Total
        FROM DetalleOrden
        JOIN Productos ON DetalleOrden.ProductoID = Productos.ProductoID
        GROUP BY Productos.ProductoID
        ORDER BY Total DESC
        LIMIT 1
    """)
    resultado = cursor.fetchone()
    if resultado:
        print(f"Producto más vendido: {resultado[0]} con {resultado[1]} unidades vendidas.")
    else:
        print("No hay datos suficientes para generar el reporte.")

def modificar_valor_producto():
    producto_id = int(input("Ingrese el ID del producto a modificar: "))
    nueva_cantidad = int(input("Ingrese la cantidad máxima permitida: "))
    cursor.execute("""
        UPDATE DetalleOrden
        SET Cantidad = LEAST(Cantidad, %s)
        WHERE ProductoID = %s
    """, (nueva_cantidad, producto_id))
    connection.commit()
    print("Órdenes modificadas correctamente.")

# Menú principal
if __name__ == "__main__":
    menu_principal()
    cursor.close()
    connection.close()
