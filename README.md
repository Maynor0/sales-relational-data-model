# Modelo relacional de ventas

## Descripción
Este proyecto documenta la limpieza, estructuración y análisis de una base de ventas compuesta por varias tablas relacionadas.

## Objetivo
Construir un flujo de trabajo completo desde Excel, Power Query, SQL y Power BI para transformar una base de datos en un modelo relacional listo para análisis.

## Herramientas usadas
- Excel
- Power Query
- SQL Server
- Power BI

## Flujo del proyecto

### 1. Excel
Se realizó una limpieza inicial de la base:
- corrección de palabras mal escritas;
- revisión de datos faltantes;
- separación de la información en 6 hojas para representar tablas relacionadas.

Archivo principal:
- `excel/tablas-ventas-limpia.xlsx`

### 2. Power Query
Cada hoja fue trabajada como una tabla independiente, limpia y estructurada para su posterior carga en Power BI.

Detalle técnico:
- `power-query/notas-transformacion.md`

### 3. SQL
La base fue dividida en archivos CSV y posteriormente reconstruida para recrear el modelo relacional de ventas.

Se crearon tablas para vendedores, sedes, canales, facturas, vehículos y presupuesto, además de consultas con `JOIN`, resúmenes, análisis temporal y funciones de ventana.

El modelo fue implementado en dos gestores de bases de datos:

- SQL Server: `sql/Base3.sql`
- PostgreSQL:
  - `postgresql/ventas_01_tablas.sql`
  - `postgresql/ventas_01_cargas.sql`
  - `postgresql/ventas_02_restricciones.sql`
  - `postgresql/ventas_03_analisis_clave.sql`

En PostgreSQL se utilizaron tablas permanentes dentro del esquema `ventas`, carga de CSV mediante `\copy`, claves foráneas y una validación de negocio para garantizar que el precio de venta no sea menor que el costo.

### 4. Power BI
Se construyó un modelo relacional con tablas y medidas para analizar:
- ventas;
- costo;
- margen;
- cumplimiento;
- ticket promedio;
- participación de ventas;
- ranking de vendedores.

También se desarrollaron páginas de análisis por:
- resumen;
- vendedores;
- sedes;
- vehículos.

## Archivos visuales
Las capturas del modelo y de los dashboards se encuentran en:
- `power-bi/capturas/`

## Resultado
El proyecto muestra un flujo completo de preparación, modelado relacional, análisis en SQL y visualización en Power BI, orientado a portafolio profesional de análisis de datos.
