-- ========= SCRIPT DE CREACIÓN DE TABLAS DE ANIME =========

-- Tabla principal de Animes
CREATE TABLE Animes (
    anime_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR2(100) NOT NULL
);

-- Tabla de Personajes
-- Aquí se establece la relación 1:N (Uno a Muchos)
-- Un Anime puede tener MUCHOS Personajes.
CREATE TABLE Personajes (
    personaje_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_personaje VARCHAR2(100) NOT NULL,
    anime_id INT NOT NULL,
    CONSTRAINT fk_personaje_anime FOREIGN KEY (anime_id) REFERENCES Animes(anime_id)
);

-- Tabla de Datos Biográficos
-- Aquí se establece la relación 1:1 (Uno a Uno)
-- Un Personaje tiene UNA sola ficha de datos biográficos.
-- La clave es que la FK (personaje_id) es también la PK y es ÚNICA.
CREATE TABLE Datos_Biograficos (
    personaje_id INT NOT NULL,
    planeta_origen VARCHAR2(100),
    raza VARCHAR2(100),
    CONSTRAINT pk_datos_biograficos PRIMARY KEY (personaje_id),
    CONSTRAINT fk_bio_personaje FOREIGN KEY (personaje_id) REFERENCES Personajes(personaje_id)
);

-- Tabla de Habilidades
CREATE TABLE Habilidades (
    habilidad_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_habilidad VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(500)
);

-- Tabla de rompimiento Personaje_Habilidades
-- Aquí se establece la relación N:M (Muchos a Muchos)
-- Un Personaje puede tener MUCHAS Habilidades.
-- Una Habilidad puede ser usada por MUCHOS Personajes.
CREATE TABLE Personaje_Habilidades (
    personaje_id INT NOT NULL,
    habilidad_id INT NOT NULL,
    CONSTRAINT pk_personaje_habilidad PRIMARY KEY (personaje_id, habilidad_id),
    CONSTRAINT fk_ph_personaje FOREIGN KEY (personaje_id) REFERENCES Personajes(personaje_id),
    CONSTRAINT fk_ph_habilidad FOREIGN KEY (habilidad_id) REFERENCES Habilidades(habilidad_id)
);

PROMPT ¡Todas las tablas de anime fueron creadas exitosamente!;
/

-- ========= SCRIPT DE INSERCIÓN DE DATOS DE ANIME =========

-- Insertar los 8 Animes
INSERT INTO Animes (titulo) VALUES ('My Hero Academia');
INSERT INTO Animes (titulo) VALUES ('Naruto');
INSERT INTO Animes (titulo) VALUES ('Dragon Ball');
INSERT INTO Animes (titulo) VALUES ('One-Punch Man');
INSERT INTO Animes (titulo) VALUES ('Attack on Titan');
INSERT INTO Animes (titulo) VALUES ('Jujutsu Kaisen');
INSERT INTO Animes (titulo) VALUES ('Los Siete Pecados Capitales');
INSERT INTO Animes (titulo) VALUES ('Record of Ragnarok');

-- Insertar Personajes (30 en total)
-- My Hero Academia (IDs 1-4)
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Izuku Midoriya', 1);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Katsuki Bakugo', 1);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Shoto Todoroki', 1);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('All Might', 1);
-- Naruto (IDs 5-9)
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Naruto Uzumaki', 2);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Sasuke Uchiha', 2);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Sakura Haruno', 2);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Kakashi Hatake', 2);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Itachi Uchiha', 2);
-- Dragon Ball (IDs 10-14)
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Goku', 3);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Vegeta', 3);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Gohan', 3);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Piccolo', 3);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Freezer', 3);
-- One-Punch Man (IDs 15-17)
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Saitama', 4);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Genos', 4);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Tatsumaki', 4);
-- Attack on Titan (IDs 18-21)
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Eren Yeager', 5);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Mikasa Ackerman', 5);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Levi Ackerman', 5);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Armin Arlert', 5);
-- Jujutsu Kaisen (IDs 22-24)
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Yuji Itadori', 6);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Satoru Gojo', 6);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Megumi Fushiguro', 6);
-- Los Siete Pecados Capitales (IDs 25-27)
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Meliodas', 7);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Ban', 7);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Escanor', 7);
-- Record of Ragnarok (IDs 28-30)
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Lu Bu', 8);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Thor', 8);
INSERT INTO Personajes (nombre_personaje, anime_id) VALUES ('Zeus', 8);

-- Insertar Datos Biográficos (para la relación 1:1)
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (5, 'Konoha', 'Humano (Jinchuriki)');
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (10, 'Planeta Vegeta', 'Saiyan');
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (11, 'Planeta Vegeta', 'Saiyan');
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (13, 'Namek', 'Namekiano');
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (15, 'Tierra', 'Humano');
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (25, 'Reino Demonio', 'Demonio');
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (27, 'Reino de Castellio', 'Humano');
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (29, 'Asgard', 'Dios');
INSERT INTO Datos_Biograficos (personaje_id, planeta_origen, raza) VALUES (30, 'Olimpo', 'Dios');
-- (y así sucesivamente para los personajes que quieras detallar)

