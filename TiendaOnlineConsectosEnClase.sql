-- Elimina las tablas existentes en el orden correcto si necesitas limpiar antes
DROP TABLE DETALLE_PEDIDO;
DROP TABLE PEDIDOS;
DROP TABLE PRODUCTOS;
DROP TABLE CLIENTES;

-- 1. Crea CLIENTES (sin FKs que referencien a otras tablas)
CREATE TABLE CLIENTES (
    cliente_id NUMBER(10) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    apellido VARCHAR2(100) NOT NULL,
    email VARCHAR2(255) UNIQUE NOT NULL, -- Email debe ser �nico
    telefono VARCHAR2(15),
    direccion VARCHAR2(255),
    ciudad VARCHAR2(100),
    pais VARCHAR2(100),
    fecha_registro DATE DEFAULT SYSDATE, -- Fecha de registro por defecto
    CONSTRAINT PK_CLIENTES PRIMARY KEY (cliente_id)
);

-- 2. Crea PRODUCTOS (sin FKs que referencien a otras tablas)
CREATE TABLE PRODUCTOS (
    producto_id NUMBER(10) NOT NULL,
    nombre_producto VARCHAR2(255) NOT NULL UNIQUE,
    descripcion CLOB, -- Para descripciones largas
    precio NUMBER(10, 2) NOT NULL, -- Ej: 99999999.99
    stock_disponible NUMBER(10) DEFAULT 0 NOT NULL,
    CONSTRAINT PK_PRODUCTOS PRIMARY KEY (producto_id),
    CONSTRAINT CKC_PRECIO_PRODUCTO CHECK (precio > 0),
    CONSTRAINT CKC_STOCK_PRODUCTO CHECK (stock_disponible >= 0)
);

-- 3. Crea PEDIDOS (definiendo la FK a CLIENTES directamente)
CREATE TABLE PEDIDOS (
    pedido_id NUMBER(10) NOT NULL,
    cliente_id NUMBER(10) NOT NULL, -- FK a CLIENTES
    fecha_pedido TIMESTAMP(6) DEFAULT SYSTIMESTAMP NOT NULL, -- Fecha y hora del pedido
    estado_pedido VARCHAR2(50) DEFAULT 'Pendiente' NOT NULL,
    total_pedido NUMBER(10, 2) DEFAULT 0.00 NOT NULL,
    CONSTRAINT PK_PEDIDOS PRIMARY KEY (pedido_id),
    CONSTRAINT CKC_ESTADO_PEDIDO CHECK (estado_pedido IN ('Pendiente', 'Procesando', 'Enviado', 'Entregado', 'Cancelado')),
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (cliente_id) REFERENCES CLIENTES (cliente_id) -- FK definida aqu�
);

-- 4. Crea DETALLE_PEDIDO (definiendo las FKs a PEDIDOS y PRODUCTOS directamente)
CREATE TABLE DETALLE_PEDIDO (
    pedido_id NUMBER(10) NOT NULL,
    producto_id NUMBER(10) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    precio_unitario NUMBER(10, 2) NOT NULL, -- Precio del producto en el momento de la compra
    subtotal_linea NUMBER(10, 2) GENERATED ALWAYS AS (cantidad * precio_unitario) VIRTUAL, -- Columna virtual calculada
    PRIMARY KEY (pedido_id, producto_id), -- Clave Primaria Compuesta
    CONSTRAINT fk_detalle_pedido_pedidos FOREIGN KEY (pedido_id) REFERENCES PEDIDOS (pedido_id), -- FK definida aqu�
    CONSTRAINT fk_detalle_pedido_productos FOREIGN KEY (producto_id) REFERENCES PRODUCTOS (producto_id), -- FK definida aqu�
    CONSTRAINT CKC_CANTIDAD CHECK (cantidad > 0)
);

