-- ========= SCRIPT MAESTRO COMPLETO (ORDENADO) =========

-- 1. CREACIÓN DE TABLAS (en orden de dependencia)
CREATE TABLE CATEGORIAS(
    categoria_id INT NOT NULL,
    nombre_categoria VARCHAR2(50),
    CONSTRAINT pk_categoria_id PRIMARY KEY (categoria_id)
);

CREATE TABLE PRODUCTOS(
    cod_prod INT GENERATED ALWAYS AS IDENTITY (START WITH 1),
    desp_prod VARCHAR2(100) NOT NULL,
    val_unit DECIMAL(10,2),
    categoria_id INT NOT NULL,
    CONSTRAINT pk_productos PRIMARY KEY (cod_prod),
    CONSTRAINT fk_categoria_id FOREIGN KEY (categoria_id) REFERENCES CATEGORIAS(categoria_id)
);

CREATE TABLE CLIENTES(
    cliente_id INT NOT NULL,
    cedula_cliente VARCHAR2(50),
    dir_cliente VARCHAR2(100),
    nom_cliente VARCHAR2(100) NOT NULL,
    telef_cliente VARCHAR2(15) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (cliente_id)
);

CREATE TABLE FACTURA(
    num_fac INT NOT NULL,
    fecha DATE DEFAULT SYSDATE NOT NULL,
    cliente_id INT NOT NULL,
    CONSTRAINT pk_num_fac PRIMARY KEY (num_fac),
    CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES CLIENTES(cliente_id)
);

CREATE TABLE DETALLE_FACTURA(
    num_fac INT NOT NULL,
    cod_prod INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    cant_prod INT NOT NULL,
    CONSTRAINT pk_detalle_factura PRIMARY KEY (num_fac, cod_prod),
    CONSTRAINT fk_num_fac FOREIGN KEY (num_fac) REFERENCES FACTURA(num_fac),
    CONSTRAINT fk_cod_prod FOREIGN KEY (cod_prod) REFERENCES PRODUCTOS(cod_prod)
);

PROMPT --- Tablas creadas ---;

-- 2. INSERCIÓN DE DATOS (en orden de dependencia)

-- Insertar primero en las tablas sin claves foráneas
INSERT INTO CATEGORIAS (categoria_id, nombre_categoria) VALUES (1, 'Memorias');
INSERT INTO CATEGORIAS (categoria_id, nombre_categoria) VALUES (2, 'Monitores');
INSERT INTO CATEGORIAS (categoria_id, nombre_categoria) VALUES (3, 'Motherboards');
INSERT INTO CATEGORIAS (categoria_id, nombre_categoria) VALUES (4, 'Unidades');
INSERT INTO CATEGORIAS (categoria_id, nombre_categoria) VALUES (5, 'Perifericos');

INSERT INTO CLIENTES (cliente_id, cedula_cliente, dir_cliente, nom_cliente, telef_cliente) VALUES (1, '1-1234-5678', '100m norte del Parque Central, San José', 'Carlos Rojas Valverde', '8811-2233');
INSERT INTO CLIENTES (cliente_id, cedula_cliente, dir_cliente, nom_cliente, telef_cliente) VALUES (2, '2-0987-6543', 'Residencial El Roble, casa #15, Alajuela', 'Sofía Mora Solano', '8722-3344');
-- (Aquí puedes pegar el resto de los 13 clientes si quieres)

PROMPT --- Categorías y Clientes insertados ---;

-- Ahora insertar en PRODUCTOS, que depende de CATEGORIAS
INSERT INTO PRODUCTOS (desp_prod, val_unit, categoria_id) VALUES ('Dim PC133 256 MB', 115000, 1);
INSERT INTO PRODUCTOS (desp_prod, val_unit, categoria_id) VALUES ('Samsung Viamaster 550', 380000, 2);
INSERT INTO PRODUCTOS (desp_prod, val_unit, categoria_id) VALUES ('MSI KM266 ATA 133', 220000, 3);
INSERT INTO PRODUCTOS (desp_prod, val_unit, categoria_id) VALUES ('CDROM LG 52X', 70000, 4);
INSERT INTO PRODUCTOS (desp_prod, val_unit, categoria_id) VALUES ('Quemador LG 52x32x52x', 150000, 4);
INSERT INTO PRODUCTOS (desp_prod, val_unit, categoria_id) VALUES ('Teclado Genius PS2', 15000, 5);
INSERT INTO PRODUCTOS (desp_prod, val_unit, categoria_id) VALUES ('Mouse Genius Netscroll+', 13000, 5);

PROMPT --- Productos insertados ---;

-- Ahora insertar en FACTURA, que depende de CLIENTES
INSERT INTO FACTURA (num_fac, fecha, cliente_id) VALUES (5656801, TO_DATE('2014-10-23', 'YYYY-MM-DD'), 1);
INSERT INTO FACTURA (num_fac, fecha, cliente_id) VALUES (1002, TO_DATE('2025-05-10', 'YYYY-MM-DD'), 2);

PROMPT --- Facturas insertadas ---;

-- Finalmente, insertar en DETALLE_FACTURA, que depende de FACTURA y PRODUCTOS
INSERT INTO DETALLE_FACTURA (num_fac, cod_prod, cant_prod, precio) VALUES (5656801, 1, 2, 230000); -- Memorias
INSERT INTO DETALLE_FACTURA (num_fac, cod_prod, cant_prod, precio) VALUES (5656801, 2, 1, 380000); -- Monitores
INSERT INTO DETALLE_FACTURA (num_fac, cod_prod, cant_prod, precio) VALUES (1002, 7, 3, 39000); -- 3x Mouse Genius

COMMIT;

PROMPT ¡Base de datos creada e inicializada correctamente!;
/

select * from clientes;
select * from productos;
select * from factura;
select * from detalle_factura;

select nom_cliente from clientes where dir_cliente LIKE '%San José%';
select nom_cliente from clientes where dir_cliente LIKE '%Alajuela';

select cliente_id,nom_cliente from clientes where cliente_id in (1,5);
select desp_prod,cod_prod from productos where categoria_id in(1,5);

