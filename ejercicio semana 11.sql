CREATE TABLE Departamento (
    codDepto INT PRIMARY KEY,
    nombreDpto VARCHAR(50),
    ciudad VARCHAR(50),
    director VARCHAR(20) -- Hace referencia a Empleado.nDIEmp, pero primero se crea sin FK
);

CREATE TABLE Empleado (
    nDIEmp VARCHAR(20) PRIMARY KEY,
    nomEmp VARCHAR(100),
    sexEmp CHAR(1),
    fecNac DATE,
    fecIncorporacion DATE,
    salEmp DECIMAL(12,2),
    comisionE DECIMAL(12,2),
    cargoE VARCHAR(50),
    jefeID VARCHAR(20),
    codDepto INT,
    FOREIGN KEY (codDepto) REFERENCES Departamento(codDepto),
    FOREIGN KEY (jefeID) REFERENCES Empleado(nDIEmp)
);

-- Ahora sí, agregamos la FK del director (autorreferencia hacia Empleado):
ALTER TABLE Departamento
ADD CONSTRAINT fk_director FOREIGN KEY (director) REFERENCES Empleado(nDIEmp);

--inserts de los datos

INSERT INTO Departamento (codDepto, nombreDpto, ciudad, director) VALUES
(1000, 'GERENCIA', 'CALI', '31840269'),
(1500, 'PRODUCCIÓN', 'CALI', '16211383'),
(2000, 'VENTAS', 'CALI', '31178144'),
(3000, 'INVESTIGACIÓN', 'CALI', '16759060'),
(3500, 'MERCADEO', 'CALI', '22222222'),
(2100, 'VENTAS', 'POPAYAN', '31751219'),
(2200, 'VENTAS', 'BUGA', '768782'),
(2300, 'VENTAS', 'CARTAGO', '737689'),
(4000, 'MANTENIMIENTO', 'CALI', '333333333'),
(4100, 'MANTENIMIENTO', 'POPAYAN', '888888'),
(4200, 'MANTENIMIENTO', 'BUGA', '11111111'),
(4300, 'MANTENIMIENTO', 'CARTAGO', '444444');

--se agregó fecha al formato

