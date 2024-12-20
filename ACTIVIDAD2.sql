-- Ejercicio #2 --
/*
Crear una función llamada ​num_sesiones​, donde a partir de un identificador de 
una actividad y un rango de fechas, devuelva el número de sesiones existentes de
dicha actividad comprendidas entre la fecha de inicio y de fin. Parámetros de 
entrada a la función
Hay que tener en cuenta que los parámetros fecha_inicio y fecha_fin son 
opcionales y que el valor por defecto de ambos es la fecha actual del sistema, 
*/
CREATE OR REPLACE FUNCTION num_sesiones (
    p_id_actividad sesion.id_actividad%TYPE,
    p_fecha_inicio IN DATE DEFAULT SYSDATE,
    p_fecha_final IN DATE DEFAULT SYSDATE
) RETURN NUMBER IS
    cantidad_sesiones NUMBER default 0;
BEGIN
   
    SELECT COUNT(*) INTO cantidad_sesiones FROM sesion
    WHERE id_actividad = p_id_actividad AND fecha_actividad 
    BETWEEN p_fecha_inicio AND p_fecha_final;

    RETURN cantidad_sesiones;
END;
--
set serveroutput on;
BEGIN
    dbms_output.put_line('Sesiones "SPI" entre la fecha de 12/04/2023 al 12/05/23');
    dbms_output.put_line(num_sesiones('SPI', to_date('12/04/2023','DD/MM/YYYY'), to_date('12/05/2023','DD/MM/YYYY')));
    dbms_output.put_line('Sesiones "SPI" desde la fecha de comienzo hasta hoy');
    dbms_output.put_line(num_sesiones('SPI', to_date('12/01/2023','DD/MM/YYYY')));
    COMMIT;
END;
/
-- Consulta --
SELECT * FROM SESION;