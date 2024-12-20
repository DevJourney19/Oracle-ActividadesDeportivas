set serveroutput on;
CREATE OR REPLACE trigger insertar_inscripcion
before insert
on inscripcion 

for each row

declare
-- Variables ingresadas como parámetro --
v_estado inscripcion.estado%type:= :new.estado;
v_inscripcion inscripcion.id%type:=:new.id;
-- Variable obtenida por medio de la consulta --
estado_cliente inscripcion.estado%type;
cantidad_id_inscripcion inscripcion.id%type; 
begin

if v_estado = 'Cancelado' then
    dbms_output.put_line('La inscripción a insertar no se ha llevado a cabo, ya que no está en estado Reservado');
    RAISE_APPLICATION_ERROR(-20001, '');
else 
    Select NVL(count(id),0) into cantidad_id_inscripcion from inscripcion where id=v_inscripcion;        
    if cantidad_id_inscripcion <> 0 then
        Select estado into estado_cliente from inscripcion where id=v_inscripcion;
        if estado_cliente= 'Cancelado' then
            dbms_output.put_line('El cliente tenía una reserva en estado Cancelado. Se elimina la reserva anterior. Inscripción realizada.');
            delete from inscripcion where id=v_inscripcion;
        elsif estado_cliente='Reservado' then 
            dbms_output.put_line('El cliente ya tenía una reserva realizada para esa actividad');
            RAISE_APPLICATION_ERROR(-20001, '');
        end if;
    else 
        dbms_output.put_line('Inscripción insertada');
    end if;
end if;
end;

-- Ejecución --
INSERT INTO inscripcion values (13,2,1,SYSDATE,'Cancelado');

-- Consulta --
Select * from inscripcion;