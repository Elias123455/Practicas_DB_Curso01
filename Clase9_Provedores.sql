Create table Provedores(
id_provedores number (10) primary key not null,
Direccion VARCHAR2 (10) not null,
Nombre_Provedor VARCHAR2(25) not null,
Persona_Contacto VARCHAR2 (30) not null,
Contacto VARCHAR2 (25)not NULL
);

select * from Provedores

Create table Productos(
id_productos number(10) primary key not null,
Cantidad number (10) not null,
Fecha date,
id_provedores number (10) not null,
Nombre_Producto varchar2 (25) not null,
Precio number(10) not null,
CONSTRAINT fk_productos FOREIGN KEY(id_provedores) REFERENCES (id_provedores)
);

select * from Productos

INSERT ALL
INTO Proveedores(Id_Proveedores,Direccion,Nombre_proveedor,persona_contacto,telefono)VALUES (112,'San Jose','IBMD','pepe','25554565')
INTO Proveedores(Id_Proveedores,Direccion,Nombre_proveedor,persona_contacto,telefono)VALUES (113,'Heredia','INTEL','ana','25578565')
INTO Proveedores(Id_Proveedores,Direccion,Nombre_proveedor,persona_contacto,telefono)VALUES (114,'Alajuela','EPA','maria','25554235')
INTO Proveedores(Id_Proveedores,Direccion,Nombre_proveedor,persona_contacto,telefono)VALUES (115,'Cartago','WALTMART','felipe','25884565')
INTO Proveedores(Id_Proveedores,Direccion,Nombre_proveedor,persona_contacto,telefono)VALUES (116,'Limon','Pali','carmen','27754565')
SELECT * FROM dual;
 
INSERT ALL
INTO Productos(Id_Productos,cantidad,fecha,Id_Proveedores,nombre_producto,precio)VALUES(11,25,'12-10-2024',112,'Web',200000)
INTO Productos(Id_Productos,cantidad,fecha,Id_Proveedores,nombre_producto,precio)VALUES(12,30,'11-11-2024',113,'procesadores',400000)
INTO Productos(Id_Productos,cantidad,fecha,Id_Proveedores,nombre_producto,precio)VALUES(13,25,'08-12-2024',114,'puertas',100000)
INTO Productos(Id_Productos,cantidad,fecha,Id_Proveedores,nombre_producto,precio)VALUES(14,40,'27-09-2024',115,'arroz',50000)
INTO Productos(Id_Productos,cantidad,fecha,Id_Proveedores,nombre_producto,precio)VALUES(15,45,'18-07-2024',116,'carne',70000)

SELECT * FROM dual