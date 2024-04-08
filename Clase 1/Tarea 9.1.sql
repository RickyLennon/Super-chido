-- Contar los elementos de la columna de una tabla.
CREATE TABLE Vector(
   Conteo INT,
   Elemento DOUBLE
);

INSERT INTO Vector(Conteo, Elemento) 
VALUES (1, 6),
       (1, 7),
       (1, 8),
       (1, 9),
       (1, 10),
       (1, NULL),
       (1, 1);

DROP PROCEDURE IF EXISTS Contar_elementos;
DELIMITER //
CREATE PROCEDURE Contar_elementos(
      OUT Contador INT
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE Maximo INT DEFAULT (SELECT SUM(Conteo) FROM Vector);
   
    Contar: LOOP 
	    SET i = i + 1;
	   
	    IF i > Maximo THEN 
	       LEAVE Contar;
    	END IF;
        
        SET Contador = i;  
    END LOOP Contar; 
END // 
DELIMITER ; 

CALL Contar_elementos(@Total_de_elementos);
SELECT @Total_de_elementos AS Total_de_elementos;

-- Calcular la correlacion entre 2 conjuntos de datos.
CREATE TABLE Valores(
   Id INT PRIMARY KEY AUTO_INCREMENT,
   V1 DOUBLE,
   V2 DOUBLE
);

INSERT INTO Valores(V1, V2) 
VALUES (6, 45),
       (12, 47),
       (13, 39),
       (17, 58),
       (22, 68),
       (25, 76),
       (27, 75),
       (29, 74),
       (30, 78),
       (32, 81);

CREATE TABLE Diferencias(
   Id INT PRIMARY KEY AUTO_INCREMENT,
   Dif_media_1 DOUBLE,
   Dif_media_2 DOUBLE
);

INSERT INTO Diferencias(Dif_media_1, Dif_media_2) 
   SELECT (V1 - AVG(V1) OVER()), 
          (V2 - AVG(V2) OVER()) 
   FROM Valores;
  
CREATE TABLE Productos(
   Id INT PRIMARY KEY AUTO_INCREMENT,
   Prod_dif_media DOUBLE
);

INSERT INTO Productos(Prod_dif_media) SELECT Dif_media_1 * Dif_media_2 FROM Diferencias;

CREATE TABLE Cuadrado1(
   Id INT PRIMARY KEY AUTO_INCREMENT,
   Dif_media_cua1 DOUBLE
);

INSERT INTO Cuadrado1(Dif_media_cua1) SELECT Dif_media_1 * Dif_media_1 FROM Diferencias;

CREATE TABLE Cuadrado2(
   Id INT PRIMARY KEY AUTO_INCREMENT,
   Dif_media_cua2 DOUBLE
);
       
INSERT INTO Cuadrado2(Dif_media_cua2) SELECT Dif_media_2 * Dif_media_2 FROM Diferencias;

CREATE TABLE Datos AS
SELECT V1, V2, Dif_media_1, Dif_media_2, Prod_dif_media, Dif_media_cua1, Dif_media_cua2  
   FROM Valores
   INNER JOIN Diferencias ON Diferencias.Id = Valores.Id
   INNER JOIN Productos ON Productos.Id = Valores.Id
   INNER JOIN Cuadrado1 ON Cuadrado1.Id = Valores.Id
   INNER JOIN Cuadrado2 ON Cuadrado2.Id = Valores.Id; 

DROP FUNCTION IF EXISTS Correlacion;
DELIMITER $$
CREATE FUNCTION Correlacion()
RETURNS DOUBLE DETERMINISTIC
BEGIN
	DECLARE SUMA1 DOUBLE DEFAULT (SELECT SUM(Prod_dif_media) FROM Productos);
    DECLARE SUMA2 DOUBLE DEFAULT (SELECT SUM(Dif_media_cua1) FROM Cuadrado1);
    DECLARE SUMA3 DOUBLE DEFAULT (SELECT SUM(Dif_media_cua2) FROM Cuadrado2);
    DECLARE r DOUBLE;
   
    IF SUMA2 = 0 OR SUMA3 = 0 THEN
         SET r = 0;
    ELSE
         SET r = SUMA1 / (SELECT SQRT(SUMA2 * SUMA3));   
    END IF;
        
    RETURN r;
END $$
DELIMITER ;

SELECT Correlacion();