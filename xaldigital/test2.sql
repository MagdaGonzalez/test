-- Creación de base de datos
-- 1) aerolinea table
CREATE TABLE aerolinea (
     id_aerolinea INT NOT NULL,
     nombre_aerolinea VARCHAR(40) NOT NULL,
     PRIMARY KEY (id_aerolinea),
     UNIQUE (id_aerolinea)
);

-- 2) aeropuerto table 
CREATE TABLE aeropuerto (
     id_aeropuerto INT NOT NULL,
     nombre_aeropuerto VARCHAR(40) NOT NULL,
     PRIMARY KEY (id_aeropuerto),
     UNIQUE (id_aeropuerto)
);

-- 3) movimiento table
CREATE TABLE movimiento (
     id_movimiento INT NOT NULL,
     descripcion VARCHAR(40) NOT NULL,
     PRIMARY KEY (id_movimiento),
     UNIQUE (id_movimiento)
);

-- 4) dia table
CREATE TABLE dia (
     id_aerolinea INT NOT NULL,
     id_aeropuerto INT NOT NULL,
     id_movimiento INT NOT NULL,
     fecha DATE NOT NULL,
     FOREIGN KEY (id_aerolinea) REFERENCES aerolinea (id_aerolinea)
     --FOREIGN KEY (id_aeropuerto) REFERENCES aeropuerto (id_aeropuerto),
	 --FOREIGN KEY (id_movimiento) REFERENCES movimiento (id_movimiento),
     --PRIMARY KEY (id_aerolinea)
);

-- Queries de preguntas

-- 1. ¿Cuál es el nombre aeropuerto 
-- que ha tenido mayor movimiento durante el año?
-- RESPUESTA: Empate, La Paz y Benito Juarez
SELECT a1.nombre_aeropuerto AS "Aeropuerto", COUNT(d1.id_aeropuerto) AS "# Movimientos"
FROM aeropuerto AS a1
  LEFT JOIN dia AS d1
    ON a1.id_aeropuerto = d1.id_aeropuerto
GROUP BY a1.nombre_aeropuerto
ORDER BY COUNT(d1.id_aeropuerto) DESC;

-- 2. ¿Cuál es el nombre aerolínea que ha realizado 
-- mayor número de vuelos durante el año?
-- RESPUESTA: Empate, Aeromar e Interjet 
SELECT a1.nombre_aerolinea AS "Aerolinea", COUNT(d1.id_aerolinea) AS "# Vuelos"
FROM aerolinea AS a1
  LEFT JOIN dia AS d1
    ON a1.id_aerolinea = d1.id_aerolinea
GROUP BY a1.nombre_aerolinea
ORDER BY COUNT(d1.id_aerolinea) DESC;

-- 3. ¿En qué día se han tenido mayor número de vuelos?
-- RESPUESTA: 02/05/21, 6 vuelos
SELECT fecha AS "Fecha", COUNT(*) AS "# Vuelos"
FROM dia 
GROUP BY (fecha)
ORDER BY COUNT(fecha) DESC;

-- 4. ¿Cuáles son las aerolíneas 
-- que tienen más de 2 vuelos por día?
-- RESPUESTA: Aeromar
SELECT aerolinea.nombre_aerolinea
FROM aerolinea
JOIN
(
SELECT id_aerolinea, COUNT(*) as "vuelos"
FROM dia
WHERE id_movimiento = 1
GROUP BY id_aerolinea
HAVING COUNT(*) > 2
) tmp ON aerolinea.id_aerolinea = tmp.id_aerolinea