-- 1. Insertar Clientes
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (1, 'Ana', 'Garc�a', 'ana.garcia@email.com', '123456789', 'Calle Falsa 123', 'Madrid', 'Espa�a');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (2, 'Juan', 'P�rez', 'juan.perez@email.com', '987654321', 'Av. Siempre Viva 45', 'Barcelona', 'Espa�a');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (3, 'Maria', 'Lopez', 'maria.lopez@email.com', '555111222', 'Elm Street 10', 'Mexico DF', 'Mexico');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (4, 'Carlos', 'Ram�rez', 'carlos.r@email.com', '5061112222', 'Avenida Central 15', 'San Jos�', 'Costa Rica');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (5, 'Sof�a', 'Mart�nez', 'sofia.m@email.com', '549113334444', 'Calle Corrientes 300', 'Buenos Aires', 'Argentina');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (6, 'Luis', 'Hern�ndez', 'luis.h@email.com', '525566778899', 'Paseo de la Reforma 200', 'Ciudad de M�xico', 'M�xico');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (7, 'Valeria', 'Silva', 'valeria.s@email.com', '56922334455', 'Av. Libertador 80', 'Santiago', 'Chile');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (8, 'Ricardo', 'D�az', 'ricardo.d@email.com', '573001234567', 'Carrera 7ma #1-23', 'Bogot�', 'Colombia');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (9, 'Camila', 'G�mez', 'camila.g@email.com', '51998765432', 'Jr. de la Uni�n 100', 'Lima', 'Per�');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (10, 'Fernando', 'Castro', 'fernando.c@email.com', '58412987654', 'Av. Francisco Miranda', 'Caracas', 'Venezuela');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (11, 'Paula', 'Rodr�guez', 'paula.r@email.com', '551198765432', 'Av. Paulista 1000', 'S�o Paulo', 'Brasil');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (12, 'Diego', 'Morales', 'diego.m@email.com', '593987654321', 'Av. Amazonas N1-23', 'Quito', 'Ecuador');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (13, 'Laura', 'Vargas', 'laura.v@email.com', '50765432100', 'Calle 50 Este', 'Ciudad de Panam�', 'Panam�');
-- 2. Insertar Productos
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (101, 'Laptop Gaming X1', 'Potente laptop para juegos con RTX 4080', 1800.00, 50);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (102, 'Teclado Mec�nico RGB', 'Teclado para gaming con switches rojos', 85.50, 200);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (103, 'Monitor Curvo 27"', 'Monitor 144Hz, 1ms, ideal para juegos', 350.00, 75);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (104, 'Mouse Inal�mbrico Ergon�mico', 'Mouse con sensor �ptico de alta precisi�n', 45.99, 300);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (105, 'Auriculares Inal�mbricos', 'Cancelaci�n de ruido, alta fidelidad de sonido', 199.99, 150);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (106, 'Webcam HD 1080p', 'Para videollamadas y streaming de calidad', 65.00, 250);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (107, 'Disco Duro Externo 2TB', 'Almacenamiento port�til de alta velocidad', 89.99, 100);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (108, 'Router Wi-Fi 6', 'Conexi�n ultrarr�pida para m�ltiples dispositivos', 120.00, 80);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (109, 'Impresora Multifunci�n', 'Imprime, escanea y copia a color', 210.50, 60);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (110, 'Software Antivirus Anual', 'Protecci�n completa contra amenazas en l�nea', 49.99, 500);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (111, 'Cable HDMI 2.1 (2m)', 'Alta velocidad para 4K/8K', 15.75, 400);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (112, 'Silla Gaming Ergon�mica', 'Comodidad para largas sesiones de juego', 299.00, 30);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (113, 'Smartwatch Deportivo', 'Monitor de ritmo card�aco y GPS', 150.00, 70);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (114, 'Micr�fono Condensador USB', 'Ideal para podcasting y grabaci�n de voz', 75.00, 120);
-- 3. Insertar Pedidos
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1001, 1, 'Pendiente'); -- Pedido de Ana (cliente_id = 1)
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1002, 2, 'Procesando'); -- Pedido de Juan (cliente_id = 2)
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1003, 1, 'Enviado'); -- Segundo Pedido de Ana (cliente_id = 1)
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1004, 4, 'Procesando'); -- Carlos de Costa Rica
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1005, 5, 'Pendiente'); -- Sof�a de Argentina
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1006, 6, 'Enviado'); -- Luis de M�xico
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1007, 7, 'Pendiente'); -- Valeria de Chile
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1008, 8, 'Procesando'); -- Ricardo de Colombia
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1009, 9, 'Entregado'); -- Camila de Per�
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1010, 10, 'Pendiente'); -- Fernando de Venezuela
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1011, 11, 'Enviado'); -- Paula de Brasil
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1012, 12, 'Procesando'); -- Diego de Ecuador
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1013, 13, 'Pendiente'); -- Laura de Panam�

-- Un par de pedidos extra para clientes existentes para tener m�s datos por cliente
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1014, 1, 'Entregado'); -- Ana de Espa�a
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1015, 2, 'Cancelado'); -- Juan de Espa�a
-- 4. Insertar Detalles de Pedido
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1001, 101, 1, 1800.00); -- Laptop Gaming X1 en Pedido 1001
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1001, 102, 2, 85.50);  -- Teclado Mec�nico RGB en Pedido 1001
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1002, 103, 1, 350.00); -- Monitor Curvo 27" en Pedido 1002
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1002, 104, 1, 45.99);  -- Mouse Inal�mbrico Ergon�mico en Pedido 1002

INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1004, 105, 1, 199.99); -- Auriculares
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1004, 107, 1, 89.99); -- Disco Duro
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1004, 111, 2, 15.75); -- Cables HDMI
-- Para Pedido 1005 (Sof�a)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1005, 102, 1, 85.50);  -- Teclado Mec�nico
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1005, 106, 1, 65.00);  -- Webcam
-- Para Pedido 1006 (Luis)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1006, 109, 1, 210.50); -- Impresora
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1006, 110, 1, 49.99);  -- Antivirus
-- Para Pedido 1007 (Valeria)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1007, 108, 1, 120.00); -- Router
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1007, 105, 1, 199.99); -- Auriculares
-- Para Pedido 1008 (Ricardo)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1008, 112, 1, 299.00); -- Silla Gaming
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1008, 101, 1, 1800.00);-- Laptop Gaming
-- Para Pedido 1009 (Camila)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1009, 113, 1, 150.00); -- Smartwatch
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1009, 114, 1, 75.00);  -- Micr�fono
-- Para Pedido 1010 (Fernando)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1010, 107, 2, 89.99); -- Disco Duro
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1010, 105, 1, 199.99); -- Auriculares
-- Para Pedido 1011 (Paula)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1011, 101, 1, 1800.00);-- Laptop Gaming
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1011, 103, 1, 350.00); -- Monitor
-- Para Pedido 1012 (Diego)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1012, 104, 2, 45.99);  -- Mouse Inal�mbrico
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1012, 106, 1, 65.00);  -- Webcam
-- Para Pedido 1013 (Laura)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1013, 109, 1, 210.50); -- Impresora
-- Para Pedido 1014 (Segundo pedido de Ana)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1014, 110, 1, 49.99); -- Antivirus
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1014, 111, 3, 15.75); -- Cables HDMI
-- Para Pedido 1015 (Pedido de Juan que luego fue cancelado)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1015, 104, 1, 45.99); -- Mouse
-- Pruebas de Integridad Referencial (FK) y unicidad de Clave Compuesta (PK) - Intenta ejecutarlas y ve los errores
-- INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido) VALUES (1004, 999, 'Pendiente');
-- DELETE FROM CLIENTES WHERE cliente_id = 1;
-- INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1001, 101, 1, 1800.00);
-----------------------------------------------------------------------------------------------------------------------------
--script masivo
-- ========= INICIO: SCRIPT DE INSERCI�N MASIVA PARA TIENDAONLINE =========

DECLARE
  v_cliente_id   CLIENTES.cliente_id%TYPE;
  v_producto_id  PRODUCTOS.producto_id%TYPE;
  v_precio_prod  PRODUCTOS.precio%TYPE;
  v_nuevo_pedido_id PEDIDOS.pedido_id%TYPE;
