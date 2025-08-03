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
    email VARCHAR2(255) UNIQUE NOT NULL, -- Email debe ser único
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
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (cliente_id) REFERENCES CLIENTES (cliente_id) -- FK definida aquí
);

-- 4. Crea DETALLE_PEDIDO (definiendo las FKs a PEDIDOS y PRODUCTOS directamente)
CREATE TABLE DETALLE_PEDIDO (
    pedido_id NUMBER(10) NOT NULL,
    producto_id NUMBER(10) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    precio_unitario NUMBER(10, 2) NOT NULL, -- Precio del producto en el momento de la compra
    subtotal_linea NUMBER(10, 2) GENERATED ALWAYS AS (cantidad * precio_unitario) VIRTUAL, -- Columna virtual calculada
    PRIMARY KEY (pedido_id, producto_id), -- Clave Primaria Compuesta
    CONSTRAINT fk_detalle_pedido_pedidos FOREIGN KEY (pedido_id) REFERENCES PEDIDOS (pedido_id), -- FK definida aquí
    CONSTRAINT fk_detalle_pedido_productos FOREIGN KEY (producto_id) REFERENCES PRODUCTOS (producto_id), -- FK definida aquí
    CONSTRAINT CKC_CANTIDAD CHECK (cantidad > 0)
);

-- 1. Insertar Clientes
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (1, 'Ana', 'García', 'ana.garcia@email.com', '123456789', 'Calle Falsa 123', 'Madrid', 'España');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (2, 'Juan', 'Pérez', 'juan.perez@email.com', '987654321', 'Av. Siempre Viva 45', 'Barcelona', 'España');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (3, 'Maria', 'Lopez', 'maria.lopez@email.com', '555111222', 'Elm Street 10', 'Mexico DF', 'Mexico');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (4, 'Carlos', 'Ramírez', 'carlos.r@email.com', '5061112222', 'Avenida Central 15', 'San José', 'Costa Rica');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (5, 'Sofía', 'Martínez', 'sofia.m@email.com', '549113334444', 'Calle Corrientes 300', 'Buenos Aires', 'Argentina');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (6, 'Luis', 'Hernández', 'luis.h@email.com', '525566778899', 'Paseo de la Reforma 200', 'Ciudad de México', 'México');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (7, 'Valeria', 'Silva', 'valeria.s@email.com', '56922334455', 'Av. Libertador 80', 'Santiago', 'Chile');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (8, 'Ricardo', 'Díaz', 'ricardo.d@email.com', '573001234567', 'Carrera 7ma #1-23', 'Bogotá', 'Colombia');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (9, 'Camila', 'Gómez', 'camila.g@email.com', '51998765432', 'Jr. de la Unión 100', 'Lima', 'Perú');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (10, 'Fernando', 'Castro', 'fernando.c@email.com', '58412987654', 'Av. Francisco Miranda', 'Caracas', 'Venezuela');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (11, 'Paula', 'Rodríguez', 'paula.r@email.com', '551198765432', 'Av. Paulista 1000', 'São Paulo', 'Brasil');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (12, 'Diego', 'Morales', 'diego.m@email.com', '593987654321', 'Av. Amazonas N1-23', 'Quito', 'Ecuador');
INSERT INTO CLIENTES (cliente_id, nombre, apellido, email, telefono, direccion, ciudad, pais)
VALUES (13, 'Laura', 'Vargas', 'laura.v@email.com', '50765432100', 'Calle 50 Este', 'Ciudad de Panamá', 'Panamá');
-- 2. Insertar Productos
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (101, 'Laptop Gaming X1', 'Potente laptop para juegos con RTX 4080', 1800.00, 50);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (102, 'Teclado Mecánico RGB', 'Teclado para gaming con switches rojos', 85.50, 200);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (103, 'Monitor Curvo 27"', 'Monitor 144Hz, 1ms, ideal para juegos', 350.00, 75);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (104, 'Mouse Inalámbrico Ergonómico', 'Mouse con sensor óptico de alta precisión', 45.99, 300);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (105, 'Auriculares Inalámbricos', 'Cancelación de ruido, alta fidelidad de sonido', 199.99, 150);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (106, 'Webcam HD 1080p', 'Para videollamadas y streaming de calidad', 65.00, 250);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (107, 'Disco Duro Externo 2TB', 'Almacenamiento portátil de alta velocidad', 89.99, 100);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (108, 'Router Wi-Fi 6', 'Conexión ultrarrápida para múltiples dispositivos', 120.00, 80);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (109, 'Impresora Multifunción', 'Imprime, escanea y copia a color', 210.50, 60);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (110, 'Software Antivirus Anual', 'Protección completa contra amenazas en línea', 49.99, 500);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (111, 'Cable HDMI 2.1 (2m)', 'Alta velocidad para 4K/8K', 15.75, 400);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (112, 'Silla Gaming Ergonómica', 'Comodidad para largas sesiones de juego', 299.00, 30);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (113, 'Smartwatch Deportivo', 'Monitor de ritmo cardíaco y GPS', 150.00, 70);
INSERT INTO PRODUCTOS (producto_id, nombre_producto, descripcion, precio, stock_disponible)
VALUES (114, 'Micrófono Condensador USB', 'Ideal para podcasting y grabación de voz', 75.00, 120);
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
VALUES (1005, 5, 'Pendiente'); -- Sofía de Argentina
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1006, 6, 'Enviado'); -- Luis de México
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1007, 7, 'Pendiente'); -- Valeria de Chile
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1008, 8, 'Procesando'); -- Ricardo de Colombia
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1009, 9, 'Entregado'); -- Camila de Perú
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1010, 10, 'Pendiente'); -- Fernando de Venezuela
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1011, 11, 'Enviado'); -- Paula de Brasil
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1012, 12, 'Procesando'); -- Diego de Ecuador
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1013, 13, 'Pendiente'); -- Laura de Panamá

