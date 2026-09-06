
-- Ejecutar dentro de psql con: \i ruta/ventas_01_cargas.sql

-- 1) Cargar vehículos (con codificación WIN1252)

\copy ventas.vehiculos (id_vehiculo,marca_vehiculo,modelo_vehiculo,tipo_vehiculo,anio_vehiculo) FROM 'C:/Users/Usuario/Desktop/PY/CURSOS/PostgreSQL/base3/ID_Auto.csv' WITH (FORMAT csv,HEADER true,DELIMITER ';',ENCODING 'WIN1252');

-- 2) Cargar presupuestos vía tabla temporal (mes en texto -> número)
DROP TABLE IF EXISTS ventas.presupuestos_tmp;

CREATE TABLE ventas.presupuestos_tmp (
    periodo INTEGER,
    mes_texto TEXT,
    id_sede INTEGER,
    presupuesto NUMERIC(12,2)
);

\copy ventas.presupuestos_tmp (periodo,mes_texto,id_sede,presupuesto) FROM 'C:/Users/Usuario/Desktop/PY/CURSOS/PostgreSQL/base3/Presupuesto.csv' WITH (FORMAT csv,HEADER true,DELIMITER ';',ENCODING 'WIN1252');

INSERT INTO ventas.presupuestos (periodo, mes, id_sede, presupuesto)
SELECT
    periodo,
    CASE lower(mes_texto)
        WHEN 'enero'       THEN 1
        WHEN 'febrero'     THEN 2
        WHEN 'marzo'       THEN 3
        WHEN 'abril'       THEN 4
        WHEN 'mayo'        THEN 5
        WHEN 'junio'       THEN 6
        WHEN 'julio'       THEN 7
        WHEN 'agosto'      THEN 8
        WHEN 'septiembre'  THEN 9
        WHEN 'octubre'     THEN 10
        WHEN 'noviembre'   THEN 11
        WHEN 'diciembre'   THEN 12
        ELSE NULL
    END AS mes,
    id_sede,
    presupuesto
FROM ventas.presupuestos_tmp;

DROP TABLE IF EXISTS ventas.presupuestos_tmp;

-- 3) Cargar facturas (después de tener vehículos y sedes cargados)

\copy ventas.facturas (factura,fecha,id_canal,cliente,tipo_cliente,id_vehiculo,costo_vehiculo,precio_venta,id_sede,id_vendedor) FROM 'C:/Users/Usuario/Desktop/PY/CURSOS/PostgreSQL/base3/Facturas.csv' WITH (FORMAT csv,HEADER true,DELIMITER ';',ENCODING 'WIN1252');