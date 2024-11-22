use Ventas;

-- 1. Obtener el total de pedidos realizados por un cliente.
select c.nombre, c.apellido1, count(p.id) as pedidos_realizados from pedido p
inner join cliente c on p.id_cliente = c.id  group by 1,2;

-- 2. Calcular la comisión total ganada por un comercial
select sum(total)*comision as comision_comercial, id_comercial from comercial c
join pedido p on c.id = p.id_comercial
group by 2;

-- 3. Obtener el cliente con mayor cantidad de pedidos
select c.nombre, c.apellido1, count(c.id) as cantidad_pedidos from cliente c
join pedido p on c.id = p.id_cliente
group by 1,2
order by 3 desc
limit 3;

-- 4. Contar la cantidad de pedidos realizados en un año específico
select * from pedido;

select year(fecha) as año, count(p.id) as cantidad_Pedidos from pedido p group by 1;

-- 5. Obtener el promedio total de pedidos por cliente
Delimiter //
create procedure Promedio_pedidos()
begin
declare sumaT int;

set SumaT	

end
Delimiter // ;