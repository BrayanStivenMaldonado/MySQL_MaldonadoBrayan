CREATE DATABASE migrupoT2;
USE migrupoT2; 

CREATE TABLE vehiculos(
id_vehiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
marca VARCHAR(20) NOT NULL,
modelo VARCHAR(20) NOT NULL,
año INT NOT NULL,
numero_de_serie INT NOT NULL,
precio INT NOT NULL,
color VARCHAR(10) NOT NULL,
tipo_de_combustible VARCHAR(25) NOT NULL,
tipo_de_transmision VARCHAR(30) NOT NULL,
estado VARCHAR(10) NOT NULL
);

CREATE TABLE clientes (
id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
telefono INT NOT NULL,
email VARCHAR(20),
direccion VARCHAR(20)
);

CREATE TABLE vendedores (
id_vendedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
num_empleado INT NOT NULL,
fecha_contratacion DATE NOT NULL
);

CREATE TABLE ventas (
id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
id_vendedor INT NOT NULL,
id_vehiculo INT NOT NULL,
fecha_venta DATE NOT NULL,
total_transaccion INT NOT NULL,
metodo_pago VARCHAR(10) NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

CREATE TABLE mantenimiento (
id_mantenimiento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
id_vehiculo INT NOT NULL,
tipo_servicio VARCHAR(20) NOT NULL,
costo INT NOT NULL,
fecha_servicio DATE NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);
