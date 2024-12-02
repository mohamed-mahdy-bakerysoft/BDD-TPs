DROP DATABASE IF EXISTS SistemaVentas;
CREATE DATABASE SistemaVentas;
USE SistemaVentas;

-- Tabla Productos
CREATE TABLE Productos (
    ProductoID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Categoría VARCHAR(50),
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);

-- Tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Teléfono VARCHAR(15),
    Dirección VARCHAR(255)
);

-- Tabla Órdenes
CREATE TABLE Órdenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID) ON DELETE CASCADE
);

-- Tabla DetalleOrden
CREATE TABLE DetalleOrden (
    DetalleID INT AUTO_INCREMENT PRIMARY KEY,
    OrdenID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    FOREIGN KEY (OrdenID) REFERENCES Órdenes(OrdenID) ON DELETE CASCADE,
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID) ON UPDATE CASCADE
);

-- Insertar Productos
INSERT INTO Productos (Nombre, Categoría, Precio, Stock)
VALUES
('Laptop Dell', 'Electrónica', 1200.50, 15),
('Auriculares Sony', 'Electrónica', 99.99, 50),
('Mouse Logitech', 'Accesorios', 29.99, 100),
('Teclado Mecánico', 'Accesorios', 89.99, 30),
('Monitor Samsung', 'Electrónica', 249.99, 20),
('Smartphone Samsung', 'Electrónica', 899.99, 25),
('Cargador Universal', 'Accesorios', 19.99, 200),
('Impresora HP', 'Oficina', 199.99, 10),
('Tablet iPad', 'Electrónica', 499.99, 8),
('Disco Externo 1TB', 'Almacenamiento', 79.99, 40);

-- Insertar Clientes
INSERT INTO Clientes (Nombre, Email, Teléfono, Dirección)
VALUES
('Juan Pérez', 'juan.perez@example.com', '123456789', 'Calle Falsa 123'),
('María López', 'maria.lopez@example.com', '987654321', 'Avenida Siempre Viva 742'),
('Carlos García', 'carlos.garcia@example.com', '456789123', 'Boulevard Central 456'),
('Ana Martínez', 'ana.martinez@example.com', '789123456', 'Callejón sin Salida 89'),
('Pedro Sánchez', 'pedro.sanchez@example.com', '321654987', 'Pasaje Estrella 101'),
('Laura Fernández', 'laura.fernandez@example.com', '159753468', 'Camino Real 202'),
('Luis Gómez', 'luis.gomez@example.com', '753159846', 'Paseo del Prado 303'),
('Sofía Ramírez', 'sofia.ramirez@example.com', '951357486', 'Calle del Sol 404'),
('Diego Torres', 'diego.torres@example.com', '852963741', 'Vía Láctea 505'),
('Lucía Morales', 'lucia.morales@example.com', '963852741', 'Sendero de Luna 606');

-- Insertar Órdenes
INSERT INTO Órdenes (ClienteID, Fecha)
VALUES
(1, '2024-11-01'),
(2, '2024-11-02'),
(3, '2024-11-03'),
(4, '2024-11-04'),
(5, '2024-11-05'),
(6, '2024-11-06'),
(7, '2024-11-07'),
(8, '2024-11-08'),
(9, '2024-11-09'),
(10, '2024-11-10');

-- Insertar Detalle de Órdenes
INSERT INTO DetalleOrden (OrdenID, ProductoID, Cantidad)
VALUES
(1, 1, 1), -- Laptop Dell
(1, 2, 2), -- Auriculares Sony
(2, 3, 3), -- Mouse Logitech
(3, 4, 1), -- Teclado Mecánico
(4, 5, 1), -- Monitor Samsung
(5, 6, 2), -- Smartphone Samsung
(6, 7, 5), -- Cargador Universal
(7, 8, 1), -- Impresora HP
(8, 9, 1), -- Tablet iPad
(9, 10, 3); -- Disco Externo 1TB
