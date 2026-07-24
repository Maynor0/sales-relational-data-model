# Notas de transformación en Power Query

## Objetivo
Preparar las tablas de la base 3 para su uso en Power BI mediante una estructura limpia, separada y consistente.

## Origen de los datos
El archivo trabajado en esta etapa fue:

- `excel/tablas-ventas-limpia.xlsx`

Este archivo ya contenía la información organizada por hojas para representar distintas tablas del modelo.

## Enfoque de trabajo
En Power Query se importó cada hoja del archivo Excel como una consulta independiente.  
El objetivo fue validar la estructura de cada tabla, mantener consistencia en nombres y tipos de datos, y dejar todo listo para el modelo relacional en Power BI.

## Tablas trabajadas
Se cargaron y estructuraron tablas para las siguientes entidades:

- Factura
- Vendedores
- Sedes
- Canales
- Vehículos
- Presupuesto

## Transformaciones realizadas
Las transformaciones aplicadas se enfocaron en la preparación del modelo:

- revisión de nombres de columnas;
- validación de tipos de datos;
- comprobación de consistencia entre identificadores;
- revisión de datos faltantes ya corregidos en Excel;
- mantenimiento de una tabla por consulta;
- preparación de tablas limpias para su relación posterior en Power BI.

## Criterio de organización
Cada hoja del archivo Excel se mantuvo como una tabla independiente dentro de Power Query.  
Esto permitió conservar una estructura más clara, facilitar el modelado y evitar trabajar con una sola tabla ancha.

## Resultado
Al finalizar esta etapa, cada entidad quedó como una tabla limpia y estructurada, lista para relacionarse en Power BI mediante un modelo de datos.

## Uso posterior
Las tablas preparadas en Power Query fueron utilizadas posteriormente en Power BI para:

- construir relaciones entre tablas;
- incorporar la tabla calendario;
- crear medidas de ventas, costo, margen y cumplimiento;
- desarrollar visualizaciones por sede, canal, vehículo y vendedor.

## Observación
En esta etapa, Power Query se utilizó como puente entre la limpieza inicial en Excel y el modelado final en Power BI.