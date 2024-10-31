--Creacion de las tablas
CREATE TABLE Inventario (
    ProductoId INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto VARCHAR(100) NOT NULL,
    Cantidad INT NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE HistorialInventario (
    HistorialId INT PRIMARY KEY IDENTITY(1,1),
    ProductoId INT FOREIGN KEY REFERENCES Inventario(ProductoId),
    FechaCambio DATETIME NOT NULL,
    Cambio INT NOT NULL, -- Puede ser positivo o negativo
    Motivo VARCHAR(255) NOT NULL
);

--Insercion de datos
INSERT INTO Inventario (NombreProducto, Cantidad, Precio)
VALUES 
    (1, 'Producto A', 50, 10.00),
    (2, 'Producto B', 30, 20.50),
    (3, 'Producto C', 20, 15.75);

INSERT INTO HistorialInventario (ProductoId, FechaCambio, Cambio, Motivo)
VALUES 
    (1, GETDATE(), -5, 'Venta'),
    (2, GETDATE(), 10, 'Recepción de stock'),
    (1, GETDATE(), 2, 'Devolución');

--Procedimiento
DELIMITER //
CREATE PROCEDURE RegistrarCambiosInventario(IN cambios TABLE (ProductoId INT,Cambio INT,Motivo VARCHAR(255)))
BEGIN 
  DECLARE done INT DEFAULT FALSE;
  DECLARE productoId INT;
  DECLARE cambio INT;
  DECLARE motivo VARCHAR(255);

  DECLARE cursor_cambios CURSOR FOR SELECT ProductoId, Cambio, Motivo FROM cambios;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cursor_cambios;
  FETCH cursor_cambios INTO productoId, cambio, motivo;

  WHILE NOT done DO
    UPDATE Inventario SET Cantidad = Cantidad + cambio WHERE ProductoId = productoId;
    INSERT INTO HistorialInventario (ProductoId, FechaCambio, Cambio, Motivo) VALUES (productoId, GETDATE(), cambio, motivo);
    FETCH cursor_cambios INTO productoId, cambio, motivo;
  END WHILE;

  CLOSE cursor_cambios;
END;
//
DELIMITER ;

CREATE TEMPORARY TABLE CambiosTemp (
    ProductoId INT,
    Cambio INT,
    Motivo VARCHAR(255)
);
INSERT INTO CambiosTemp (ProductoId, Cambio, Motivo) VALUES (1, 10, 'Venta');
INSERT INTO CambiosTemp (ProductoId, Cambio, Motivo) VALUES (2, -5, 'Devolución');

CALL RegistrarCambiosInventario(CambiosTemp);
