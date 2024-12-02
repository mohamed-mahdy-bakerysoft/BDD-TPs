# Justificación del Diseño  
## Proyecto 2: Sistema de Ventas en Línea  

El diseño del sistema está basado en las entidades principales necesarias para un sistema de ventas en línea, cumpliendo con las tres primeras formas normales (1NF, 2NF y 3NF) para garantizar la integridad y eficiencia.  

---

## Entidades y sus relaciones  

### 1. Productos:  
- Representa los productos disponibles para la venta.  
- **Atributos**:  
  - `ProductoID`: Identificador único.  
  - `Nombre`, `Categoría`: Datos descriptivos del producto.  
  - `Precio`: Precio unitario del producto.  
  - `Stock`: Cantidad disponible en inventario.  

### 2. Clientes:  
- Representa los clientes que realizan órdenes.  
- **Atributos**:  
  - `ClienteID`: Identificador único.  
  - `Nombre`, `Email`, `Teléfono`, `Dirección`: Datos de contacto.  

### 3. Órdenes:  
- Representa las órdenes realizadas por los clientes.  
- **Atributos**:  
  - `OrdenID`: Identificador único.  
  - `ClienteID`: Relación con la tabla Clientes.  
  - `Fecha`: Fecha de creación de la orden.  

### 4. DetalleOrden:  
- Representa los productos asociados a cada orden.  
- **Atributos**:  
  - `DetalleID`: Identificador único.  
  - `OrdenID`: Relación con la tabla Órdenes.  
  - `ProductoID`: Relación con la tabla Productos.  
  - `Cantidad`: Número de unidades del producto en la orden.  

---

## Relaciones y Normalización  

- **Productos y DetalleOrden**: Relación 1:N (un producto puede estar en varias órdenes).  
- **Clientes y Órdenes**: Relación 1:N (un cliente puede realizar varias órdenes).  
- **Órdenes y DetalleOrden**: Relación 1:N (una orden puede tener múltiples productos).  

### Este diseño elimina redundancias:  
- **1NF**: Datos atómicos y no repetidos.  
- **2NF**: Cada atributo depende completamente de la clave primaria.  
- **3NF**: No hay dependencias transitivas.  

---

## Restricciones  

- Claves primarias en todas las tablas.  
- Claves foráneas con `ON DELETE CASCADE` y `ON UPDATE CASCADE`.  
- Restricciones `NOT NULL` y `UNIQUE` en columnas clave (`Email`, `ClienteID`, etc.).  

---

## Consultas Avanzadas  

El diseño permite realizar consultas avanzadas como:  
- Recuperar productos más vendidos.  
- Consultar órdenes de un cliente.  
- Generar reportes basados en filtros.  

---

## Justificación técnica  

El sistema se implementa con **MySQL**, usando **PyMySQL** para interactuar con la base de datos desde Python. Este enfoque garantiza compatibilidad con métodos modernos de autenticación y escalabilidad.  
