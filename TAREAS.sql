CREATE TABLE Producto (
    Producto_ID NUMBER not null,
    Cantidad NUMBER,
    Tipo_Producto VARCHAR2(50),
    Num_pedido NUMBER,
    constraint Producto_primary_key primary key(Producto_ID)
);

select * from Producto 

CREATE TABLE Pedido (
    Num_pedido NUMBER (4) not null,
    Cliente_ID NUMBER,
    Nombre_Cliente VARCHAR2(100),
    Ciudad VARCHAR2(100),
    Fecha_envio DATE,
   Producto_ID number (3) not null
);

select * from Producto

CREATE TABLE Cliente (
    Cliente_ID NUMBER PRIMARY KEY,
    Nombre VARCHAR2(50),
    Apellido VARCHAR2(50),
    Ciudad VARCHAR2(100),
    Telefono VARCHAR2(20)
);

alter table Cliente 
add constraint Cliente_pk
primary key (Cliente_ID);

select * from empleado;

SELECT * FROM Cliente


INSERT INTO Cliente VALUES (10,'Ana','Aguilar','TEXAS','123');
INSERT INTO Cliente VALUES (20,'Juan','Gonzalez','DALLAS','456');
INSERT INTO Cliente VALUES (30,'Vale','Aguero','CHICAGO','789');
INSERT INTO Cliente VALUES (40,'Pepe','Sierra','BOSTON','852');


INSERT INTO Producto  VALUES (783,9,'Pan',,5000);
INSERT INTO Producto  VALUES (769,8,'Arina',7839,);
INSERT INTO Producto  VALUES (752,6,'Arroz',,5656);
INSERT INTO Producto  VALUES (765,7,'Frijoles',3215);

INSERT INTO Producto  VALUES (783,9,'Pan',,5000);
INSERT INTO Producto  VALUES (769,8,'Arina',7839,);

--seleccione el nombre, puesto, salario de empleadostiene puesto cleark,analist
--y si salario no es $1000,$3000,$5000, ordena por salario
select Tipo_Producto,Num_pedido,Cantidad
from Producto
where job in('clerk','analist')
and Cantidad not in(1000,3000,5000)
order by 3;

--seleccione el salario maximo y minimo por ccada puesto
select Tipo_Producto "Producto", max(Cantidad) " Cantidad maxima ",min(Cantidad) "Cantidad minima"
from Producto
group by joborder by 1;

