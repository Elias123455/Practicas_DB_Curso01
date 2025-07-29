-- crear una base de datos
CREATE DATABASE Prueba_1
GO
-- ubicarse sobre la base de datos deseada
USE Prueba_1
GO
-- crear tablas con sus columnas
CREATE TABLE Proveedores
(	Id_Proveedor tinyint PRIMARY KEY NOT NULL,
    Direccion varchar(200) NOT NULL,
    Nom_Proveedor varchar(25) NOT NULL,
    Persona_Contacto varchar(100) NOT NULL,
	Telefonos varchar(50) NOT NULL	
	)

CREATE TABLE Productos
(	Id_Producto int PRIMARY KEY NOT NULL,
    Cantidad real NOT NULL,
	Fecha_Ult_Compra smalldatetime NOT NULL,
	Id_Proveedor tinyint NOT NULL,
    Nom_Producto varchar(25) NOT NULL,
    Precio money NOT NULL
	CONSTRAINT FK_Productos_Proveedores FOREIGN KEY (Id_Proveedor) 
    REFERENCES Proveedores (Id_Proveedor) 
	)

