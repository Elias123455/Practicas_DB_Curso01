CREATE TABLE Asignatura (
    Id_asignatura INTEGER PRIMARY KEY,
    Nombre VARCHAR2(25)
);

Create table Inscripcion (
    Id_inscripcion number (10) PRIMARY KEY,
    Id_Asignatura number (25) not null,
    Id_Alumno number (25) not null,
    Id_Profesor number (25) not null,
    Fecha DATE,
    FOREIGN KEY (id_alumno) REFERENCES Alumnos(Id_alumno)
);

Create table Alumnos(
id_alumno number (10) primary key not null,
Nombre VARCHAR2 (25) not null,
Apellido VARCHAR2(25) not null,
Direccion varchar(200) NOT NULL,
Fecha_nacimiento DATE
);

CREATE TABLE Profesor (
    Id_profesor  number (10) primary key not null,
    Nombre VARCHAR2(50),
    Apellido VARCHAR2(50),
    Direccion VARCHAR2(100),
    Fecha_nacimiento DATE,
    Nivel_Academico VARCHAR2(50)
);


select * from Asignatura
select * from Inscripcion
select * from Alumnos
select * from Profesor

IN