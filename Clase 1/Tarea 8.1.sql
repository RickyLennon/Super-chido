-- Tablas
CREATE TABLE Orden(
    Ido DOUBLE PRIMARY KEY,
    Nom_art VARCHAR(30) DEFAULT ' ',
    Tipo_art VARCHAR(30) DEFAULT ' ',
    Cantidad INT NULL,
    Servicio VARCHAR(30) DEFAULT ' '
);

CREATE TABLE Pagar(
    Idp DOUBLE PRIMARY KEY,
    Precio_art FLOAT(5, 2) NULL,
    Monto_trans FLOAT(5, 2) NULL,
    Tipo_trans VARCHAR(30) DEFAULT ' '
);

CREATE TABLE Registros (
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Id_Orden DOUBLE NOT NULL,
	    FOREIGN KEY (Id_Orden) REFERENCES Orden(Ido),
	Id_Pagar DOUBLE NOT NULL, 
	    FOREIGN KEY (Id_Pagar) REFERENCES Pagar(Idp),
	GPR VARCHAR(30) DEFAULT ' ',
	Hora_venta VARCHAR(30) DEFAULT ' ',
	Fecha DATE NULL 
);

-- Vistas
CREATE VIEW Recibo AS  
SELECT Nom_art, Cantidad, Monto_trans, Tipo_trans, Fecha     
   FROM Registros
   JOIN Orden ON Orden.Ido = Registros.Id_Orden
   JOIN Pagar ON Pagar.Idp = Registros.Id_Pagar;

CREATE VIEW Incorrecion1 AS  
SELECT Ido, Nom_art, Tipo_art, Cantidad, Servicio     
   FROM Orden
   LEFT JOIN Registros 
   ON Orden.Ido = Registros.Id_Orden;
   
CREATE VIEW Incorrecion2 AS  
SELECT Idp, Precio_art, Monto_trans, Tipo_trans     
   FROM Registros
   RIGHT JOIN Pagar 
   ON Pagar.Idp = Registros.Id_Pagar;  
   
CREATE VIEW Subconsulta AS
SELECT Ido, Idp, Nom_art, Monto_trans, GPR, Hora_venta, Fecha
   FROM Registros
   INNER JOIN Orden ON Orden.Ido = Registros.Id_Orden
   INNER JOIN Pagar ON Pagar.Idp = Registros.Id_Pagar
   WHERE Nom_art IN (SELECT Nom_art From Orden 
   WHERE Nom_art = 'Frankie')
   AND YEAR(Fecha) = 2023 AND MONTH(Fecha) BETWEEN 06 AND 08 AND GPR = 'Sr.'
   ORDER BY Fecha; 
   
-- Triggers
-- En la tabla Orden
CREATE DEFINER=`root`@`localhost` TRIGGER `Actualizar` 
AFTER INSERT 
ON `orden` FOR EACH ROW 
INSERT INTO Pagar (Idp) 
VALUES (NEW.Ido + 0.001)

-- En la tabla Pagar
CREATE DEFINER=`root`@`localhost` TRIGGER `Actualizar2` 
AFTER INSERT 
ON `pagar` FOR EACH ROW 
INSERT INTO Registros (Id_Orden, Id_Pagar)
SELECT Orden.Ido, NEW.Idp
FROM Orden 
WHERE Orden.Ido = NEW.Idp - 0.001

