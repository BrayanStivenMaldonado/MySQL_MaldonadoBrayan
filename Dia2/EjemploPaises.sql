CREATE DATABASE T2_paises; -- Crear una base de datos

USE T2_paises; -- Utilizr mi BBDD

CREATE TABLE Pais (
id INT PRIMARY KEY NOT NULL,
nombre VARCHAR(20) NOT NULL,
continente VARCHAR(50) NOT NULL,
poblacion INT NOT NULL
); -- Creación Tabla País

CREATE TABLE Ciudad (
id INT PRIMARY KEY NOT NULL,
nombre VARCHAR(45) NOT NULL,
id_pais INT NOT NULL,
FOREIGN KEY (id_pais) REFERENCES Pais(id_pais)
); -- Creación tabla Ciudad
    
CREATE TABLE Idioma(
id INT PRIMARY KEY NOT NULL,
idioma VARCHAR(50)
);

CREATE TABLE idioma_pais(
id_idioma INT NOT NULL,
id_pais INT NOT NULL,
es_oficial TINYINT,
PRIMARY KEY (id_idioma,id_pais),
FOREIGN KEY (id_idioma) REFERENCES Idioma(id),
FOREIGN KEY (id_pais) REFERENCES Pais(id_pais)
);

DESCRIBE idioma_pais; -- Describir tabla
SELECT * from Idioma;
SELECT * from Pais;
INSERT INTO Idioma (id,idioma) VALUES (1,'Español');
INSERT INTO Idioma (id,idioma) VALUES (2,'Ingles'),(3, 'Francés');

insert into Pais (id_pais,nombre,continente,poblacion)
values (1, 'México', 'América', 126000000),
(2, 'Estados Unidos', 'América', 331000000),
(3, 'Francia', 'Europa', 67000000),
(4, 'Canadá', 'América', 38000000);

-- Español es el lenguaje oficial de México
insert into idioma_pais (id_idioma,id_pais,es_oficial) VALUES (1,1,1);

-- Ingles no es el leguaje oficial de Mexico 
insert into idioma_pais (id_idioma,id_pais,es_oficial) VALUES (2,1,0);

-- truncate table idioma_pais; -- Eliminar todos los datos de la tabla 
-- drop table idioma_pais; -- Eliminar toda la tabla

 -- Inglés es oficial en Estados Unidos
INSERT INTO idioma_pais(id_idioma,id_pais,es_oficial) VALUES (2,2,1);
 
 -- Español no es oficial en Estados Unidos
INSERT INTO idioma_pais(id_idioma,id_pais,es_oficial) VALUES (1,2,0);

-- Francés es oficial en Francia
INSERT INTO idioma_pais(id_idioma,id_pais,es_oficial) VALUES (3,3,1); 

-- Inglés es oficial en Canadá
INSERT INTO idioma_pais(id_idioma,id_pais,es_oficial) VALUES (2,4,1); 

 -- Francés es oficial en Canadá
INSERT INTO idioma_pais(id_idioma,id_pais,es_oficial) VALUES (3,4,1);

SELECT * FROM idioma_pais;

-- 1. Listar todos los idiomas 
SELECT * FROM Idioma;
SELECT idioma FROM Idioma;

-- 2. Listar el idioma con ID 1
SELECT * FROM Idioma WHERE id=1;
SELECT idioma  FROM Idioma WHERE id=1;

-- 3. Consultar los pauses que esten en America
SELECT nombre FROM Pais WHERE continente = 'América';
SELECT * FROM Pais WHERE continente = 'América';
SELECT nombre AS NombrePais FROM Pais WHERE continente = 'América';

-- SUBCONSULTAS 
-- 4. Subconsulta que encuentre los idiomas oficiales 
select idioma from Idioma WHERE id IN (SELECT id_idioma FROM idioma_pais WHERE es_oficial =1);