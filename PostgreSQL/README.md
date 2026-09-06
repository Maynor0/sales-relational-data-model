# PostgreSQL 

En esta etapa, el modelo relacional de ventas fue reconstruido y adaptado a PostgreSQL a partir de los archivos CSV generados durante la preparación de datos.

Se crearon tablas dentro del esquema `ventas` para:

- vendedores;
- sedes;
- canales;
- vehículos;
- presupuestos;
- facturas.

El proceso incluye:

- creación del esquema y las tablas;
- carga de archivos CSV mediante `\copy`;
- conversión de los meses del presupuesto de texto a valores numéricos;
- definición de claves primarias y foráneas;
- validación de que el precio de venta sea mayor o igual al costo;
- consultas de análisis con `JOIN`, agregaciones, análisis temporal y funciones de ventana.

Archivos principales:

- `ventas_01_tablas.sql`
- `ventas_01_cargas.sql`
- `ventas_02_restricciones.sql`
- `ventas_03_analisis_clave.sql`