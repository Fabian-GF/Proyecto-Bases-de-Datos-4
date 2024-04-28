USE taller2 ;

DELIMITER //
-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE MenuLoanApp()
BEGIN
    DECLARE Menu INT;
	SET Menu =1;
    MenuLoanApp: LOOP
        -- Mostrar opciones del menú
			SELECT '1. Agregar un recurso' AS MenuOption;
			SELECT '2. Agregar un estudiante' AS MenuOption;
			SELECT '3. Prestar un recurso disponible' AS MenuOption;
			SELECT '4. Consultar los prestamos de un estudiante' AS MenuOption;
			SELECT '5. Consultar la informacion de un prestamo' AS MenuOption;
			SELECT '6. Devolver un recurso prestado' AS MenuOption;
			SELECT '0. Salir de la aplicación' AS MenuOption;

		-- Pedir al usuario que elija otra opción
			SELECT 'Ingrese el número de la opción deseada: ' INTO Menu;
			SET Menu = IFNULL(Menu, -1);
                
        -- Ejecutar la opción seleccionada
        CASE Menu
            WHEN 1 THEN 
					/* SENTENCIA */
				SELECT 'A seleccionado la opcion [1]' ;
				SELECT 'Digite que recurso desea agregar';
                
            WHEN 2 THEN
                    /* SENTENCIA */
                    SELECT 'A seleccionado la opcion [2]' ;
                    SELECT 'Digite, nombre del estudiante, codigo, y facultad';
                
           WHEN 3 THEN
					/* SENTENCIA */
                    SELECT 'A seleccionado la opcion [3]' ;
                    SELECT 'Que recurso desea';
                    
			WHEN 4 THEN
                    /* SENTENCIA */
                    SELECT 'A seleccionado la opcion [4]' ;
                    SELECT 'Digite el codigo del estudiante, para saber sus elementos prestados';
					
			WHEN 5 THEN
                    /* SENTENCIA */
                    SELECT 'A seleccionado la opcion [5]' ;
                    SELECT 'Digite que elemento desea buscar';
                    
			WHEN 6 THEN
                    /* SENTENCIA */
                    SELECT 'A seleccionado la opcion [6]' ;
                    SELECT 'Digite el codigo del recurso que desea devolver';
            WHEN 0 THEN
                LEAVE MenuLoanApp;
            ELSE
                SELECT 'Opción no válida. Inténtelo de nuevo.';
        END CASE;
    END LOOP MenuLoanApp;
END //

DELIMITER ;
