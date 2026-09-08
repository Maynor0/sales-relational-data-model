# Medidas DAX — Power Pivot

```DAX
Total_Ventas :=
SUM ( facturas[Precio_Venta] )
```

```DAX
Total_Costo :=
SUM ( facturas[Costo_Vehiculo] )
```

```DAX
Margen :=
[Total_Ventas] - [Total_Costo]
```

```DAX
Cantidad_Facturas :=
COUNTROWS ( facturas )
```

```DAX
Ticket_Promedio :=
DIVIDE ( [Total_Ventas], [Cantidad_Facturas], 0 )
```

```DAX
Presupuesto_Total :=
SUM ( presupuesto[Presupuesto] )
```

```DAX
Cumplimiento_% :=
DIVIDE ( [Total_Ventas], [Presupuesto_Total], 0 )
```

```DAX
Participacion_Ventas_% :=
DIVIDE (
    [Total_Ventas],
    CALCULATE ( [Total_Ventas], ALL ( vendedores[Vendedor] ) ),
    0
)
```

```DAX
Ranking_Vendedor :=
RANKX (
    ALL ( vendedores[Vendedor] ),
    [Total_Ventas],
    ,
    DESC,
    DENSE
)
```