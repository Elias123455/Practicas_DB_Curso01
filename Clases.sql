--CREAR UNA TABLA PARA ORACLE
CREATE TABLE Empleado(
ID_Empleado INTEGER PRIMARY KEY,
Nombre VARCHAR2(50),
Puesto VARCHAR2(50),
Sueldo INTEGER);

--VERIFICAR QUE la tabla esta verificada

select * from Empleado

--como eliminar tabla
DROP TABLE Empleado

--como eliiminar tabla con dependencia EJ: Horario tiene dependencia de empleado
DROP TABLE Horarios CASCADE CONSTRAINTS;

--Como agregar datos a una tabla
INSERT INTO Empleado(ID_Empleado,Nombre,Puesto,Sueldo) Values(2,'Maria','UAM','6000');

---Ordenar de mauor a menor
Select *
from Empleado
order by Sueldo desc;

---Ordenar por precio menor a mayor
Select *
from Empleado
order by Sueldo asc;

---Ordenar alfavetcamente
Select *
from Empleado
order by Nombre desc;

Select *
from Empleado
order by Nombre asc;

---Promedio de la columna sueldo
Select avg(Sueldo) as Promedio from Empleado

---Promedio por campo 
select avg(Sueldo) from Empleado where puesto='Analista'

--suma de columnas
select sum(Sueldo) as Analista as TotalSueldo from empleado;

--agregar un campo nuevo a la tabla
ALTER Table Empleado
add Telefono varchar(20)

--agregar registros al campo nuevo
update Empleado
set Telefono='89857445'
where ID_Empleado=1;

--Eliminar columna especifica de la tabla
ALTER TABLE Empl