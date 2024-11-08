USE universidad_T2; 

--
SELECT apellido1, apellido2, nombre FROM alumno ORDER BY 1,2,3 ASC;

-- Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
SELECT nombre, apellido1, apellido2, telefono FROM alumno WHERE telefono IS NULL;

-- Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7. 
select * from asignatura where cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

select * from grado
inner join grado on asignatura.id_grado = grado.id 
where grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

select * from alumno al
inner join alumno_se_matricula_asignatura asm on al.id = asm.id_alumno
inner join asignatura a on asm.id_asignatura = a.id
inner join curso_escolar ce on ce.id = asm.id_curso_escolar
where ce.anyo_inicio = '2017' and ce.anyo_fin = '2018';

--                                                                ACTIVIDAD EN CASA

-- 1. Devuelve el número total de alumnas que hay.
select count(sexo) as alumnas from alumno where sexo = 'M';

-- 2. Calcula cuántos alumnos nacieron en 1999
select count(fecha_nacimiento) as alumnos_1999 from alumno where year(fecha_nacimiento) = 1999;

-- 3. Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas,
-- una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. 
-- El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
select dep.nombre, count(p.id_departamento) as num_profesores from profesor p
inner join departamento dep on p.id_departamento = dep.id
group by dep.nombre order by num_profesores desc;

-- 4. Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos.
-- Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.
select dep.nombre, count(p.id_departamento) as num_profesores from departamento dep
left join profesor p on dep.id = p.id_departamento
group by dep.nombre;

-- 5. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno.
-- Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas.
-- Estos grados también tienen que aparecer en el listado.
-- El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
select g.nombre, count(a.id_grado) as cantidad_asignatura from asignatura a
right join grado g on a.id_grado = g.id
group by g.nombre order by cantidad_asignatura desc;

-- 6. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, 
-- de los grados que tengan más de 40 asignaturas asociadas.
select g.nombre, count(a.id_grado) as cantidad_asignatura from grado g
inner join asignatura a on g.id = a.id_grado
group by g.nombre having cantidad_asignatura >= 40;

-- 7. Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura.
-- El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo.
-- Ordene el resultado de mayor a menor por el número total de crédidos.