#Modelo relacional de ventas

## Descripción

Este proyecto documenta la limpieza, estructuración y análisis de una base de
ventas compuesta por varias tablas relacionadas.

## Objetivo

Construir un flujo de trabajo completo desde Excel, Power Query, SQL Server,
PostgreSQL, Power BI y Power Pivot para transformar una base de datos en un
modelo relacional listo para análisis.

## Herramientas usadas

- Excel
- Power Query
- Power Pivot
- DAX
- SQL Server
- PostgreSQL
- Power BI

## Flujo del proyecto

### 1. Excel

Se realizó una limpieza inicial de la base:

- corrección de palabras mal escritas;
- revisión de datos faltantes;
- separación de la información en seis hojas para representar tablas relacionadas.

Archivo principal:

- `excel/tablas-ventas-limpia.xlsx`

### 2. Power Query

Cada hoja fue trabajada como una tabla independiente, limpia y estructurada
para su posterior carga en Power BI y Excel.

Detalle técnico:

- `power-query/notas-transformacion.md`

### 3. SQL

La base fue dividida en archivos CSV y posteriormente reconstruida para recrear
el modelo relacional de ventas.

Se crearon tablas para:

- vendedores;
- sedes;
- canales;
- facturas;
- vehículos;
- presupuesto.

También se crearon consultas con `JOIN`, agregaciones, análisis temporal y
funciones de ventana.

El modelo fue implementado en dos gestores de bases de datos:

- SQL Server: `sql/Base3.sql`
- PostgreSQL:
  - `postgresql/ventas_01_tablas.sql`
  - `postgresql/ventas_01_cargas.sql`
  - `postgresql/ventas_02_restricciones.sql`
  - `postgresql/ventas_03_analisis_clave.sql`

En PostgreSQL se utilizaron tablas permanentes dentro del esquema `ventas`,
carga de CSV mediante `\copy`, claves foráneas y una validación de negocio para
garantizar que el precio de venta no sea menor que el costo.

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

Archivos visuales:

- `power-bi/capturas/`
- `power-bi/medidas_dax.md`

### 5. Power Pivot y DAX en Excel

Se reutilizó el modelo relacional de ventas dentro de Excel mediante Power
Pivot y el Modelo de datos.

Las tablas de vendedores, sedes, canales, facturas, vehículos, presupuesto y
calendario se cargaron al modelo y se relacionaron mediante sus claves.

Se crearon medidas DAX para analizar:

- ventas totales;
- costo total;
- margen;
- número de facturas;
- ticket promedio;
- presupuesto;
- cumplimiento;
- participación de ventas;
- ranking de vendedores.

El resultado se presentó mediante:

- tablas dinámicas;
- gráficos dinámicos;
- KPIs;
- segmentadores por canal, sede, vendedor, trimestre y año.

Archivos relacionados:

- `power-pivot/venta_powerpivot.xlsx`
- `power-pivot/medidas_dax.md`
- `power-pivot/capturas/`

## Archivos visuales

Las capturas del modelo y de los dashboards se encuentran en:

- `power-bi/capturas/`
- `power-pivot/capturas/`

## Resultado

El proyecto muestra un flujo completo de preparación, modelado relacional,
análisis y visualización de datos:

```text
Excel
→ Power Query
→ SQL Server / PostgreSQL
→ Power BI
→ Power Pivot y DAX en Excel
```

La Base 3 demuestra capacidades de:

- limpieza y transformación de datos;
- validación y organización de información;
- modelado relacional;
- consultas SQL;
- implementación en SQL Server y PostgreSQL;
- creación de medidas DAX;
- construcción de dashboards en Power BI;
- creación de tablas dinámicas, gráficos dinámicos y segmentadores en Excel.
