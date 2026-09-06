
-- 1) Llaves foráneas

ALTER TABLE ventas.facturas
ADD CONSTRAINT fk_factura_canal
FOREIGN KEY (id_canal)
REFERENCES ventas.canales(id_canal);

ALTER TABLE ventas.facturas
ADD CONSTRAINT fk_factura_vehiculo
FOREIGN KEY (id_vehiculo)
REFERENCES ventas.vehiculos(id_vehiculo);

ALTER TABLE ventas.facturas
ADD CONSTRAINT fk_factura_sede
FOREIGN KEY (id_sede)
REFERENCES ventas.sedes(id_sede);

ALTER TABLE ventas.facturas
ADD CONSTRAINT fk_factura_vendedor
FOREIGN KEY (id_vendedor)
REFERENCES ventas.vendedores(id_vendedor);

-- 2) Restricción de negocio: precio de venta >= costo del vehículo

ALTER TABLE ventas.facturas
ADD CONSTRAINT chk_precio_mayor_costo
CHECK (precio_venta >= costo_vehiculo);