-- Un par de pedidos extra para clientes existentes para tener más datos por cliente
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1014, 1, 'Entregado'); -- Ana de España
INSERT INTO PEDIDOS (pedido_id, cliente_id, estado_pedido)
VALUES (1015, 2, 'Cancelado'); -- Juan de España
-- 4. Insertar Detalles de Pedido
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1001, 101, 1, 1800.00); -- Laptop Gaming X1 en Pedido 1001
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1001, 102, 2, 85.50);  -- Teclado Mecánico RGB en Pedido 1001
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1002, 103, 1, 350.00); -- Monitor Curvo 27" en Pedido 1002
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1002, 104, 1, 45.99);  -- Mouse Inalámbrico Ergonómico en Pedido 1002

INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1004, 105, 1, 199.99); -- Auriculares
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1004, 107, 1, 89.99); -- Disco Duro
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1004, 111, 2, 15.75); -- Cables HDMI
-- Para Pedido 1005 (Sofía)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1005, 102, 1, 85.50);  -- Teclado Mecánico
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
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1009, 114, 1, 75.00);  -- Micrófono
-- Para Pedido 1010 (Fernando)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1010, 107, 2, 89.99); -- Disco Duro
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1010, 105, 1, 199.99); -- Auriculares
-- Para Pedido 1011 (Paula)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1011, 101, 1, 1800.00);-- Laptop Gaming
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1011, 103, 1, 350.00); -- Monitor
-- Para Pedido 1012 (Diego)
INSERT INTO DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1012, 104, 2, 45.99);  -- Mouse Inalámbrico
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

--Obtener todas las columnas y filas de una tabla:
SELECT *
FROM CLIENTES;

--Obtener columnas específicas
SELECT nombre, apellido, email
FROM CLIENTES;

--Obtener productos con precio y stock
SELECT nombre_producto, precio, stock_disponible
FROM PRODUCTOS;

/*Uso de WHERE (filtrado de filas):
Filtrar por una condición simple:
Clientes de Madrid:*/
SELECT nombre, apellido, ciudad
FROM CLIENTES
WHERE ciudad = 'Madrid';

--Pedidos en estado 'Pendiente':
SELECT pedido_id, fecha_pedido, estado_pedido
FROM PEDIDOS
WHERE estado_pedido = 'Pendiente';

/*WHERE con IN (para múltiples valores en una columna):
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
WHERE precio BETWEEN 50.00 AND 200.00;

--Pedidos realizados en el año 2023 (o un rango de fechas):
-- Asumiendo que fechas de pedido son de 2023
SELECT pedido_id, fecha_pedido
FROM PEDIDOS
--WHERE fecha_pedido BETWEEN TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2023-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');
-- O  datos de 2024 o 2025:
WHERE fecha_pedido BETWEEN TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2024-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

--WHERE con IS NULL (para valores nulos):
--Clientes sin número de teléfono registrado
SELECT nombre, apellido, telefono
FROM CLIENTES
WHERE telefono IS NULL;

--Productos sin descripción:
SELECT nombre_producto, descripcion
FROM PRODUCTOS
WHERE descripcion IS NULL;

/*WHERE con LIKE (para búsqueda de patrones):
%: representa cero o más caracteres.
_: representa un solo carácter.
Clientes cuyo nombre empieza con 'A':*/
SELECT nombre, apellido
FROM CLIENTES
WHERE nombre LIKE 'A%';

