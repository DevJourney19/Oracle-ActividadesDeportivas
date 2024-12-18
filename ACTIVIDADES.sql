-- Ejercicio #1 

set serveroutput on;
create or replace procedure actualizar_ocupacion(p_codigo_sesion sesion.id%type)

as

cantidad number;
cantidad_inscripcion number;
nombre_actividad actividad.nombre%type;
fecha_actividad sesion.fecha_actividad%type;
cap_max actividad.capacidad_max%type;
begin

select count(id) into cantidad from sesion where id=p_codigo_sesion;

if cantidad = 0 then
dbms_output.put_line('No existe la sesión con código '||p_codigo_sesion);
else 

SELECT count(id) into cantidad_inscripcion from inscripcion where ID_SESION=p_codigo_sesion AND estado='Reservado';

UPDATE sesion set ocupacion=cantidad_inscripcion where id=p_codigo_sesion;

SELECT actividad.nombre, sesion.fecha_actividad, actividad.capacidad_max into nombre_actividad, fecha_actividad, cap_max from sesion INNER JOIN actividad ON sesion.id_actividad=actividad.id 
WHERE sesion.id=p_codigo_sesion;

dbms_output.put_line('La sesion de ' || nombre_actividad || ' ' || fecha_actividad||', con código '||p_codigo_sesion|| ', tiene una ocupación actual de ('||cantidad_inscripcion||'/'||cap_max||')');

end if;
COMMIT;
end actualizar_ocupacion;

--
begin
actualizar_ocupacion(200);
end;

-- CONSULTAS --
select * from ACTIVIDAD;
select * from CLIENTE;
select * from INSCRIPCION;
select * from SESION;


