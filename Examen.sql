
CREATE TABLE Empleadoss(
  N_Empleado NUMBER PRIMARY KEY,
  Nombre VARCHAR2(50),
  Puesto VARCHAR2(50)
);

CREATE TABLE Proyectoss (
  N_Proyecto NUMBER PRIMARY KEY,
  NombreProyecto VARCHAR2(100)
);

CREATE TABLE Asignaciones (
  N_Empleado NUMBER,
  N_Proyecto NUMBER,
  CONSTRAINT PK_Asignaciones PRIMARY KEY (N_Empleado, N_Proyecto),
  CONSTRAINT FK_Empleado_Asignaciones FOREIGN KEY (N_Empleado) REFERENCES Empleadoss(N_Empleado),
  CONSTRAINT FK_Proyecto_Asignaciones FOREIGN KEY (N_Proyecto) REFERENCES Proyectoss(N_Proyecto)
);

SELECT * FROM Empleadoss;
SELECT * FROM Proyectoss;
SELECT * FROM Asignaciones;



INSERT INTO Empleadoss (N_Empleado, Nombre, Puesto)
VALUES (1, 'Pedro Marín', 'Analista'),
       (2, 'Ana Pérez', 'Scrum Master');
SELECT * FROM dual;

INSERT INTO Proyectoss (N_Proyecto, NombreProyecto)VALUES (1, 'Aplicación Web')
  INSERT INTO Proyectoss (N_Proyecto, NombreProyecto)VALUES (2, 'Aplicación Móvil')
    INSERT INTO Proyectoss (N_Proyecto, NombreProyecto)VALUES   (3, 'Diseño UML')
     INSERT INTO Proyectoss (N_Proyecto, NombreProyecto)VALUES  (4, 'Base de datos')
        INSERT INTO Proyectoss (N_Proyecto, NombreProyecto)VALUES  (5, 'API Web')
          INSERT INTO Proyectoss (N_Proyecto, NombreProyecto)VALUES      (6, 'QA')
SELECT * FROM dual;

INSERT INTO Asignaciones (N_Empleado, N_Proyecto)
VALUES (1, 1)
   INSERT INTO Asignaciones (N_Empleado, N_Proyecto) VALUES    (1, 2)
   INSERT INTO Asignaciones (N_Empleado, N_Proyecto) VALUES      (1, 3)
    INSERT INTO Asignaciones (N_Empleado, N_Proyecto) VALUES     (2, 4)
     INSERT INTO Asignaciones (N_Empleado, N_Proyecto) VALUES    (2, 5)
     INSERT INTO Asignaciones (N_Empleado, N_Proyecto) VALUES    (2, 6)
SELECT * FROM dual;

- Seleccionar dos campos de Empleados y Proyectos
SELECT e.Nombre, p.NombreProyecto
FROM Empleados e
INNER JOIN Asignaciones a ON e.N_Empleado = a.N_Empleado
INNER JOIN Proyectos p ON a.N_Proyecto = p.N_Proyecto;


SELECT MIN(N_Empleado) FROM Empleados;


SELECT MAX(N_Proyecto) FROM Proyectos;


SELECT AVG(N_Empleado) FROM Empleados;


UPDATE Empleados SET Puesto = 'Senior Analista' WHERE N_Empleado = 1;