--Productos que contienen la palabra 'Gaming' en su nombre:
SELECT nombre_producto
FROM PRODUCTOS
WHERE nombre_producto LIKE '%Gaming%';

--Clientes con "ana" en su email (sin importar mayúsculas/minúsculas):
SELECT email, nombre
FROM CLIENTES
WHERE LOWER(email) LIKE '%ana%'; -- Usamos LOWER() para hacer la búsqueda case-insensitive

/*ORDER BY (ordenación de resultados):
Clientes ordenados alfabéticamente por apellido y luego por nombre:*/
SELECT nombre, apellido, ciudad
FROM CLIENTES
ORDER BY apellido ASC, nombre ASC; -- ASC es ascendente (por defecto), DESC es descendente

--Productos ordenados de más caro a más barato:
SELECT nombre_producto, precio
FROM PRODUCTOS
ORDER BY precio DESC;

--Detalles de pedido ordenados por ID de pedido y luego por cantidad (descendente):
SELECT pedido_id, producto_id, cantidad
FROM DETALLE_PEDIDO
ORDER BY pedido_id ASC, cantidad DESC;

/* Expresiones Condicionales (CASE):
Permite definir diferentes salidas basadas en condiciones, similar a un "if-then-else".
Clasificar productos por rango de precio:*/
SELECT
    nombre_producto,
    precio,
    CASE
        WHEN precio < 100 THEN 'Económico'
        WHEN precio >= 100 AND precio < 500 THEN 'Precio Medio'
        ELSE 'Premium'
    END AS Categoria_Precio
FROM PRODUCTOS;

--Mostrar el estado del pedido de forma más descriptiva:
SELECT
    pedido_id,
    estado_pedido,
    CASE estado_pedido
        WHEN 'Pendiente' THEN 'Esperando procesamiento'
        WHEN 'Procesando' THEN 'En preparación'
        WHEN 'Enviado' THEN 'En camino al cliente'
        WHEN 'Entregado' THEN 'Recibido por el cliente'
        WHEN 'Cancelado' THEN 'Pedido anulado'
        ELSE 'Estado Desconocido'
    END AS Descripcion_Estado
FROM PEDIDOS;

 /*Uso de Alias
Los alias se usan para darle un nombre temporal a una columna o a una tabla, lo que hace las consultas más legibles.
Alias para columnas:*/
SELECT
    nombre AS Nombre_Cliente,
    apellido AS Apellido_Cliente,
    email AS Correo_Electronico
FROM CLIENTES;

--También se puede usar AS opcionalmente:
SELECT
    nombre Nombre_Cliente,
    apellido Apellido_Cliente
FROM CLIENTES;

--Alias para tablas (muy útil en JOINs y subconsultas):
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
Sintaxis con AS (más legible)*/
SELECT
    nombre AS Nombre_Cliente,
    apellido AS Apellido_Cliente
FROM CLIENTES;

--Sintaxis sin AS (más corta):
SELECT
    nombre Nombre_Cliente,
    apellido Apellido_Cliente
FROM CLIENTES;

/* Alias para Tablas
Esto  permite usar un nombre corto (normalmente una o dos letras) para 
referirte a una tabla. Esto es indispensable para JOINs, donde necesitas 
especificar de qué tabla viene cada columna.*/
SELECT
    c.cliente_id, -- 'c' es el alias para la tabla CLIENTES
    c.nombre,
    c.apellido,
    c.ciudad,
    c.pais
FROM
    CLIENTES c; -- Se define el alias 'c' aquí
/*Como se ver en este ejemplo, en lugar de escribir CLIENTES.cliente_id,
solo usamos c.cliente_id, lo que hace la consulta mucho más limpia.*/

/* Objetivo: Agrupar datos, realizar cálculos sobre esos grupos y filtrar los filas agrupadas.
GROUP BY: Esta cláusula se utiliza para agrupar filas que tienen los mismos valores en las 
columnas especificadas. El propósito principal es poder aplicar funciones de agregación 
(o de grupo) a cada grupo por separado.
Funciones de Grupo: Son funciones que operan en un conjunto de filas y devuelven un único valor
por grupo. Las más comunes son: COUNT(), SUM(), AVG(), MAX() y MIN().*/

/*HAVING: Esta cláusula se utiliza para filtrar los grupos creados por GROUP BY. A diferencia de WHERE 
(que filtra filas individuales antes de la agrupación), HAVING filtra los grupos
después de que se han formado y las funciones de grupo se han aplicado.*/

