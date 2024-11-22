use Ventas;

-- 1. Obtener el total de pedidos realizados por un cliente.
select c.nombre, c.apellido1, count(p.id) as pedidos_realizados from pedido p
inner join cliente c on p.id_cliente = c.id  group by 1,2;

delimiter //
create function pedidos_cliente(id_cliente_r int)
returns int
deterministic
begin
	declare total int;
    select count(id_cliente) into total from pedido
    where id_cliente_r = id_cliente;
    return total;
end //
delimiter ;
select pedidos_cliente(6);

-- 2. Calcular la comisión total ganada por un comercial
select sum(total)*comision as comision_comercial, id_comercial from comercial c
join pedido p on c.id = p.id_comercial
group by 2;

delimiter //
create function total_comision(id_comercialF int)
returns float
deterministic
begin
	declare comision_total_comercial float;
    declare comision_comercial float;
    declare suma_pedidos double;
	
    set suma_pedidos = (select sum(total) from pedido where id_comercial = id_comercialF);
    set comision_comercial = (select comision from comercial where id = id_comercialF);
    set comision_total_comercial = suma_pedidos*comision_comercial;
    return comision_total_comercial;
end //
delimiter ;
select total_comision(1);

-- 3. Obtener el cliente con mayor cantidad de pedidos
select p.id_cliente,c.nombre, c.apellido1, count(c.id) as cantidad_pedidos from cliente c
join pedido p on c.id = p.id_cliente
group by 1,2
order by 3 desc;

delimiter //
create function mayor_pedidos()
returns int
deterministic
begin
	declare cliente_mayor int;
    set cliente_mayor = (select id_cliente from (select sum(total),id_cliente from pedido group by 2 order by 1 desc limit 1) as cliente_mayor_cant_pedidos);
    return cliente_mayor;
end //
delimiter ;
select mayor_pedidos();

-- 4. Contar la cantidad de pedidos realizados en un año específico
select year(fecha) as año, count(p.id) as cantidad_Pedidos from pedido p group by 1;

delimiter //
create function pedidos_realizados_año(año int)
returns int
deterministic
begin
	declare cant_año int;
    set cant_año = (select count(*) from pedido where year(fecha)=año);
    return cant_año;
end //
delimiter ;
select pedidos_realizados_año(2023);

-- 5. Obtener el promedio total de pedidos por cliente
delimiter //
create function promedio_pedidos(id_cliente_r int)
returns float(10,2)
deterministic
begin
	return(select avg(total) from pedido where id_cliente = id_cliente_r);
end //
delimiter ;

select promedio_pedidos(1);