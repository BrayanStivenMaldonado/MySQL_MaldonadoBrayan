use AutoRenta_MaldonadoBrayan;

--                             CONSULTAS

-- 1. Listar todos los vehículos disponibles para alquiler, con sus tipos y modelos
SELECT v.id_vehiculo, v.placa, v.modelo, v.color, tv.tipo 
FROM Vehiculos v
INNER JOIN Tipo_vehiculo tv ON v.id_tipoV = tv.id_tipoV;

-- 2. Obtener los clientes que han realizado alquileres, mostrando su nombre, cédula y la sucursal desde donde alquilaron
SELECT c.nombre1, c.nombre2, c.apellido1, c.apellido2, c.cedula, s.ciudad AS sucursal
FROM Clientes c
INNER JOIN Alquileres a ON c.id_cliente = a.id_cliente
INNER JOIN Sucursales s ON a.id_sucursal = s.id_sucursal;

-- 3. Listar el nombre de todos los carros cuyo motor es un v8
SELECT modelo, placa, motor from vehiculos where motor = 'v8';

-- 4. Mostrar todos los vehiculos ordenados por su número de puertas
select * from vehiculos order by puertas asc;

-- 5. Listar todos los vehiculos con sunroof
select * from vehiculos where sunroof = 'sí';

-- 6. Mostrar todos los vehiculos junto con su tipo
select v.modelo, tv.tipo from vehiculos v 
inner join tipo_vehiculo tv on v.id_tipoV = tv.id_tipoV;

-- 7. Listar el primer apellido de todos los empleados
select apellido1 from empleados;

-- 8. Listar a todos los empleados ordenandolos alfabeticamente, por sus apellidos y luego por sus nombres
select nombre1,nombre2,apellido1,apellido2 from empleados order by 1,2,3,4 asc;

-- 9. Obtener todos los empleados de una sucursal específica 
select * from empleados  where id_sucursal = 2;

-- 10. mostrar a todos los empleados junto con el nombre de la sucursal en la que trabajan
select e.nombre1,e.apellido1,s.ciudad from empleados e
inner join sucursales s on e.id_sucursal = s.id_sucursal;

-- 11. mostrar los vehiculos de un tipo, filtrandolo por su nombre
select v.placa, v.modelo, tv.tipo from vehiculos v
inner join tipo_vehiculo tv on v.id_tipov = tv.id_tipoV
where tv.tipo = 'Deportivo';

-- 12. obtener los alquileres realizados por un cliente en específico
select * from alquileres  where id_cliente = 12;

-- 13. obtener el precio total de todos los alquileres prestados
select sum(valor_pagado) as ingreso_total from alquileres;

-- 14. Listar todos los empleados que tengan el apellido Sanchez
select * from empleados where apellido1 = 'sanchez' or apellido2 = 'sanchez';

-- 15. Lista el nombre y apellidos de los empleados en una única columna.
select concat(nombre1,' ',nombre2,' ',apellido1,' ',apellido2) as empleados  from empleados ;

-- 16. Lista la cantidad de vehiculos que hay disponibles 
select count(*) from vehiculos as Cantidad_vehiculos;

-- 17. obtener los detalles de un alquiler específicio por su id
select * from alquileres where id_alquiler = 20;

-- 18. mostrar los descuentos y al tipo de vehiculo que van aplicados
select d.fecha_inicio, d.fecha_fin, porcentaje_descuento ,tv.tipo from descuentos d
inner join tipo_vehiculo tv on d.id_tipoV = tv.id_tipoV;

-- 19. Obtener la información de un vehiculo por su placa
select * from vehiculos where placa = 'abc123';

-- 20. obtener el total de alquileres realizados en una sucursal
select count(*) as alquileres_totales from alquileres where id_sucursal = 3;

-- 21. mostrar todos los alquileres junto con la sucursal en la que fueron realizados
select a.id_alquiler, a.valor_pagado, s.ciudad from alquileres a
inner join sucursales s on a.id_sucursal = s.id_sucursal; 

-- 22. mostrar la cantidad de alquileres que ha realizado la empresa
select count(*) as total_alquileres from alquileres;

-- 23. listar todos los nombres de las sucursales
select ciudad from sucursales;

-- 24. listar todos los empleados de una sucursal específica
select * from empleados where id_sucursal = 2;

-- 25. Mostrar todos los vehiculos que tenga un color en especifico, ordenandolo alfabeticamente
select modelo from vehiculos
where color = 'rojo'
order by modelo asc;

--                             FUNCIONES
-- 1.
delimiter //
create function resta_valor(valor_cotizado int, valor_pagado int)
returns int
deterministic
begin
	declare diferencia int;
    set diferencia = valor_cotizado - valor_pagado;
    return diferencia;
end //
delimiter ;
select resta_valor (valor_cotizado, valor_pagado) as diferencia from alquileres;


-- 2.
delimiter //
create function  semanas_dias(fecha_inicio date,fecha_cierre date)
returns varchar(150) deterministic
begin
	declare cant_dias_semanas varchar(150);
    declare cant_dias int;
    declare cant_semanas int;
    declare diferencia_dias int;
    
    set diferencia_dias=TIMESTAMPDIFF(day,fecha_inicio,fecha_cierre);
    
    set cant_semanas = floor(diferencia_dias/7);
    
    set cant_dias= diferencia_dias%7;
    
    set cant_dias_semanas=concat('cantidad de semanas: ',cant_semanas,' cantidad de dias: ',cant_dias);
    
    return cant_dias_semanas;
    
end // delimiter ;

select id_alquiler,semanas_dias(fecha_salida,fecha_llegada) from alquileres;

-- 3. Calcular la cantidad de días de retraso en la entrega de un alquiler
DELIMITER //
CREATE FUNCTION total_ingresos_por_vehiculo(vehiculo_id INT)
RETURNS INT deterministic 
BEGIN
    DECLARE total_ingresos INT;
    
    SELECT SUM(valor_pagado)
    INTO total_ingresos
    FROM Alquileres
    WHERE id_vehiculo = vehiculo_id;

    RETURN IFNULL(total_ingresos, 0);
END //
DELIMITER ;
SELECT total_ingresos_por_vehiculo(1) AS ingresos;


/*
-- 4. Obtener el nombre completo de un cliente basado en su ID
DELIMITER //
CREATE FUNCTION nombre_completo_cliente(id_cliente INT)
RETURNS VARCHAR(200) deterministic
BEGIN
    DECLARE nombre_completo VARCHAR(200);
    
    SELECT CONCAT(nombre1, ' ', nombre2, ' ', apellido1, ' ', apellido2)
    INTO nombre_completo
    FROM Clientes
    WHERE id_cliente = id_cliente;

    RETURN nombre_completo;
END //
DELIMITER ;
SELECT nombre_completo_cliente(1) AS nombre;
*/


-- 5 Contar lso vehiculos por cada tipo
DELIMITER //
CREATE FUNCTION contar_vehiculos_por_tipo(tipo_vehiculo_id INT)
RETURNS INT deterministic
BEGIN
    DECLARE cantidad INT;
    
    SELECT COUNT(*)
    INTO cantidad
    FROM Vehiculos
    WHERE id_tipoV = tipo_vehiculo_id;

    RETURN IFNULL(cantidad, 0);
END //
DELIMITER ;

SELECT contar_vehiculos_por_tipo(2) AS vehiculos_disponibles;