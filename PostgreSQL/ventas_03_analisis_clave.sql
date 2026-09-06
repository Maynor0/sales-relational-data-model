
SET search_path TO ventas, public;

-- 1) Resumen general de ventas
SELECT
    COUNT(*) AS total_facturas,
    SUM(precio_venta) AS total_vendido,
    ROUND(AVG(precio_venta), 2) AS ticket_promedio,
    MIN(precio_venta) AS venta_minima,
    MAX(precio_venta) AS venta_maxima,
    SUM(costo_vehiculo) AS costo_total,
    SUM(precio_venta - costo_vehiculo) AS margen_total,
    ROUND(
        100 * SUM(precio_venta - costo_vehiculo)
        / NULLIF(SUM(precio_venta), 0),
        2
    ) AS margen_porcentual
FROM ventas.facturas;

-- 2) Vehículos más vendidos (cantidad)
SELECT
    ve.marca_vehiculo,
    ve.modelo_vehiculo,
    COUNT(*) AS veces_vendido,
    SUM(f.precio_venta) AS total_vendido,
    SUM(f.precio_venta - f.costo_vehiculo) AS margen_total
FROM ventas.facturas AS f
INNER JOIN ventas.vehiculos AS ve
    ON f.id_vehiculo = ve.id_vehiculo
GROUP BY
    ve.marca_vehiculo,
    ve.modelo_vehiculo
ORDER BY veces_vendido DESC
LIMIT 10;

-- 3) Vendedores (top por facturación)
SELECT
    v.id_vendedor,
    v.vendedor,
    COUNT(f.factura) AS total_facturas,
    SUM(f.precio_venta) AS total_vendido,
    SUM(f.precio_venta - f.costo_vehiculo) AS margen_total,
    ROUND(AVG(f.precio_venta), 2) AS ticket_promedio
FROM ventas.vendedores AS v
INNER JOIN ventas.facturas AS f
    ON v.id_vendedor = f.id_vendedor
GROUP BY
    v.id_vendedor,
    v.vendedor
ORDER BY total_vendido DESC
LIMIT 10;

-- 4) Presupuesto vs ventas (mensual por sede)
WITH ventas_mensuales AS (
    SELECT
        EXTRACT(YEAR FROM fecha)::INTEGER AS periodo,
        EXTRACT(MONTH FROM fecha)::INTEGER AS mes,
        id_sede,
        COUNT(*) AS total_facturas,
        SUM(precio_venta) AS ventas_reales
    FROM ventas.facturas
    GROUP BY
        EXTRACT(YEAR FROM fecha),
        EXTRACT(MONTH FROM fecha),
        id_sede
)
SELECT
    s.nombre_sede,
    vm.periodo,
    vm.mes,
    p.presupuesto,
    vm.ventas_reales,
    vm.ventas_reales - p.presupuesto AS variacion,
    ROUND(
        100 * vm.ventas_reales
        / NULLIF(p.presupuesto, 0),
        2
    ) AS cumplimiento_porcentual
FROM ventas_mensuales AS vm
INNER JOIN ventas.presupuestos AS p
    ON vm.periodo = p.periodo
    AND vm.mes = p.mes
    AND vm.id_sede = p.id_sede
INNER JOIN ventas.sedes AS s
    ON vm.id_sede = s.id_sede
ORDER BY
    vm.periodo,
    vm.mes,
    s.nombre_sede;

-- 5) Ranking de las 5 ventas más altas
WITH ranking_ventas AS (
    SELECT
        f.factura,
        f.fecha,
        v.vendedor,
        s.nombre_sede,
        f.precio_venta,
        RANK() OVER (
            ORDER BY f.precio_venta DESC
        ) AS rango
    FROM ventas.facturas AS f
    INNER JOIN ventas.vendedores AS v
        ON f.id_vendedor = v.id_vendedor
    INNER JOIN ventas.sedes AS s
        ON f.id_sede = s.id_sede
)
SELECT *
FROM ranking_ventas
WHERE rango <= 5
ORDER BY rango;