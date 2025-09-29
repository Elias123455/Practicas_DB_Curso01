--Creación de las tablas de Royal Eventos - DDL


-- Tabla Cliente
CREATE TABLE Cliente (
    idCliente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, --se genera con autoincremento
    cedula INT NOT NULL,
    nombreCliente VARCHAR2(100) NOT NULL,
    correo VARCHAR2(100),
    telefono VARCHAR2(15),
    direccion VARCHAR2(100),
    fecha DATE DEFAULT SYSDATE,  --fecha del sistema
    nota VARCHAR2(1000)
);

-- Tabla Locacion
CREATE TABLE Locacion (
    idLocacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombreLocacion VARCHAR2(100) NOT NULL,
    ubicacion VARCHAR2(100),
    contacto VARCHAR2(100),
    telefono VARCHAR2(15),
    correo VARCHAR2(100),
    tipo VARCHAR2(100),
    horario VARCHAR2(15)
);

-- Tabla Evento
CREATE TABLE Evento (
    idEvento INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipoEvento VARCHAR2(30),
    cantidadInvitados INT,
    presupuestoCotizado DECIMAL(10,2) DEFAULT 0.00,
    presupuestoFinal DECIMAL(10,2),
    estado VARCHAR2(20),
    fechaEvento DATE,
    idCliente INT NOT NULL,
    idLocacion INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idLocacion) REFERENCES Locacion(idLocacion)
);

-- Tabla Proveedor
CREATE TABLE Proveedor (
    idProveedor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombreProveedor VARCHAR2(100) NOT NULL,
    tipoProveedor VARCHAR2(100),
    ubicacion VARCHAR2(100),
    contacto VARCHAR2(100),
    correo VARCHAR2(100),
    telefono VARCHAR2(15),
    horario VARCHAR2(15),
    tipoServicio VARCHAR2(1000)
);

-- Tabla Staff
CREATE TABLE Staff (
    idStaff INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cedula INT NOT NULL,
    nombreStaff VARCHAR2(100) NOT NULL,
    correo VARCHAR2(100),
    telefono VARCHAR2(15),
    direccion VARCHAR2(100),
    rol VARCHAR2(100)
);

-- Tabla Pagos
CREATE TABLE Pagos (
    idPago INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipoPago SMALLINT CHECK (tipoPago IN (1, 2)), -- 1: Pago Cliente, 2: Pago Proveedor (aunque no se va a usar pago a proveedor por el momento
    saldo DECIMAL(10,2),
    montoPago DECIMAL(10,2),
    fechaPago DATE,
    idEvento INT NOT NULL,
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento)
);


-- Relación Evento-Proveedor 
CREATE TABLE Evento_Proveedor (
    idEvento INT,
    idProveedor INT,
    PRIMARY KEY (idEvento, idProveedor),
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento),
    FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
);

-- Relación Evento-Staff
CREATE TABLE Evento_Staff (
    idEvento INT,
    idStaff INT,
    PRIMARY KEY (idEvento, idStaff),
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento),
    FOREIGN KEY (idStaff) REFERENCES Staff(idStaff)
);

--inserts de las tablas

-- CLIENTE

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (101230123, 'Ana Rodríguez', 'ana.r@mail.com', '+50687234567', 'San José, Rohrmoser', TO_DATE('2025-06-05','YYYY-MM-DD'), 'Vegetariana');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (102340234, 'Luis Morales', 'luis.m@mail.com', '+50683457892', 'Alajuela, El Coyol', TO_DATE('2025-06-07','YYYY-MM-DD'), 'Alergia a frutos secos');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (103450345, 'Carmen Rojas', 'carmen.r@mail.com', '+50684561234', 'Cartago, Tres Ríos', TO_DATE('2025-06-09','YYYY-MM-DD'), 'Prefiere música suave');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (104560456, 'Jorge Herrera', 'jorge.h@mail.com', '+50685673456', 'Heredia, Barva', TO_DATE('2025-06-12','YYYY-MM-DD'), 'Evento en exterior');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (105670567, 'Marcela Jiménez', 'marcela.j@mail.com', '+50686784567', 'Limón, centro', TO_DATE('2025-06-13','YYYY-MM-DD'), 'Solicita pista LED');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (106780678, 'Daniela Ramírez', 'daniela.r@mail.com', '+50687895678', 'Puntarenas, El Roble', TO_DATE('2025-06-14','YYYY-MM-DD'), 'Mesa presidencial decorada');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (107890789, 'José Vargas', 'jose.v@mail.com', '+50688906789', 'San José, Sabana', TO_DATE('2025-06-15','YYYY-MM-DD'), 'Música en vivo');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (108901890, 'Laura Salas', 'laura.s@mail.com', '+50689017890', 'Cartago, Paraíso', TO_DATE('2025-06-16','YYYY-MM-DD'), 'Coctelería especial');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (109012901, 'Andrés Chacón', 'andres.c@mail.com', '+50690128901', 'Alajuela, Grecia', TO_DATE('2025-06-17','YYYY-MM-DD'), 'Incluye photo booth');