INSERT INTO Empleado (nDIEmp, nomEmp, sexEmp, fecNac, fecIncorporacion, salEmp, comisionE, cargoE, jefeID, codDepto) VALUES
('31840269', 'María Rojas', 'F', TO_DATE('1959-01-15', 'YYYY-MM-DD'), TO_DATE('1990-05-16', 'YYYY-MM-DD'), 6250000, 1500000, 'Gerente', NULL, 1000),
('16211383', 'Luis Pérez', 'M', TO_DATE('1956-02-25', 'YYYY-MM-DD'), TO_DATE('2000-01-01', 'YYYY-MM-DD'), 5050000, 0, 'Director', '31840269', 1500),
('31178144', 'Rosa Angulo', 'F', TO_DATE('1957-03-15', 'YYYY-MM-DD'), TO_DATE('1998-08-16', 'YYYY-MM-DD'), 3250000, 3500000, 'Jefe Ventas', '31840269', 2000),
('16759060', 'Darío Casas', 'M', TO_DATE('1960-04-05', 'YYYY-MM-DD'), TO_DATE('1992-11-01', 'YYYY-MM-DD'), 4500000, 500000, 'Investigador', '31840269', 3000),
('22222222', 'Carla López', 'F', TO_DATE('1975-05-11', 'YYYY-MM-DD'), TO_DATE('2005-07-16', 'YYYY-MM-DD'), 4500000, 500000, 'Jefe Mercadeo', '31840269', 3500),
('1751219', 'Melissa Roa', 'F', TO_DATE('1960-06-19', 'YYYY-MM-DD'), TO_DATE('2001-03-16', 'YYYY-MM-DD'), 2250000, 2500000, 'Vendedor', '31178144', 2100),
('768782', 'Joaquín Rosas', 'M', TO_DATE('1947-07-07', 'YYYY-MM-DD'), TO_DATE('1990-05-16', 'YYYY-MM-DD'), 2250000, 2500000, 'Vendedor', '31178144', 2200),
('737689', 'Mario Llano', 'M', TO_DATE('1945-08-30', 'YYYY-MM-DD'), TO_DATE('1990-05-16', 'YYYY-MM-DD'), 2250000, 2500000, 'Vendedor', '31178144', 2300),
('333333333', 'Elisa Rojas', 'F', TO_DATE('1979-09-28', 'YYYY-MM-DD'), TO_DATE('2004-06-01', 'YYYY-MM-DD'), 3000000, 1000000, 'Jefe Mecánicos', '31840269', 4000),
('888888', 'Iván Duarte', 'M', TO_DATE('1955-08-12', 'YYYY-MM-DD'), TO_DATE('1998-05-16', 'YYYY-MM-DD'), 1050000, 200000, 'Mecánico', '333333333', 4100),
('11111111', 'Irene Díaz', 'F', TO_DATE('1979-09-28', 'YYYY-MM-DD'), TO_DATE('2004-06-01', 'YYYY-MM-DD'), 1050000, 200000, 'Mecánico', '333333333', 4200),
('444444', 'Abel Gómez', 'M', TO_DATE('1939-12-24', 'YYYY-MM-DD'), TO_DATE('2000-10-01', 'YYYY-MM-DD'), 1050000, 200000, 'Mecánico', '333333333', 4300),
('1130222', 'José Giraldo', 'M', TO_DATE('1985-01-20', 'YYYY-MM-DD'), TO_DATE('2000-11-01', 'YYYY-MM-DD'), 1200000, 400000, 'Asesor', '22222222', 3500),
('19709802', 'William Daza', 'M', TO_DATE('1982-10-09', 'YYYY-MM-DD'), TO_DATE('1999-12-16', 'YYYY-MM-DD'), 2250000, 1000000, 'Investigador', '16759060', 3000),
('31174099', 'Diana Solarte', 'F', TO_DATE('1957-11-19', 'YYYY-MM-DD'), TO_DATE('1990-05-16', 'YYYY-MM-DD'), 1250000, 500000, 'Secretaria', '31840269', 1000),
('1130777', 'Marcos Cortez', 'M', TO_DATE('1986-06-23', 'YYYY-MM-DD'), TO_DATE('2000-04-16', 'YYYY-MM-DD'), 2550000, 500000, 'Mecánico', '333333333', 4000),
('1130782', 'Antonio Gil', 'M', TO_DATE('1980-01-23', 'YYYY-MM-DD'), TO_DATE('2010-04-16', 'YYYY-MM-DD'), 850000, 1500000, 'Técnico', '16211383', 1500),
('333333334', 'Marisol Pulido', 'F', TO_DATE('1979-10-01', 'YYYY-MM-DD'), TO_DATE('1990-05-16', 'YYYY-MM-DD'), 3250000, 1000000, 'Investigador', '16759060', 3000),
('333333335', 'Ana Moreno', 'F', TO_DATE('1992-01-05', 'YYYY-MM-DD'), TO_DATE('2004-06-01', 'YYYY-MM-DD'), 1200000, 400000, 'Secretaria', '16759060', 3000),
('1130333', 'Pedro Blanco', 'M', TO_DATE('1987-10-28', 'YYYY-MM-DD'), TO_DATE('2000-10-01', 'YYYY-MM-DD'), 800000, 3000000, 'Vendedor', '31178144', 2000),
('1130444', 'Jesús Alfonso', 'M', TO_DATE('1988-03-14', 'YYYY-MM-DD'), TO_DATE('2000-10-01', 'YYYY-MM-DD'), 800000, 3500000, 'Vendedor', '31178144', 2000),
('333333336', 'Carolina Ríos', 'F', TO_DATE('1992-02-15', 'YYYY-MM-DD'), TO_DATE('2000-10-01', 'YYYY-MM-DD'), 1250000, 500000, 'Secretaria', '16211383', 1500),
('333333337', 'Edith Muñoz', 'F', TO_DATE('1992-03-31', 'YYYY-MM-DD'), TO_DATE('2000-10-01', 'YYYY-MM-DD'), 800000, 3600000, 'Vendedor', '31178144', 2100),
('1130555', 'Julián Mora', 'M', TO_DATE('1989-07-03', 'YYYY-MM-DD'), TO_DATE('2000-10-01', 'YYYY-MM-DD'), 800000, 3100000, 'Vendedor', '31178144', 2200),
('1130666', 'Manuel Millán', 'M', TO_DATE('1990-12-08', 'YYYY-MM-DD'), TO_DATE('2004-06-01', 'YYYY-MM-DD'), 800000, 3700000, 'Vendedor', '31178144', 2300);



-- Cambiar el salario de un empleado
UPDATE Empleado
SET salEmp = 7000000
WHERE nDIEmp = '31840269';


-- Eliminar un empleado específico
DELETE FROM Empleado
WHERE nDIEmp = '31840269';

-- Eliminar un departamento (asegúrate que no tenga empleados asignados)
DELETE FROM Departamento
WHERE codDepto = 1000;


--a. Nombre del departamento, suma de salarios y nombre del jefe
SELECT d.nombreDpto, SUM(e.salEmp) AS suma_salarios, j.nomEmp AS jefe
FROM Departamento d
JOIN Empleado e ON d.codDepto = e.codDepto
JOIN Empleado j ON d.director = j.nDIEmp
GROUP BY d.nombreDpto, j.nomEmp
ORDER BY suma_salarios ASC;


--b. Mostrar todos los departamentos
SELECT * FROM Departamento;

--c. Salario promedio por departamento (>900000 y <575000)
SELECT codDepto, AVG(salEmp) AS salario_promedio
FROM Empleado
WHERE salEmp > 900000 OR salEmp < 575000
GROUP BY codDepto
ORDER BY salario_promedio DESC;


--d. Salario más alto, más bajo y diferencia
SELECT 
    MAX(salEmp) AS salario_mas_alto,
    MIN(salEmp) AS salario_mas_bajo,
    MAX(salEmp) - MIN(salEmp) AS diferencia
FROM Empleado;

--e. Lista de empleados que son jefes
SELECT DISTINCT e.nomEmp
FROM Empleado e
WHERE e.nDIEmp IN (
    SELECT jefeID FROM Empleado WHERE jefeID IS NOT NULL
)
ORDER BY e.nomEmp ASC;


