USE central_prestamos;

CALL agregar_recurso('Libro 2002'); -- Recibe el nombre del recurso
CALL agregar_estudiante('Cristian', 'Sampayo'); -- Recibe un nombre y un apellido
CALL prestar_recurso(12, 12); -- Recibe un codigo de recurso y un codigo de estudiante
CALL prestamos_estudiante(12); -- Recibe un codigo de estudiante
CALL consultar_prestamo(1); -- Recibe un codigo de prestamo
CALL devolver_recurso(12); -- Recibe un codigo de prestamo


SELECT * FROM estudiantes;
SELECT * FROM prestamos;
SELECT * FROM recursos;

CALL MenuLoanApp;