INSERT INTO Cliente (cedula, nombreCliente, correo, telefono, direccion, fecha, nota)
VALUES (110123012, 'Paola González', 'paola.g@mail.com', '+50691239012', 'Heredia, Santo Domingo', TO_DATE('2025-06-18','YYYY-MM-DD'), 'Intolerancia a lactosa');

-- LOCACION

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Salón Real', 'San José, Escazú', 'David Porras', '+50684123456', 'salonreal@mail.com', 'Salón de eventos', '08:00-22:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Finca Luna', 'Alajuela, La Garita', 'Marcela Gamboa', '+50685234567', 'fincaluna@mail.com', 'Finca', '07:00-20:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Hotel Paraíso', 'Puntarenas, Quepos', 'Lorena Vargas', '+50686345678', 'hotelparaiso@mail.com', 'Hotel', '06:00-00:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Club Tropical', 'Limón, Cahuita', 'Luis Solís', '+50687456789', 'clubtropical@mail.com', 'Club', '10:00-02:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Rancho Verde', 'Cartago, Turrialba', 'Melvin Castillo', '+50688567890', 'ranchoverde@mail.com', 'Finca', '09:00-21:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Salón Elite', 'Heredia, Belén', 'Carlos Méndez', '+50689678901', 'salonelite@mail.com', 'Salón de eventos', '08:00-00:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Resort Bahía', 'Guanacaste, Tamarindo', 'Eva Quesada', '+50680789012', 'resortbahia@mail.com', 'Hotel', '07:00-23:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Hacienda Nube', 'San José, Ciudad Colón', 'Julia Navarro', '+50681890123', 'haciendanube@mail.com', 'Finca', '08:00-20:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Centro Escénico', 'San José, Desamparados', 'Mauricio Céspedes', '+50682901234', 'centroescenico@mail.com', 'Salón de eventos', '09:00-21:00');

INSERT INTO Locacion (nombreLocacion, ubicacion, contacto, telefono, correo, tipo, horario)
VALUES ('Estancia Viva', 'Cartago, Oreamuno', 'Tania León', '+50683012345', 'estanciaviva@mail.com', 'Finca', '06:00-22:00');

-- STAFF
INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (401110111, 'Adriana Ballestero', 'adriana@mail.com', '+50684789123', 'San José, Zapote', 'Event Planner');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (402220222, 'Fernanda Gómez', 'fernanda.g@mail.com', '+50685891234', 'Heredia, San Isidro', 'Asistente');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (403330333, 'Mario Díaz', 'mario.d@mail.com', '+50686992345', 'Alajuela, Naranjo', 'Seguridad');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (404440444, 'Sofía Castro', 'sofia.c@mail.com', '+50687003456', 'Cartago, El Guarco', 'Chofer');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (405550555, 'Rodrigo Salazar', 'rodrigo.s@mail.com', '+50688114567', 'San José, Curridabat', 'Maestro de Ceremonias');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (406660666, 'Vanessa Pineda', 'vanessa.p@mail.com', '+50689225678', 'Limón, Batán', 'Wedding Planner');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (407770777, 'Esteban Cordero', 'esteban.c@mail.com', '+50680336789', 'Puntarenas, Chacarita', 'Asistente');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (408880888, 'Natalia Ramírez', 'natalia.r@mail.com', '+50681447890', 'Heredia, La Aurora', 'Coordinadora');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (409990999, 'Miguel Fonseca', 'miguel.f@mail.com', '+50682558901', 'Alajuela, Palmares', 'Chofer');

INSERT INTO Staff (cedula, nombreStaff, correo, telefono, direccion, rol)
VALUES (410101010, 'Karen Leiva', 'karen.l@mail.com', '+50683669012', 'Cartago, Cervantes', 'Decoradora');


