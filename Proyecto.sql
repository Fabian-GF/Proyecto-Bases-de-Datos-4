/*
Se quiere construir una aplicación para la Central de Préstamos de la Universidad, 
la cual se encarga de manejar el préstamo de todos los recursos que la universidad ofrece a sus estudiantes.

* Los recursos pueden ser de cualquier naturaleza, se identifican con un código y tienen además un nombre.
* Los códigos son únicos, pero los nombres pueden repetirse. 
* Cada recurso que se quiera prestar a los estudiantes debe ser registrado en la aplicación. 
* Un recurso se puede prestar sólo si está disponible, es decir que no se ha prestado a otro estudiante.
* Un estudiante se identifica por su código, que también es único, y tiene un nombre que eventualmente otro estudiante también podría tener. 
* Para que un estudiante pueda prestar algún recurso debe registrarse. 
* Si el estudiante no está registrado no se le prestará ningún recurso.
*/

/*La aplicación debe permitir:
1. Agregar un recurso
2. Agregar un estudiante
3. Prestar un recurso disponible
4. Consultar los préstamos de un estudiante
5. Consultar la información de un préstamo
6. Devolver un recurso prestado */

DROP DATABASE IF EXISTS central_prestamos;

CREATE DATABASE IF NOT EXISTS central_prestamos;

USE central_prestamos;

DROP TABLE IF EXISTS recursos;
CREATE TABLE IF NOT EXISTS recursos(
    codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    disponible BOOLEAN NOT NULL DEFAULT TRUE
);

DROP TABLE IF EXISTS estudiantes;
CREATE TABLE IF NOT EXISTS estudiantes(
    codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS prestamos;
CREATE TABLE IF NOT EXISTS prestamos(
	codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codigo_recurso INT NOT NULL,
    codigo_estudiante INT NOT NULL,
    fecha_prestamo TIMESTAMP NOT NULL DEFAULT (NOW()),
    fecha_devolucion TIMESTAMP,
    FOREIGN KEY (codigo_recurso) REFERENCES recursos(codigo));


INSERT INTO recursos (nombre, disponible)
VALUES 
	('Libro cien años de soledad', 0),
    ('Cien años de soledad', 1),
    ('Don Quijote de la Mancha', 1 ),
    ('La sombra del viento', 0),
    ('1984', 1 ),
    ('El principito', 0 ),
    ('Matar a un ruiseñor', 0 ),
    ('Orgullo y prejuicio', 0),
    ('Crimen y castigo', 1 ),
    ('En busca del tiempo perdido', 1),
    ('El gran Gatsby', 1);
    
INSERT INTO estudiantes(nombre, apellido)
VALUES
	('Julian', 'Perez'),
    ('Gabriel', 'García Márquez'),
    ('Miguel', 'de Cervantes'),
    ('Carlos', 'Ruiz Zafón'),
    ('George', 'Orwell'),
    ('Antoine', 'de Saint-Exupéry'),
    ('Harper', 'Lee'),
    ('Jane', 'Austen'),
    ('Fiódor', 'Dostoyevski'),
    ('Marcel', 'Proust'),
    ('F. Scott', 'Fitzgerald');
    
-- 1. Agregar un recurso
DROP PROCEDURE IF EXISTS agregar_recurso;

DELIMITER $$
CREATE PROCEDURE agregar_recurso(
  IN agr_nombre varchar(50)
  )
  BEGIN 
	INSERT INTO recursos( nombre)
    VALUES 
		(agr_nombre);
END $$
DELIMITER ;

-- 2. Agregar un estudiante
DROP PROCEDURE IF EXISTS agregar_estudiante;

DELIMITER $$
CREATE PROCEDURE agregar_estudiante(
  IN age_nombre VARCHAR(50),
  IN age_apellido VARCHAR(50)
)
BEGIN
	INSERT INTO estudiantes( nombre, apellido)
    VALUES
    (age_nombre, age_apellido);
END $$
DELIMITER ;

-- 3. Prestar un recurso disponible
DROP PROCEDURE IF EXISTS prestar_recurso;

DELIMITER $$
CREATE PROCEDURE prestar_recurso(
	IN codigo_recurso_p INT,
    IN codigo_estud_p INT
)
BEGIN 
	DECLARE recurso_disponible BOOLEAN;
    
    SELECT disponible INTO recurso_disponible FROM recursos WHERE codigo = codigo_recurso_p;
	IF recurso_disponible THEN 
    
		INSERT INTO prestamos (codigo_recurso, codigo_estudiante)
		VALUES 
			(codigo_recurso_p, codigo_estud_p);
        
		UPDATE recursos SET disponible = FALSE WHERE codigo = codigo_recurso_p;
    ELSE 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El recurso no está disponible';
	END IF;
END $$
DELIMITER ;

-- 4. Consultar los prestamos de un estudiante
DROP PROCEDURE IF EXISTS prestamos_estudiante;

DELIMITER $$
CREATE PROCEDURE prestamos_estudiante(
	IN codigo_estud_p INT
)
BEGIN
	SELECT 
		prestamos.codigo,
        prestamos.codigo_recurso,
        recursos.nombre AS recurso_nombre,
        prestamos.fecha_prestamo,
        prestamos.fecha_devolucion
	FROM prestamos
    JOIN recursos ON prestamos.codigo_recurso = recursos.codigo
    WHERE prestamos.codigo_estudiante = codigo_estud_p;
END $$
DELIMITER ;
	
-- 5. Consultar la información de un préstamo
DROP PROCEDURE IF EXISTS consultar_prestamo;

DELIMITER $$
CREATE PROCEDURE consultar_prestamo(
    IN codigo_prestamo_p INT
)
BEGIN
    SELECT 
        prestamos.codigo,
        prestamos.codigo_recurso,
        recursos.nombre AS recurso_nombre,
        prestamos.codigo_estudiante,
        prestamos.fecha_prestamo,
        prestamos.fecha_devolucion
    FROM prestamos
    JOIN recursos ON prestamos.codigo_recurso = recursos.codigo
    WHERE prestamos.codigo = codigo_prestamo_p;
END $$
DELIMITER ;
        
-- 6. Devolver un recurso prestado
DROP PROCEDURE IF EXISTS devolver_recurso;

DELIMITER $$
CREATE PROCEDURE devolver_recurso(
    IN codigo_recurso_p INT
)
BEGIN
    UPDATE prestamos SET fecha_devolucion = NOW() WHERE codigo_recurso = codigo_recurso_p;
	UPDATE recursos SET disponible = TRUE WHERE codigo = codigo_recurso_p;
END $$
DELIMITER ;
