set serveroutput on;
create or replace procedure info_cliente(p_dni_cliente in cliente.dni%type)
as
cantidad_cliente number;

v_id_cliente cliente.id%type;
v_nombre cliente.nombre%type;
v_apellidos cliente.apellidos%type;
total actividad.coste%type default 0;

cursor cliente_infoo is 
select actividad.nombre as actividad, sesion.fecha_actividad as fecha_actividad, 
actividad.coste as coste from inscripcion INNER JOIN sesion on 
inscripcion.id_sesion=sesion.id INNER JOIN actividad on 
sesion.id_actividad=actividad.id where id_cliente=v_id_cliente and 
estado='Reservado' order by fecha_inscripcion desc;

begin

Select count(cliente.id) into cantidad_cliente from cliente where dni=p_dni_cliente;
Select id, nombre, apellidos into v_id_cliente, v_nombre, v_apellidos from cliente where dni=p_dni_cliente;
--Total--
select NVL(sum(actividad.coste),0) into total from inscripcion INNER JOIN sesion on 
inscripcion.id_sesion=sesion.id INNER JOIN actividad on 
sesion.id_actividad=actividad.id where id_cliente=v_id_cliente and 
estado='Reservado';

if cantidad_cliente > 0 then
dbms_output.put_line('El cliente "'|| v_nombre ||' '||v_apellidos||'" ha realizado las siguientes actividades');
dbms_output.put_line('');
--Listado--
dbms_output.put_line(RPAD('Actividad',12,' ')||RPAD('Fecha actividad',18,' ')||'Coste');
dbms_output.put_line('------------------------------------');
for r in cliente_infoo loop
    dbms_output.put_line(RPAD(r.actividad,10, ' ')||'  '|| RPAD(r.fecha_actividad,18,' ')||LPAD((r.coste||'€'),3,' '));
end loop;

end if;
dbms_output.put_line('------------------------------------');
dbms_output.put_line('Total: '||total||'€');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe cliente con el DNI '||p_dni_cliente);
        
COMMIT;
end info_cliente;
/
-- Ejecución --
begin
info_cliente('06349006V');
end;

desc cliente;

-- Consultas --
Select * from sesion;
Select * from inscripcion;
Select * from actividad;
Select * from cliente;