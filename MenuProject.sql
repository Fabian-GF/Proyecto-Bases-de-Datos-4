USE central_prestamos ;
DROP PROCEDURE IF EXISTS MenuLoanApp;
DELIMITER //
-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE MenuLoanApp()
BEGIN
    DECLARE Menu INT;
    -- Mostrar opciones del menú
			SELECT '1. Agregar un recurso' AS MenuOption;
			SELECT '2. Agregar un estudiante' AS MenuOption;
			SELECT '3. Prestar un recurso disponible' AS MenuOption;
			SELECT '4. Consultar los prestamos de un estudiante' AS MenuOption;
			SELECT '5. Consultar la informacion de un prestamo' AS MenuOption;
			SELECT '6. Devolver un recurso prestado' AS MenuOption;
			SELECT '0. Salir de la aplicación' AS MenuOption;
	SET Menu = 1 ;
    MenuLoanApp: LOOP
        -- Ejecutar la opción seleccionada
        CASE Menu
            WHEN 1 THEN 
				SET @nombre_recurso = 'Libro Yo antes de ti';
                CALL agregar_recurso(@nombre_recurso);
				SELECT 'A seleccionado la opcion [1]' ;
                
            WHEN 2 THEN
				SET @nombre_est = 'Cristian';
				SET @aprellido_est = 'Sampayo';
                CALL agregar_estudiante(@nombre_est, @apellido_est);
				SELECT 'A seleccionado la opcion [2]' ;
                
           WHEN 3 THEN
				SET @cod_recurso = 4;
                SET @cod_estudiante = 10;
                CALL prestar_recurso(@cod_recurso, @cod_estudiante);
				SELECT 'A seleccionado la opcion [3]' ;
                    
			WHEN 4 THEN
				SET @cod_estudiante = 10;
                CALL prestamos_estudiante(@cod_estudiante);
				SELECT 'A seleccionado la opcion [4]' ;
					
			WHEN 5 THEN
				SET @cod_prestamo = 1;
                CALL consultar_prestamo(@cod_prestamo);
				SELECT 'A seleccionado la opcion [5]' ;
				SELECT 'Digite que elemento desea buscar';
                    
			WHEN 6 THEN
				SET @cod_recurso = 4;
                CALL devolver_recurso(@cod_recurso);
				SELECT 'A seleccionado la opcion [6]' ;
				SELECT 'Digite el codigo del recurso que desea devolver';
            WHEN 0 THEN
                LEAVE MenuLoanApp;
            ELSE
                SELECT 'Opción no válida. Inténtelo de nuevo.';
        END CASE;
         SET menu = 0;
    END LOOP MenuLoanApp;
END //

DELIMITER ;