-- PROVEEDOR

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Floristería Rosas y Sol', 'Floristería', 'San José, Escazú', 'Esteban Mora', 'contacto@rosasysol.com', '+50684756789', '09:00-18:00', 'Decoración floral');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Sonido Total', 'Sonido', 'Alajuela, Centro', 'Andrea López', 'andrea@sonidototal.com', '+50685867890', '08:00-22:00', 'Sonido profesional');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Catering Delicias', 'Catering', 'Cartago, San Nicolás', 'Carlos Chaves', 'info@deliciascr.com', '+50686978901', '06:00-20:00', 'Buffet completo');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Luces Infinity', 'Iluminación', 'Heredia, Ulloa', 'María Soto', 'msoto@infinity.com', '+50687089012', '10:00-23:00', 'Luces decorativas');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('PhotoBooth CR', 'Fotografía / Video', 'San José, Moravia', 'Pablo Méndez', 'pmendez@photoboothcr.com', '+50688190123', '12:00-00:00', 'Photo booth interactivo');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Música Latina', 'DJ', 'Puntarenas, Monteverde', 'Javier León', 'javier@musicalatina.com', '+50689201234', '07:00-01:00', 'DJ y animación');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Coctelería Mix', 'Coctelería', 'Limón, Guápiles', 'Monserrat Hidalgo', 'contacto@mixcocteles.com', '+50680312345', '14:00-02:00', 'Cócteles temáticos');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Maquillarte', 'Maquillista', 'Heredia, San Pablo', 'Lucía Reyes', 'lucia@maquillarte.com', '+50681423456', '08:00-17:00', 'Maquillaje profesional');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Vestuario Gala', 'Vestuario', 'San José, Pavas', 'Katherine Jiménez', 'kjimenez@vestuariogala.com', '+50682534567', '09:00-19:00', 'Vestuario para eventos');

INSERT INTO Proveedor (nombreProveedor, tipoProveedor, ubicacion, contacto, correo, telefono, horario, tipoServicio)
VALUES ('Transporte Ágil', 'Transporte', 'Cartago, centro', 'Pedro Rivera', 'pedro@transporteagil.com', '+50683645678', '06:00-22:00', 'Transporte ejecutivo');


-- EVENTO
INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Social', 150, 4500000.00, 4800000.00, 'Cotizado', TO_DATE('2025-08-10','YYYY-MM-DD'), 1, 1);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Corporativo', 80, 3000000.00, 3200000.00, 'Aprobado', TO_DATE('2025-08-12','YYYY-MM-DD'), 2, 2);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Social', 200, 7500000.00, 7800000.00, 'Realizado', TO_DATE('2025-07-18','YYYY-MM-DD'), 3, 3);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Social', 50, 12000000.00, 13000000.00, 'Cotizado', TO_DATE('2025-08-01','YYYY-MM-DD'), 4, 4);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Corporativo', 500, 18000000.00, 18500000.00, 'Aprobado', TO_DATE('2025-07-25','YYYY-MM-DD'), 5, 5);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Social', 100, 3800000.00, 4000000.00, 'Realizado', TO_DATE('2025-07-30','YYYY-MM-DD'), 6, 6);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Social', 300, 9500000.00, 9700000.00, 'Cotizado', TO_DATE('2025-08-15','YYYY-MM-DD'), 7, 7);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Corporativo', 60, 2100000.00, 2300000.00, 'Aprobado', TO_DATE('2025-07-20','YYYY-MM-DD'), 8, 8);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Social', 120, 4300000.00, 4500000.00, 'Cotizado', TO_DATE('2025-08-05','YYYY-MM-DD'), 9, 9);

INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
VALUES ('Social', 90, 2500000.00, 2600000.00, 'Realizado', TO_DATE('2025-07-28','YYYY-MM-DD'), 10, 10);


-- PAGOS
INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 1000000.00, 3800000.00, TO_DATE('2025-08-01','YYYY-MM-DD'), 1);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 200000.00, 3000000.00, TO_DATE('2025-08-03','YYYY-MM-DD'), 2);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 500000.00, 7300000.00, TO_DATE('2025-08-04','YYYY-MM-DD'), 3);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 3000000.00, 10000000.00, TO_DATE('2025-08-12','YYYY-MM-DD'), 4);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 3500000.00, 15000000.00, TO_DATE('2025-08-13','YYYY-MM-DD'), 5);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 1000000.00, 3000000.00, TO_DATE('2025-08-14','YYYY-MM-DD'), 6);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 2000000.00, 7700000.00, TO_DATE('2025-08-15','YYYY-MM-DD'), 7);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 1300000.00, 1000000.00, TO_DATE('2025-08-16','YYYY-MM-DD'), 8);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 1500000.00, 3000000.00, TO_DATE('2025-08-17','YYYY-MM-DD'), 9);

INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
VALUES (1, 600000.00, 2000000.00, TO_DATE('2025-08-18','YYYY-MM-DD'), 10);