BEGIN
    FOR i IN 1..100 LOOP
        -- Seleccionar un cliente al azar
        SELECT cliente_id INTO v_cliente_id
        FROM (SELECT cliente_id FROM CLIENTES ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;

        -- Obtener el siguiente ID de pedido de la secuencia
        SELECT seq_pedidos.NEXTVAL INTO v_nuevo_pedido_id FROM dual;

        -- Insertar la cabecera del pedido
        INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
        VALUES (
            v_nuevo_pedido_id,
            v_cliente_id,
            CASE TRUNC(DBMS_RANDOM.VALUE(1, 5))
                WHEN 1 THEN 'Pendiente'
                WHEN 2 THEN 'Procesando'
                WHEN 3 THEN 'Enviado'
                ELSE 'Entregado'
            END
        );

        -- Insertar entre 1 y 5 productos diferentes en el detalle del pedido
        FOR j IN 1..TRUNC(DBMS_RANDOM.VALUE(1, 6)) LOOP
            BEGIN
                -- Seleccionar un producto al azar
                SELECT producto_id, precio INTO v_producto_id, v_precio_prod
                FROM (SELECT producto_id, precio FROM PRODUCTOS ORDER BY DBMS_RANDOM.VALUE)
                WHERE ROWNUM = 1;

                -- Insertar el detalle
                INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
                VALUES (
                    v_nuevo_pedido_id,
                    v_producto_id,
                    TRUNC(DBMS_RANDOM.VALUE(1, 5)), -- Cantidad aleatoria
                    v_precio_prod -- Precio del producto en ese momento
                );
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN -- Si el producto ya est� en la factura, lo ignora y sigue
                    NULL;
            END;
        END LOOP;
    END LOOP;
    COMMIT;
END;
/

PROMPT �100 nuevos pedidos con sus detalles han sido insertados!;
--------------------------------------------------------------------------------------------------------
-- ========= SCRIPT PARA CORREGIR LA SECUENCIA DE PEDIDOS =========

CREATE OR REPLACE TRIGGER trg_actualizar_total_pedido
AFTER INSERT OR UPDATE OR DELETE ON DETALLE_PEDIDO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Si es una nueva l�nea, suma el subtotal al total del pedido
        UPDATE PEDIDOS
        SET total_pedido = total_pedido + :NEW.subtotal_linea
        WHERE pedido_id = :NEW.pedido_id;
        
    ELSIF DELETING THEN
        -- Si se borra una l�nea, resta el subtotal del total del pedido
        UPDATE PEDIDOS
        SET total_pedido = total_pedido - :OLD.subtotal_linea
        WHERE pedido_id = :OLD.pedido_id;
        
    ELSIF UPDATING THEN
        -- Si se actualiza una l�nea, ajusta la diferencia
        UPDATE PEDIDOS
        SET total_pedido = total_pedido - :OLD.subtotal_linea + :NEW.subtotal_linea
        WHERE pedido_id = :NEW.pedido_id;
    END IF;
END;
/
-----------------------------------------------------------------------------------------------------------------------------

--Obtener todas las columnas y filas de una tabla:
SELECT *
FROM CLIENTES;

--Obtener columnas espec�ficas
SELECT nombre, apellido, email
FROM CLIENTES;

--Obtener productos con precio y stock
SELECT nombre_producto, precio, stock_disponible
FROM PRODUCTOS;

/*Uso de WHERE (filtrado de filas):
Filtrar por una condici�n simple:
Clientes de Madrid:*/
SELECT nombre, apellido, ciudad
FROM CLIENTES
WHERE ciudad = 'Madrid';

--Pedidos en estado 'Pendiente':
SELECT pedido_id, fecha_pedido, estado_pedido
FROM PEDIDOS
WHERE estado_pedido = 'Pendiente';

--practica
select cliente_id,nombre,apellido from CLIENTES where cliente_id = 4;

/*WHERE con IN (para m�ltiples valores en una columna):
Productos con ID 101 o 103:*/
SELECT producto_id, nombre_producto, precio
FROM PRODUCTOS
WHERE producto_id IN (101, 103);

--Pedidos en estado 'Procesando' o 'Enviado':
SELECT pedido_id, cliente_id, estado_pedido
FROM PEDIDOS
WHERE estado_pedido IN ('Procesando', 'Enviado');

/*WHERE con BETWEEN (para rangos):
Productos con precio entre 50 y 200 (ambos inclusive):*/
SELECT nombre_producto, precio
FROM PRODUCTOS
WHERE precio
BETWEEN 50.00 AND 200.00;

--Practica
select pedido_id, cliente_id, fecha_pedido from PEDIDOS
where fecha_pedido 
BETWEEN to_date('2025-01-01', 'yyyy-mm-dd') and to_date('2025-12-31', 'yyyy-mm-dd');

--Pedidos realizados en el a�o 2023 (o un rango de fechas):
-- Asumiendo que fechas de pedido son de 2023
SELECT pedido_id, fecha_pedido
FROM PEDIDOS
--WHERE fecha_pedido BETWEEN TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2023-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');
-- O  datos de 2024 o 2025:
WHERE fecha_pedido BETWEEN TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2024-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

--WHERE con IS NULL (para valores nulos):
--Clientes sin n�mero de tel�fono registrado
SELECT nombre, apellido, telefono
FROM CLIENTES
WHERE telefono IS NULL;

--Productos sin descripci�n:
SELECT nombre_producto, descripcion
FROM PRODUCTOS
WHERE descripcion IS NULL;

/*WHERE con LIKE (para b�squeda de patrones):
%: representa cero o m�s caracteres.
_: representa un solo car�cter.
Clientes cuyo nombre empieza con 'A':*/
SELECT nombre, apellido
FROM CLIENTES
WHERE nombre LIKE 'A%';

--Productos que contienen la palabra 'Gaming' en su nombre:
SELECT nombre_producto
FROM PRODUCTOS
WHERE nombre_producto LIKE '%Gaming%';

--Clientes con "ana" en su email (sin importar may�sculas/min�sculas):
SELECT email, nombre
FROM CLIENTES
WHERE LOWER(email) LIKE '%ana%'; -- Usamos LOWER() para hacer la b�squeda case-insensitive

/*ORDER BY (ordenaci�n de resultados):
Clientes ordenados alfab�ticamente por apellido y luego por nombre:*/
SELECT nombre, apellido, ciudad
FROM CLIENTES
ORDER BY apellido ASC, nombre ASC; -- ASC es ascendente (por defecto), DESC es descendente

--Productos ordenados de m�s caro a m�s barato:
SELECT nombre_producto, precio
FROM PRODUCTOS
ORDER BY precio DESC;

SELECT
    nombre,
    apellido,
    pais
FROM
    CLIENTES
ORDER BY
    pais, nombre; -- Ordena por pa�s (ASC por defecto), luego por nombre (ASC por defecto)

/* Expresiones Condicionales (CASE):
Permite definir diferentes salidas basadas en condiciones, similar a un "if-then-else".
Clasificar productos por rango de precio:*/
SELECT
    nombre_producto,
    precio,
    CASE
        WHEN precio < 100 THEN 'Econ�mico'
        WHEN precio >= 100 AND precio < 500 THEN 'Precio Medio'
        ELSE 'Premium'
    END AS Categoria_Precio
FROM PRODUCTOS;

SELECT
    nombre_producto,
    precio
FROM
    PRODUCTOS
ORDER BY
    precio DESC; -- Orden descendente por precio
--Mostrar el estado del pedido de forma m�s descriptiva:
SELECT
    pedido_id,
    estado_pedido,
    CASE estado_pedido
        WHEN 'Pendiente' THEN 'Esperando procesamiento'
        WHEN 'Procesando' THEN 'En preparaci�n'
        WHEN 'Enviado' THEN 'En camino al cliente'
        WHEN 'Entregado' THEN 'Recibido por el cliente'
        WHEN 'Cancelado' THEN 'Pedido anulado'
        ELSE 'Estado Desconocido'
    END AS Descripcion_Estado
FROM PEDIDOS;

 /*Uso de Alias
Los alias se usan para darle un nombre temporal a una columna o a una tabla, lo que hace las consultas m�s legibles.
Alias para columnas:*/
SELECT
    nombre AS Nombre_Cliente,
    apellido AS Apellido_Cliente,
    email AS Correo_Electronico
FROM CLIENTES;

--Tambi�n se puede usar AS opcionalmente:
SELECT
    nombre Nombre_Cliente,
    apellido Apellido_Cliente
FROM CLIENTES;

--Alias para tablas (muy �til en JOINs y subconsultas):
-- En lugar de escribir CLIENTES.nombre y CLIENTES.apellido, usamos 'c' como alias
SELECT
    c.cliente_id,
    c.nombre,
    c.apellido,
    c.ciudad,
    c.pais
FROM
    CLIENTES c; -- 'c' es el alias para la tabla CLIENTES
    
    ----------------------------------------------------------------------------------------
/* Alias para Columnas
Esto  permite cambiar el nombre de una columna en el resultado de la consulta sin modificar 
el nombre real de la columna en la tabla. Puedes usar la palabra clave AS (que es opcional).
Sintaxis con AS (m�s legible)*/
SELECT
    nombre AS Nombre_Cliente,
    apellido AS Apellido_Cliente
FROM CLIENTES;

--Sintaxis sin AS (m�s corta):
SELECT
    nombre Nombre_Cliente,
    apellido Apellido_Cliente
FROM CLIENTES;

/*practica  */
select 
pedido_id as "N�mero de Pedido" , 
fecha_pedido "Fecha de la Orden"
from pedidos;

/* Alias para Tablas
Esto  permite usar un nombre corto (normalmente una o dos letras) para 
referirte a una tabla. Esto es indispensable para JOINs, donde necesitas 
especificar de qu� tabla viene cada columna.*/
SELECT
    c.cliente_id, -- 'c' es el alias para la tabla CLIENTES
    c.nombre,
    c.apellido,
    c.ciudad,
    c.pais
FROM
    CLIENTES c; -- Se define el alias 'c' aqu�
    
--Practica
SELECT
    c.nombre,
    c.apellido,
    p.pedido_id
FROM
    CLIENTES c
JOIN
    PEDIDOS p ON c.cliente_id = p.cliente_id;
    
/*Como se ver en este ejemplo, en lugar de escribir CLIENTES.cliente_id,
solo usamos c.cliente_id, lo que hace la consulta mucho m�s limpia.*/

/* Objetivo: Agrupar datos, realizar c�lculos sobre esos grupos y filtrar los filas agrupadas.
GROUP BY: Esta cl�usula se utiliza para agrupar filas que tienen los mismos valores en las 
columnas especificadas. El prop�sito principal es poder aplicar funciones de agregaci�n 
(o de grupo) a cada grupo por separado.
Funciones de Grupo: Son funciones que operan en un conjunto de filas y devuelven un �nico valor
por grupo. Las m�s comunes son: COUNT(), SUM(), AVG(), MAX() y MIN().*/

/*HAVING: Esta cl�usula se utiliza para filtrar los grupos creados por GROUP BY. A diferencia de WHERE 
(que filtra filas individuales antes de la agrupaci�n), HAVING filtra los grupos
despu�s de que se han formado y las funciones de grupo se han aplicado.*/

/*Para contar cu�ntos pedidos ha realizado cada cliente, 
La consulta agrupa todas las filas de la tabla PEDIDOS por el cliente_id y luego cuenta cu�ntos 
pedidos hay en cada grupo.*/
SELECT
    cliente_id,
    COUNT(pedido_id) AS total_pedidos
FROM
    PEDIDOS
GROUP BY
    cliente_id;
    
/*    Uso de SUM() y AVG()
Para calcular el total gastado en cada pedido, el asistente propone la siguiente consulta:*/
SELECT
    pedido_id,
    SUM(subtotal_linea) AS subtotal_total_pedido
FROM
    DETALLE_PEDIDO
GROUP BY
    pedido_id;
----------------------------------------------------------------------------------------------------------------------------    
/* Uso de HAVING (filtrando grupos)
Para encontrar solo los clientes que han realizado m�s de un pedido, 
el asistente indica que se debe usar HAVING para filtrar el resultado de la funci�n COUNT():*/
SELECT
    cliente_id,
    COUNT(pedido_id) AS total_pedidos
FROM
    PEDIDOS
GROUP BY
    cliente_id
HAVING
    COUNT(pedido_id) > 1;



-----------------------------------------------------------------------------------------------------------------------------
/*El INNER JOIN no se limita a unir solo dos tablas. Se pueden unir tantas tablas 
como sean necesarias para obtener la informaci�n deseada, siempre que exista una columna 
com�n entre ellas. Esto se realiza encadenando las cl�usulas INNER JOIN.
Objetivo: Obtener informaci�n que se encuentra distribuida en tres tablas diferentes, combinando los datos en una sola consulta.
Ejemplo pr�ctico con las tablas de la base de datos:
Para ver el nombre de los clientes, sus pedidos, y los productos espec�ficos 
que compraron en cada uno de esos pedidos, es necesario unir las tablas CLIENTES, PEDIDOS y DETALLE_PEDIDO.*/
SELECT
    c.nombre,
    c.apellido,
    p.pedido_id,
    dp.cantidad,
    dp.subtotal_linea
FROM
    CLIENTES c
INNER JOIN
    PEDIDOS p ON c.cliente_id = p.cliente_id
INNER JOIN
    DETALLE_PEDIDO dp ON p.pedido_id = dp.pedido_id;
    
    /*Explicaci�n de la consulta:

FROM CLIENTES c: Iniciar la consulta desde la tabla CLIENTES.

INNER JOIN PEDIDOS p ON c.cliente_id = p.cliente_id: Unir la tabla PEDIDOS con 
la tabla CLIENTES, utilizando la columna cliente_id como enlace com�n.

INNER JOIN DETALLE_PEDIDO dp ON p.pedido_id = dp.pedido_id: Unir el resultado de 
la uni�n anterior con la tabla DETALLE_PEDIDO, utilizando la columna pedido_id como enlace.

El resultado ser� una lista donde cada fila contendr� el nombre del cliente y los detalles de cada producto que compr�.*/

----------------------------------------------------------------------------------

/*El LEFT JOIN (tambi�n conocido como LEFT OUTER JOIN) permite obtener todas las filas de la tabla 
de la izquierda, sin importar si existe una coincidencia en la tabla de la derecha. Las filas 
que no tienen coincidencia en la tabla de la derecha se mostrar�n con valores nulos (NULL) en las columnas de esa tabla.

Objetivo: Mostrar todos los clientes, incluyendo aquellos que no han realizado ning�n pedido.
Ejemplo pr�ctico con las tablas de la base de datos:
Para ver una lista completa de todos los clientes y, si han hecho un pedido, ver el ID de 
su pedido, es necesario usar un LEFT JOIN. Si se utilizara un INNER JOIN, solo se ver�an los clientes que tienen al menos un pedido.*/
SELECT
    c.nombre,
    c.apellido,
    p.pedido_id,
    p.estado_pedido
FROM
    CLIENTES c
LEFT JOIN
    PEDIDOS p ON c.cliente_id = p.cliente_id;
    
    /* Explicaci�n de la consulta:
FROM CLIENTES c: La tabla de la izquierda (CLIENTES) es la que se usar� como base para el resultado.
LEFT JOIN PEDIDOS p: Unir la tabla PEDIDOS.
ON c.cliente_id = p.cliente_id: La condici�n de uni�n sigue siendo la misma.
El resultado de esta consulta mostrar� todos los clientes de la tabla CLIENTES. Los clientes que
no han realizado un pedido aparecer�n en la lista, pero sus columnas de pedido_id y estado_pedido se mostrar�n como NULL.*/
------------------------------------------------------------------------------------------------------

/*El RIGHT JOIN (tambi�n conocido como RIGHT OUTER JOIN) funciona de manera opuesta al LEFT JOIN. 
Este tipo de uni�n permite obtener todas las filas de la tabla de la derecha, sin importar si existe
una coincidencia en la tabla de la izquierda. Las filas de la tabla izquierda que no tienen coincidencia se mostrar�n como NULL.
Objetivo: Mostrar todos los productos, incluyendo aquellos que no han sido vendidos en ning�n pedido.
Ejemplo pr�ctico con las tablas de la base de datos:
Para ver una lista completa de todos los productos y, si han sido vendidos, ver los detalles de su pedido, se puede usar un RIGHT JOIN.*/
SELECT
    p.nombre_producto,
    dp.pedido_id,
    dp.cantidad
FROM
    DETALLE_PEDIDO dp
RIGHT JOIN
    PRODUCTOS p ON dp.producto_id = p.producto_id;
--Explicaci�n de la consulta:

/*FROM DETALLE_PEDIDO dp: La tabla de la izquierda es DETALLE_PEDIDO.
RIGHT JOIN PRODUCTOS p: La tabla de la derecha (PRODUCTOS) es la que se usar� como base para el resultado.
ON dp.producto_id = p.producto_id: La condici�n de uni�n.
El resultado de esta consulta mostrar� todos los productos de la tabla PRODUCTOS. Los productos que 
no han sido incluidos en ning�n detalle de pedido aparecer�n en la lista, pero sus columnas de pedido_id y cantidad se mostrar�n como NULL.*/
--Practicas join
select c.nombre,c.apellido, p.estado_pedido
from CLIENTES c
full outer join PEDIDOS p ON c.cliente_id = p.cliente_id;


-----------------------------------------------------------------------------------------------------------------------
--group by
SELECT
    estado_pedido,
    COUNT(*) AS "Cantidad_de_Pedidos" -- Contamos las filas en cada grupo de 'estado_pedido'
FROM
    PEDIDOS
GROUP BY
    estado_pedido;
    
    
select stock_disponible,
    COUNT(*) AS "Cantidad de Pedidos",
    AVG(precio) AS "Precio Promedio ",
    MAX(precio) AS "Precio M�s Caro",
    MIN(precio) AS "Precio M�s Barato"
FROM
    PRODUCTOS
WHERE stock_disponible < 100 
GROUP BY
    stock_disponible
order by stock_disponible desc;
-------------------------------------------------------------------------------------------------------------------------------
/*
Creaci�n de Procedimientos Almacenados
�Qu� es?
Un bloque de c�digo SQL guardado en la base de datos que puedes ejecutar por su nombre.
No devuelve un valor directamente, simplemente realiza una acci�n (como insertar, actualizar o eliminar datos).

�Para qu� sirve?
Para encapsular l�gica repetitiva. Por ejemplo, en lugar de escribir 3 INSERTs cada vez que creas un pedido, lo metes en un procedimiento y solo lo llamas.

Ejemplo Pr�ctico:
Este procedimiento crea un nuevo pedido para un cliente espec�fico.*/
CREATE OR REPLACE PROCEDURE sp_crear_nuevo_pedido (
    p_cliente_id IN CLIENTES.cliente_id%TYPE
) AS
BEGIN
    INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
    VALUES ((SELECT NVL(MAX(pedido_id), 1000) + 1 FROM PEDIDOS), p_cliente_id, 'Pendiente');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Pedido creado exitosamente para el cliente ' || p_cliente_id);
END;
/

-- C�mo usarlo:
BEGIN
    sp_crear_nuevo_pedido(p_cliente_id => 4); -- Crea un pedido para Carlos Ram�rez
END;
/
---------------------------------------------------------------------------------------------------
--clausula con distint
--para eliminar filas duplicadas de un conjunto de resultados
SELECT COUNT(DISTINCT cliente_id) AS "Total de Clientes �nicos"
FROM PEDIDOS;

--practica 01
select DISTINCT pais
from CLIENTES;

select count(distinct pais) as "Paises de clientes"
from CLIENTES;
--------------------------------------------------------------------------------
/*
Creaci�n de Triggers
�Qu� es?
Un tipo especial de procedimiento que se ejecuta autom�ticamente cuando ocurre un evento espec�fico en una tabla (un INSERT, UPDATE o DELETE).

�Para qu� sirve?
Para mantener la integridad de los datos de forma autom�tica. 
El caso de uso cl�sico es actualizar un total en una tabla maestra cuando se modifica una tabla de detalle.

Ejemplo Pr�ctico:
Este trigger actualiza el total_pedido en la tabla PEDIDOS cada vez que se a�ade, modifica o elimina un producto en DETALLE_PEDIDO.
*/
CREATE OR REPLACE TRIGGER trg_actualizar_total_pedido
AFTER INSERT OR UPDATE OR DELETE ON DETALLE_PEDIDO
FOR EACH ROW
DECLARE
    v_pedido_id NUMBER;
BEGIN
    -- Determina cu�l pedido_id se vio afectado
    IF INSERTING OR UPDATING THEN
        v_pedido_id := :NEW.pedido_id;
    ELSE -- DELETING
        v_pedido_id := :OLD.pedido_id;
    END IF;

    -- Recalcula el total para ese pedido
    UPDATE PEDIDOS
    SET total_pedido = (SELECT SUM(subtotal_linea) FROM DETALLE_PEDIDO WHERE pedido_id = v_pedido_id)
    WHERE pedido_id = v_pedido_id;

END;
/
-----------------------------------------------------------------------------------------------------------
/*
Creaci�n de Funciones
�Qu� es?
Similar a un procedimiento, pero con una diferencia clave: siempre devuelve un �nico valor.

�Para qu� sirve?
Para realizar c�lculos complejos y reutilizarlos en tus consultas SELECT como si fueran una columna m�s.

Ejemplo Pr�ctico:
Esta funci�n calcula el gasto total de un cliente
*/
CREATE OR REPLACE FUNCTION fn_gasto_total_cliente (
    p_cliente_id IN CLIENTES.cliente_id%TYPE
) RETURN NUMBER AS
    v_gasto_total NUMBER(10, 2);
BEGIN
    SELECT SUM(p.total_pedido)
    INTO v_gasto_total
    FROM PEDIDOS p
    WHERE p.cliente_id = p_cliente_id
      AND p.estado_pedido != 'Cancelado';
      
    RETURN NVL(v_gasto_total, 0);
END;
/

-- C�mo usarla en una consulta:
SELECT
    cliente_id,
    nombre,
    apellido,
    fn_gasto_total_cliente(cliente_id) AS Gasto_Total
FROM CLIENTES;
----------------------------------------------------------------------------------------------------------
/*
Creaci�n de Vistas
�Qu� es?
Una tabla virtual basada en el resultado de una consulta SELECT. No almacena datos por s� misma, 
sino que muestra los datos de las tablas subyacentes de una manera espec�fica.

�Para qu� sirve?
Para simplificar consultas complejas. Si siempre haces un JOIN de 4 tablas, creas una vista y as� solo consultas la vista
como si fuera una tabla simple. Tambi�n es �til para la seguridad, mostrando solo ciertas columnas a ciertos usuarios.

Ejemplo Pr�ctico:
Esta vista muestra un resumen completo de los pedidos, uniendo 4 tablas
*/
CREATE OR REPLACE VIEW V_RESUMEN_PEDIDOS AS
SELECT
    p.pedido_id,
    p.fecha_pedido,
    p.estado_pedido,
    c.nombre || ' ' || c.apellido AS nombre_cliente,
    c.pais,
    pr.nombre_producto,
    dp.cantidad,
    dp.precio_unitario,
    dp.subtotal_linea
FROM PEDIDOS p
JOIN CLIENTES c ON p.cliente_id = c.cliente_id
JOIN DETALLE_PEDIDO dp ON p.pedido_id = dp.pedido_id
JOIN PRODUCTOS pr ON dp.producto_id = pr.producto_id;
/

-- C�mo usarla:
SELECT * FROM V_RESUMEN_PEDIDOS WHERE pais = 'Costa Rica';
---------------------------------------------------------------------------------------
/*
Uso de Secuencias
Recordatorio r�pido: Una secuencia es un objeto de Oracle que funciona como un contador autom�tico de n�meros.
Su principal uso es generar valores �nicos para las claves primarias (PRIMARY KEY), evitando que tengas que calcular manualmente 
cu�l es el siguiente ID disponible.

Pr�ctica: Crear y Usar Secuencias
Vamos a crear las secuencias para tus tablas principales. Como ya tienes datos, usaremos START WITH para indicarle a
la secuencia que empiece a contar desde el �ltimo n�mero que ya usaste.
*/
-- Creamos una secuencia para los nuevos clientes. El �ltimo ID fue 13, as� que empezamos en 14.
CREATE SEQUENCE seq_clientes
START WITH 14
INCREMENT BY 1;

-- Creamos una secuencia para los nuevos productos. El �ltimo ID fue 114, empezamos en 115.
CREATE SEQUENCE seq_productos
START WITH 115
INCREMENT BY 1;

-- Creamos una secuencia para los nuevos pedidos. El �ltimo ID fue 1015, empezamos en 1016.
CREATE SEQUENCE seq_pedidos
START WITH 1016
INCREMENT BY 1;

/*
Paso 2: Usar las Secuencias para Insertar Datos

Ahora, la magia de las secuencias es que ya no necesitas especificar el ID al insertar. Usas la pseudocolumna .NEXTVAL para que la secuencia te d� el siguiente n�mero autom�ticamente.

Ejemplo: Vamos a insertar un nuevo cliente sin preocuparnos por su ID.*/
-- F�jate c�mo usamos 'seq_clientes.NEXTVAL' en lugar de un n�mero.
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, ciudad, pais)
VALUES (seq_clientes.NEXTVAL, 'Marco', 'Aurelio', 'marco.aurelio@email.com', 'Roma', 'Italia');
-----------------------------------------------------------------------------------
/*
Procedimientos con Cursores
�Qu� es?
Un cursor es como un puntero que te permite procesar el resultado de una consulta fila por fila dentro de un procedimiento o funci�n.

�Para qu� sirve?
Cuando necesitas realizar una acci�n compleja para cada fila devuelta por una consulta. Por ejemplo, revisar el stock de cada producto y enviar una alerta si es bajo.

Ejemplo Pr�ctico:
Este procedimiento usa un cursor para revisar el stock de todos los productos y mostrar una advertencia si es menor a 50.
*/
CREATE OR REPLACE PROCEDURE sp_revisar_stock_bajo AS
    -- 1. Declarar el cursor
    CURSOR cur_productos_bajos IS
        SELECT nombre_producto, stock_disponible
        FROM PRODUCTOS
        WHERE stock_disponible < 50;
        
    v_nombre_producto VARCHAR2(255);
    v_stock NUMBER;
BEGIN
    -- 2. Abrir el cursor
    OPEN cur_productos_bajos;
    
    -- 3. Iniciar un bucle para recorrer las filas
    LOOP
        -- 4. Obtener los datos de la fila actual
        FETCH cur_productos_bajos INTO v_nombre_producto, v_stock;
        
        -- 5. Salir del bucle si no hay m�s filas
        EXIT WHEN cur_productos_bajos%NOTFOUND;
        
        -- 6. Procesar la fila
        DBMS_OUTPUT.PUT_LINE('�ALERTA DE STOCK BAJO! Producto: ' || v_nombre_producto || ' - Quedan solo: ' || v_stock);
    END LOOP;
    
    -- 7. Cerrar el cursor
    CLOSE cur_productos_bajos;
END;
/

-- C�mo usarlo:
BEGIN
    sp_revisar_stock_bajo;
END;
/