use triggers_eventos_t2;

-- 1. Listar todos los paises:
select * from countries;

-- 2. Obtener todos los departamentos:
select * from departments;

-- 3. Listar el titulo y salario mínimo de todos los trabajos:
select job_title, min_salary from jobs;

-- 4. Lista de dependientes junto con los datos de los empleados a los que estén asociados:
select e.first_name, e.last_name, dep.* from  employees e
inner join dependents dep on dep.employee_id = e.employee_id;

-- 5. Salario promedio por departamento y ciudad:
select * from jobs j 
join employees e on j.job_id = e.job_id;

select d.department_name, l.city, avg(e.salary) as avg_salary
from departments d 
join employees e on d.department_id = e.department_id
join locations l on d.location_id = l.location_id
group by d.department_name, l.city
order by avg_salary desc;


-- 6. Lista de empleos con su trabajo, departamento y ubicación:
select e.first_name,e.last_name,j.job_title,d.department_name,l.street_address from jobs j 
inner join employees e on e.job_id=j.job_id 
inner join departments d  on e.department_id=d.department_id
inner join locations l on d.location_id=l.location_id ;

-- FUNCIONES 
-- 1. Obtener el nombre de un país por su ID

DELIMITER //
create function obtenerPais_Nombre(country_id_i char(2))
returns varchar(50) 
deterministic
begin 
	declare country_name_r varchar(50);
    select country_name
    into country_name_r
    from countries
    where country_id = country_id_i;
    return country_name_r;
end//
DELIMITER ;

select obtenerPais_Nombre('FR');


-- PROCEDIMIENTO
-- 1. Insertar una nueva region
-- insert into regions(region_name) values('Africa');
DELIMITER //
create procedure insertarRegion(in nombre_region varchar(50))
begin
 insert into regions(region_name) values(nombre_region);
end
// DELIMITER ;

call insertarRegion('Africa');

select * from regions;