-- EVENTO_PROVEEDOR
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (1, 1);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (1, 3);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (2, 2);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (2, 4);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (3, 1);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (3, 3);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (3, 5);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (4, 1);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (4, 3);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (5, 2);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (5, 4);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (5, 6);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (6, 3);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (6, 7);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (7, 1);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (7, 4);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (8, 2);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (8, 6);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (9, 1);
INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (9, 3);

INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (10, 5);



-- EVENTO_STAFF
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (1, 1);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (1, 2);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (2, 6);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (2, 7);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (3, 1);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (3, 3);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (3, 5);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (4, 2);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (4, 10);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (5, 8);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (5, 4);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (5, 3);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (6, 1);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (6, 9);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (7, 6);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (7, 10);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (8, 7);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (8, 4);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (9, 2);
INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (9, 5);

INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (10, 8);
---------------------------------------------------------------------------------------------------
--segundo script
-- ========= INICIO: SCRIPT DE INSERCIÓN MASIVA (CORREGIDO) =========

BEGIN
    -- Insertar 50 eventos nuevos
    FOR i IN 1..50 LOOP
        INSERT INTO Evento (tipoEvento, cantidadInvitados, presupuestoCotizado, presupuestoFinal, estado, fechaEvento, idCliente, idLocacion)
        VALUES (
            CASE WHEN MOD(i, 3) = 0 THEN 'Corporativo' ELSE 'Social' END,
            ROUND(DBMS_RANDOM.VALUE(30, 500)),
            ROUND(DBMS_RANDOM.VALUE(1000000, 20000000), 2),
            NULL,
            CASE WHEN MOD(i, 4) = 0 THEN 'Realizado' WHEN MOD(i, 4) = 1 THEN 'Aprobado' ELSE 'Cotizado' END,
            TO_DATE('2025-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 364)),
            ROUND(DBMS_RANDOM.VALUE(1, 10)),
            ROUND(DBMS_RANDOM.VALUE(1, 10))
        );
    END LOOP;
    
    -- Insertar un pago para cada evento que aún no tenga uno (LÓGICA CORREGIDA)
    FOR rec IN (
        SELECT e.idEvento FROM Evento e WHERE NOT EXISTS (SELECT 1 FROM Pagos p WHERE p.idEvento = e.idEvento)
    ) LOOP
        INSERT INTO Pagos (tipoPago, saldo, montoPago, fechaPago, idEvento)
        VALUES (
            1,
            ROUND(DBMS_RANDOM.VALUE(500000, 2000000), 2),
            ROUND(DBMS_RANDOM.VALUE(1000000, 5000000), 2),
            TO_DATE('2025-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 364)),
            rec.idEvento
        );
    END LOOP;

    -- Asignar proveedores y staff aleatoriamente a los eventos
    FOR rec IN (SELECT idEvento FROM Evento) LOOP
        FOR i IN 1..ROUND(DBMS_RANDOM.VALUE(1, 3)) LOOP
            BEGIN
                INSERT INTO Evento_Proveedor (idEvento, idProveedor) VALUES (rec.idEvento, ROUND(DBMS_RANDOM.VALUE(1, 10)));
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN NULL;
            END;
        END LOOP;
        
        FOR i IN 1..ROUND(DBMS_RANDOM.VALUE(2, 4)) LOOP
            BEGIN
                INSERT INTO Evento_Staff (idEvento, idStaff) VALUES (rec.idEvento, ROUND(DBMS_RANDOM.VALUE(1, 10)));
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN NULL;
            END;
        END LOOP;
    END LOOP;
    
    COMMIT;
END;
/

PROMPT ¡50 nuevos eventos con sus detalles han sido insertados correctamente!;


----------------------------------------------------------------------------------------------------

--consultas

-- Cliente, evento y tipo de pago del evento con saldo pendiente
SELECT  
    c.idCliente,
    c.nombreCliente AS Cliente,
    e.idEvento  AS "ID Evento" ,
    e.tipoEvento AS "Tipo Evento",
    e.fechaEvento AS "Fecha Evento",
    e.estado AS "Estado Evento",
    p.idPago AS "ID Pago",
    p.montoPago AS "Monto Pago",
    p.saldo AS "Saldo Pendiente",
    p.fechaPago AS "Fecha Pago"
FROM  
    Cliente c
JOIN  
    Evento e ON c.idCliente = e.idCliente
LEFT JOIN  
    Pagos p ON e.idEvento = p.idEvento
WHERE  
    p.tipoPago = 1
ORDER BY  
    c.nombreCliente asc;


--evento que tenga el nombre del cliente, la locacion, el staff y el proveedor
SELECT 
    e.idEvento,
    c.nombreCliente AS Cliente,
    l.nombreLocacion AS Locacion,
    s.nombreStaff AS Staff,
    p.nombreProveedor AS Proveedor
FROM Evento e
JOIN Cliente c ON e.idCliente = c.idCliente
JOIN Locacion l ON e.idLocacion = l.idLocacion
LEFT JOIN Evento_Staff es ON e.idEvento = es.idEvento
LEFT JOIN Staff s ON es.idStaff = s.idStaff
LEFT JOIN Evento_Proveedor ep ON e.idEvento = ep.idEvento
LEFT JOIN Proveedor p ON ep.idProveedor = p.idProveedor
ORDER BY e.idEvento;

--consulta de pagos a eventos con saldo y nombre del cliente
SELECT 
    p.idPago,
    p.montoPago,
    p.fechaPago,
    p.saldo,
    c.nombreCliente,
    e.tipoEvento
FROM Pagos p
JOIN Evento e ON p.idEvento = e.idEvento
JOIN Cliente c ON e.idCliente = c.idCliente;

select * from Cliente;
select * from evento;

--Practica
select 'El cliente: '||nombreCliente || ' presenta la condicion: ' || nota,fecha as "Descripcion_Cliente" 
from Cliente
where fecha > SYSDATE -6;

select 'El cliente: '||nombreCliente || ' presenta la condicion: ' || nota || ' registro: ' || fecha as "Descripcion Cliente" 
from Cliente
where fecha 
between to_date('01-06-2025', 'dd-mm-yyyy') and to_date('30-06-2025', 'dd-mm-yyyy');

select 
    'El tipo de evento: '|| tipoEvento || ', tiene ' || cantidadInvitados ||' invitados, por lo cual es: '|| 
    case 
      when cantidadInvitados < 100 then 'pequeño'
      when cantidadInvitados >= 100 and cantidadInvitados < 250 then 'mediano'
      else 'grande' 
   end as tamaño_evento 
from evento;

--order by
select idEvento||' - '|| 
tipoEvento||' - '||
cantidadInvitados "ID  -  Evento  -  Cantidad de invitados"
from evento
order by cantidadInvitados desc ;

select 'Cliente: ' || c.nombreCliente || ' - Evento: ' || e.tipoEvento || ' - Cotizacion: ' 
|| e.presupuestoCotizado || ' - Locacion: ' || l.nombreLocacion || ' - Estado: ' || e.estado ||
case 
  when e.presupuestoCotizado > 5000000 then ' Premiun'
  when e.presupuestoCotizado < 5000000 and e.presupuestoCotizado >= 2000000 then ' Estandar'
  when e.presupuestoCotizado < 2000000 then ' Economico' end as "Reporte: Eventos Sociales Pendientes"
from Cliente c
inner join Evento e on c.idCliente = e.idCliente
inner join Locacion l on e.idLocacion = l.idLocacion
where e.tipoEvento in 'Social' 
and  e.estado in ('Cotizado' , 'Aprobado' )
order by e.presupuestoCotizado desc;

--group by
SELECT
   ' Evento: ' || tipoEvento || ' - cantidad: ' ||
    COUNT(*) AS "Cuantos Eventos Hay"
FROM
    Evento
GROUP BY
    tipoEvento;
    
    
--having
select tipoEvento,
AVG(presupuestoCotizado) as "Evento cotizacion"
from Evento
group by tipoEvento
having AVG(presupuestoCotizado) > 4000000;


-- Tu consulta aquí (JOIN PAGOS y CLIENTE, GROUP BY nombre de cliente, COUNT de pagos)
select 
c.nombreCliente ,
count(p.montoPago) as "Pagos Realizados"
from Cliente c
join Pagos p ON c.id_cliente = p.id_cliente
GROUP BY c.nombreCliente;


SELECT
    c.nombreCliente,
    SUM(e.presupuestoCotizado) AS PresupuestoTotal,
    CASE
        WHEN SUM(e.presupuestoCotizado) > 10000000 THEN 'Cliente VIP'
        ELSE 'Cliente Pequeño'
    END AS Categoria_Cliente
FROM
    Cliente c
LEFT JOIN
    Evento e ON c.idCliente = e.idCliente
WHERE
    e.tipoEvento = 'Corporativo' -- Filtramos las filas ANTES de agrupar
GROUP BY
    c.nombreCliente
HAVING
    SUM(e.presupuestoCotizado) > 5000000 -- Filtramos los grupos DESPUÉS de agrupar
ORDER BY
    PresupuestoTotal DESC;









