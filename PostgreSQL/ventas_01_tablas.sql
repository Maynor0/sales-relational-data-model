
DROP SCHEMA IF EXISTS ventas CASCADE;

CREATE SCHEMA ventas;

CREATE TABLE ventas.vendedores (
    id_vendedor INTEGER PRIMARY KEY,
    vendedor VARCHAR(50) NOT NULL,
    lugar_nacimiento VARCHAR(50)
);

CREATE TABLE ventas.sedes (
    id_sede INTEGER PRIMARY KEY,
    nombre_sede VARCHAR(50) NOT NULL,
    ubicacion_sede VARCHAR(50) NOT NULL
);

CREATE TABLE ventas.canales (
    id_canal INTEGER PRIMARY KEY,
    tipo_canal VARCHAR(50) NOT NULL,
    canal VARCHAR(100) NOT NULL
);

CREATE TABLE ventas.vehiculos (
    id_vehiculo INTEGER PRIMARY KEY,
    marca_vehiculo VARCHAR(50) NOT NULL,
    modelo_vehiculo VARCHAR(50) NOT NULL,
    tipo_vehiculo VARCHAR(50),
    anio_vehiculo INTEGER CHECK (anio_vehiculo BETWEEN 1900 AND 2100)
);

CREATE TABLE ventas.presupuestos (
    periodo INTEGER NOT NULL,
    mes INTEGER NOT NULL CHECK (mes BETWEEN 1 AND 12),
    id_sede INTEGER NOT NULL,
    presupuesto NUMERIC(12,2) NOT NULL CHECK (presupuesto >= 0),

    PRIMARY KEY (periodo, mes, id_sede),

    CONSTRAINT fk_presupuesto_sede
        FOREIGN KEY (id_sede)
        REFERENCES ventas.sedes(id_sede)
);

CREATE TABLE ventas.facturas (
    factura INTEGER PRIMARY KEY,
    fecha DATE NOT NULL,
    id_canal INTEGER NOT NULL,
    cliente INTEGER,
    tipo_cliente VARCHAR(50),
    id_vehiculo INTEGER NOT NULL,
    costo_vehiculo NUMERIC(12,2) NOT NULL CHECK (costo_vehiculo >= 0),
    precio_venta NUMERIC(12,2) NOT NULL CHECK (precio_venta >= 0),
    id_sede INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL
);

--

INSERT INTO ventas.vendedores
    (id_vendedor, vendedor, lugar_nacimiento)
VALUES
    (1, 'Linda Caicedo', 'Colombia'),
    (2, 'Maribel Dominguez', 'Mexico'),
    (3, 'Teofilo Cubillas', 'Peru'),
    (4, 'Falcao Garcia', 'Colombia'),
    (5, 'Adriana Lucar', 'Peru'),
    (6, 'Paolo Guerrero', 'Peru'),
    (7, 'Sergio Agüero', 'Argentina'),
    (8, 'Hugo Sanchez', 'Mexico'),
    (9, 'James Rodriguez', 'Colombia'),
    (10, 'Julian Alvarez', 'Argentina'),
    (11, 'Rafael Marquez', 'Mexico'),
    (12, 'Estefania Banini', 'Argentina');

INSERT INTO ventas.sedes
    (id_sede, nombre_sede, ubicacion_sede)
VALUES
    (1, 'Bogota', 'Colombia'),
    (2, 'Mexico DF', 'Mexico'),
    (3, 'Lima', 'Peru'),
    (4, 'Miami', 'Estados Unidos');

INSERT INTO ventas.canales
    (id_canal, tipo_canal, canal)
VALUES
    (1, 'Publicidad', 'Publicidad en Google'),
    (2, 'Publicidad', 'Publicidad en Facebook'),
    (3, 'Otros', 'Desconocido'),
    (4, 'Referido', 'Referido por otro Cliente');

--