/*Para contar cuántos pedidos ha realizado cada cliente, 
La consulta agrupa todas las filas de la tabla PEDIDOS por el cliente_id y luego cuenta cuántos 
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
    
/* Uso de HAVING (filtrando grupos)
Para encontrar solo los clientes que han realizado más de un pedido, 
el asistente indica que se debe usar HAVING para filtrar el resultado de la función COUNT():*/
SELECT
    cliente_id,
    COUNT(pedido_id) AS total_pedidos
FROM
    PEDIDOS
GROUP BY
    cliente_id
HAVING
    COUNT(pedido_id) > 1;

/*El INNER JOIN no se limita a unir solo dos tablas. Se pueden unir tantas tablas 
como sean necesarias para obtener la información deseada, siempre que exista una columna 
común entre ellas. Esto se realiza encadenando las cláusulas INNER JOIN.
Objetivo: Obtener información que se encuentra distribuida en tres tablas diferentes, combinando los datos en una sola consulta.
Ejemplo práctico con las tablas de la base de datos:
Para ver el nombre de los clientes, sus pedidos, y los productos específicos 
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
    
    /*Explicación de la consulta:

FROM CLIENTES c: Iniciar la consulta desde la tabla CLIENTES.

INNER JOIN PEDIDOS p ON c.cliente_id = p.cliente_id: Unir la tabla PEDIDOS con 
la tabla CLIENTES, utilizando la columna cliente_id como enlace común.

INNER JOIN DETALLE_PEDIDO dp ON p.pedido_id = dp.pedido_id: Unir el resultado de 
la unión anterior con la tabla DETALLE_PEDIDO, utilizando la columna pedido_id como enlace.

El resultado será una lista donde cada fila contendrá el nombre del cliente y los detalles de cada producto que compró.*/

----------------------------------------------------------------------------------

/*El LEFT JOIN (también conocido como LEFT OUTER JOIN) permite obtener todas las filas de la tabla 
de la izquierda, sin importar si existe una coincidencia en la tabla de la derecha. Las filas 
que no tienen coincidencia en la tabla de la derecha se mostrarán con valores nulos (NULL) en las columnas de esa tabla.

Objetivo: Mostrar todos los clientes, incluyendo aquellos que no han realizado ningún pedido.
Ejemplo práctico con las tablas de la base de datos:
Para ver una lista completa de todos los clientes y, si han hecho un pedido, ver el ID de 
su pedido, es necesario usar un LEFT JOIN. Si se utilizara un INNER JOIN, solo se verían los clientes que tienen al menos un pedido.*/
SELECT
    c.nombre,
    c.apellido,
    p.pedido_id,
    p.estado_pedido
FROM
    CLIENTES c
LEFT JOIN
    PEDIDOS p ON c.cliente_id = p.cliente_id;
    
    /* Explicación de la consulta:
FROM CLIENTES c: La tabla de la izquierda (CLIENTES) es la que se usará como base para el resultado.
LEFT JOIN PEDIDOS p: Unir la tabla PEDIDOS.
ON c.cliente_id = p.cliente_id: La condición de unión sigue siendo la misma.
El resultado de esta consulta mostrará todos los clientes de la tabla CLIENTES. Los clientes que
no han realizado un pedido aparecerán en la lista, pero sus columnas de pedido_id y estado_pedido se mostrarán como NULL.*/
------------------------------------------------------------------------------------------------------

/*El RIGHT JOIN (también conocido como RIGHT OUTER JOIN) funciona de manera opuesta al LEFT JOIN. 
Este tipo de unión permite obtener todas las filas de la tabla de la derecha, sin importar si existe
una coincidencia en la tabla de la izquierda. Las filas de la tabla izquierda que no tienen coincidencia se mostrarán como NULL.
Objetivo: Mostrar todos los productos, incluyendo aquellos que no han sido vendidos en ningún pedido.
Ejemplo práctico con las tablas de la base de datos:
Para ver una lista completa de todos los productos y, si han sido vendidos, ver los detalles de su pedido, se puede usar un RIGHT JOIN.*/
SELECT
    p.nombre_producto,
    dp.pedido_id,
    dp.cantidad
FROM
    DETALLE_PEDIDO dp
RIGHT JOIN
    PRODUCTOS p ON dp.producto_id = p.producto_id;
--Explicación de la consulta:

/*FROM DETALLE_PEDIDO dp: La tabla de la izquierda es DETALLE_PEDIDO.
RIGHT JOIN PRODUCTOS p: La tabla de la derecha (PRODUCTOS) es la que se usará como base para el resultado.
ON dp.producto_id = p.producto_id: La condición de unión.
El resultado de esta consulta mostrará todos los productos de la tabla PRODUCTOS. Los productos que 
no han sido incluidos en ningún detalle de pedido aparecerán en la lista, pero sus columnas de pedido_id y cantidad se mostrarán como NULL.*/