-- Insertar Habilidades
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Kamehameha', 'Rayo de energía de ki concentrado.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Rasengan', 'Esfera de chakra que gira a gran velocidad.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Sharingan', 'Dojutsu que permite copiar técnicas y prever movimientos.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('One For All', 'Don que acumula poder y puede ser transferido.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Explosion', 'El sudor del usuario se vuelve nitroglicerina y explota.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Mitad Frío, Mitad Caliente', 'Control sobre el hielo y el fuego.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Golpe Normal Consecutivo', 'Serie de golpes a una velocidad devastadora.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Titan de Ataque', 'Habilidad de transformarse en un Titán con instinto de lucha.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Maniobra Tridimensional', 'Equipo para moverse a alta velocidad en el aire.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Infinito', 'Técnica que manipula el espacio a nivel atómico.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Full Counter', 'Refleja cualquier ataque mágico con el doble de poder.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Sunshine', 'El poder del usuario alcanza su máximo al mediodía.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Mjolnir', 'Martillo divino que solo puede ser levantado por el digno.');
INSERT INTO Habilidades (nombre_habilidad, descripcion) VALUES ('Chidori', 'Concentración de chakra de rayo en la mano.');

-- Asignar Habilidades a Personajes (la relación N:M)
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (1, 4); -- Midoriya -> One For All
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (2, 5); -- Bakugo -> Explosion
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (3, 6); -- Todoroki -> Mitad Frío, Mitad Caliente
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (4, 4); -- All Might -> One For All
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (5, 2); -- Naruto -> Rasengan
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (6, 3); -- Sasuke -> Sharingan
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (6, 15);-- Sasuke -> Chidori
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (8, 3); -- Kakashi -> Sharingan
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (8, 15);-- Kakashi -> Chidori
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (9, 3); -- Itachi -> Sharingan
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (10, 1); -- Goku -> Kamehameha
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (12, 1); -- Gohan -> Kamehameha
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (15, 7); -- Saitama -> Golpe Normal Consecutivo
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (18, 8); -- Eren -> Titan de Ataque
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (19, 9); -- Mikasa -> Maniobra Tridimensional
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (20, 9); -- Levi -> Maniobra Tridimensional
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (23, 10);-- Gojo -> Infinito
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (25, 11);-- Meliodas -> Full Counter
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (27, 12);-- Escanor -> Sunshine
INSERT INTO Personaje_Habilidades (personaje_id, habilidad_id) VALUES (29, 13);-- Thor -> Mjolnir

COMMIT;
/

SELECT * 
FROM Personajes;
select * from Animes;
select * from Habilidades;
select * from Personaje_Habilidades;
select * from datos_biograficos;

/*
estructura de consultas:
1) SELECT 
2) FROM 
3) JOIN 
4) WHERE 
5) GROUP BY 
6)HAVING 
7) ORDER BY

orden d joins
FROM Tabla_A a
JOIN Tabla_B b ON a.id = b.fk_a_id
JOIN Tabla_C c ON b.id = c.fk_b_id
JOIN Tabla_D d ON c.id = d.fk_c_id;
*/

-- con iner join
select 'Anime: '||'['|| a.titulo || '] Nombre: '||   p.nombre_personaje ||'. Raza: '|| db.raza || '. Habilidad Principal:' || h.nombre_habilidad 
as ficha_de_poder
from Animes a
join Personajes p on a.anime_id = p.anime_id
LEFT JOIN Datos_Biograficos db ON p.personaje_id = db.personaje_id
join Personaje_Habilidades ph ON p.personaje_id = ph.personaje_id
join Habilidades h on db.personaje_id = h.habilidad_id
where a.titulo IN ('Naruto', 'Dragon Ball', 'My Hero Academia')
order by a.titulo asc, p.nombre_personaje 
;


SELECT
    '[' || a.titulo || '] ' || p.nombre_personaje || ' - Raza: ' || NVL(db.raza, 'Desconocida') AS "Ficha Parcial"
FROM
    Animes a
JOIN
    Personajes p ON a.anime_id = p.anime_id
LEFT JOIN -- <<-- ¡AQUÍ ESTÁ EL CAMBIO!
    Datos_Biograficos db ON p.personaje_id = db.personaje_id
WHERE
    a.titulo IN ('Naruto', 'Dragon Ball', 'My Hero Academia'); 


 
SELECT
    a.titulo,
    COUNT(p.personaje_id) AS "Cantidad_de_Personajes",
    COUNT(DISTINCT ph.habilidad_id) AS "Habilidades_Unicas"
FROM
    Animes a
JOIN
    Personajes p ON a.anime_id = p.anime_id
LEFT JOIN -- Usamos LEFT JOIN por si un anime no tiene habilidades registradas
    Personaje_Habilidades ph ON p.personaje_id = ph.personaje_id
GROUP BY
    a.titulo -- Agrupamos por el título del anime
HAVING
    COUNT(p.personaje_id) > 3 -- Filtramos los grupos con más de 3 personajes
ORDER BY
    "Habilidades_Unicas" DESC; -- Ordenamos por la nueva columna calculada