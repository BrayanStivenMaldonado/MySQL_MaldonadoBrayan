create database AutoRenta_MaldonadoBrayan;
-- drop database AutoRenta_MaldonadoBrayan;
use AutoRenta_MaldonadoBrayan;

CREATE TABLE sucursales (
  id_sucursal INT PRIMARY KEY,
  ubicacion VARCHAR(255),
  ciudad VARCHAR(50) ,
  dirección VARCHAR(50) ,
  telefono_fijo VARCHAR(50) ,
  celular VARCHAR(50) ,
  correo_electronico VARCHAR(255)
);

CREATE TABLE tipo_vehiculo(
	id_tipo_vehiculo INT PRIMARY KEY,
    tipo VARCHAR(250) ,
    valor_alquiler_dia DOUBLE,
    valor_alquiler_semana DOUBLE 
);


CREATE TABLE vehiculos (
  id_vehiculo INT PRIMARY KEY,
  id_tipo_vehiculo INT,
  id_sucursal INT,
  placa VARCHAR(50) ,
  referencia VARCHAR(255),
  modelo VARCHAR(255),
  puertas int,
  capacidad int,
  sunroof BOOLEAN,
  motor VARCHAR(255),
  color VARCHAR(255),
  foreign key (id_tipo_vehiculo) references tipo_vehiculo(id_tipo_vehiculo),
  foreign key (id_sucursal) references sucursales(id_sucursal)
);

CREATE TABLE descuento (
 id_descuento INT PRIMARY KEY,
 id_tipo_vehiculo INT ,
 fecha_inicio DATE,
 fecha_fin DATE,
 porcentaje_descuento DOUBLE,
 foreign key (id_tipo_vehiculo) references tipo_vehiculo(id_tipo_vehiculo) 
 
);

CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY,
  cedula VARCHAR(50) ,
  nombre1 VARCHAR(255) ,
  nombre2 VARCHAR(255) ,
  apellido1 VARCHAR(255) ,
  apellido2 VARCHAR(255) ,
  ubicacion VARCHAR(255),
  ciudad VARCHAR(50) ,
  celular VARCHAR(50) ,
  correo_electronico VARCHAR(255)
);

CREATE TABLE empleados (
  id_empleado INT PRIMARY KEY,
  Id_sucursal INT ,
  cedula VARCHAR(50) ,
  nombre1 VARCHAR(255) ,
  nombre2 VARCHAR(255) ,
  apellido1 VARCHAR(255) ,
  apellido2 VARCHAR(255) ,
  ubicacion VARCHAR(255),
  ciudad VARCHAR(50) ,
  celular VARCHAR(50) ,
  correo_electronico VARCHAR(255) ,
  foreign key (id_sucursal) references sucursales(id_sucursal)
);

CREATE TABLE alquileres (
  id_alquiler INT PRIMARY KEY,
  id_vehiculo INT ,
  id_empleado INT ,
  id_sucursal INT ,
  id_cliente INT,
  fecha_salida  DATE ,
  fecha_esperada_entrega DATE,
  fecha_entrega  DATE ,
  valor_cotizado DECIMAL(10, 2) ,
  valor_pagado DECIMAL(10, 2),
   foreign key (id_vehiculo) references vehiculos(id_vehiculo),
   foreign key (id_empleado) references empleados(id_empleado),
   foreign key (id_sucursal) references sucursales(id_sucursal),
   foreign key (id_sucursal) references sucursales(id_sucursal)
);



