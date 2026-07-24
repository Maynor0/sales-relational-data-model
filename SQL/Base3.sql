create table #ID_Vendedores (
	ID_Vendedor int,
	Vendedor varchar(50),
	Lugar_Nacimiento varchar(50)
);

insert into #ID_Vendedores (ID_Vendedor, Vendedor, Lugar_Nacimiento) values 
('1','Linda Caicedo','Colombia'),
('2','Maribel Dominguez','Mexico'),
('3','Teofilo Cubillas','Peru'),
('4','Falcao Garcia','Colombia'),
('5','Adriana Lucar','Peru'),
('6','Paolo Guerrero','Peru'),
('7','Sergio Agüero','Argentina'),
('8','Hugo Sanchez','México'),
('9','James Rodriguez','Colombia'),
('10','Julian Alvarez','Argentina'),
('11','Rafael Marquez','Mexico'),
('12','Estefania Banini','Argentina')
;

select * from #ID_Vendedores;


create table #ID_Sedes (
	ID_SEDE int,
	Nombre_SEDE varchar(50),
	Ubicacion_SEDE Varchar(50)
);

insert into #ID_Sedes (ID_SEDE, Nombre_SEDE, Ubicacion_SEDE) values
('1','Bogota','Colombia'),
('2','Mexico DF','Mexico'),
('3','Lima','Peru'),
('4','Miami','Estados Unidos')
;

select * from #ID_Sedes;


create table #ID_Canales(	
	ID_Canal int,
	Tipo_Canal varchar(50),
	Canal varchar(50)
);

insert into #ID_Canales (ID_Canal, Tipo_Canal, Canal) values
('1','Publicidad','Publicidad en Google'),
('2','Publicidad','Publicidad en Facebook'),
('3','Otros','Desconocido'),
('4','Referido','Referido por otro Cliente')
;

select * from #ID_Canales;


create table #Facturas(
	Factura int,
	Fecha date,
	ID_canal int,
	Cliente int,
	Tipo_Cliente varchar(50),
	ID_Vehiculo int,
	Costo_Vehiculo decimal(10,2),
	Precio_Venta decimal(10,2),
	ID_SEDE int,
	ID_Vendedor int
);

bulk insert #Facturas
from 'C:\Users\Usuario\Desktop\base3\SQL\Facturas.csv'
with (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)

select * from #Facturas;



create table #ID_Autos(
	ID_Vehiculo int,
	Marca_Vehiculo varchar(50),
	Modelo_Vehiculo varchar(50),
	Tipo_Vehiculo varchar(50),
	Año_Vehiculo int,
);

bulk insert #ID_Autos
from 'C:\Users\Usuario\Desktop\base3\SQL\ID_Auto.csv'
with (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)

select * from #ID_Autos



create table #Presupuesto(
	Periodo int,
	Mes varchar(50),
	ID_SEDE int,
	Presupuesto decimal (10,2)
);


bulk insert #Presupuesto
from 'C:\Users\Usuario\Desktop\base3\SQL\Presupuesto.csv'
with (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)

select * from #Presupuesto;

--

select * from #ID_Vendedores;
select * from #ID_Sedes;
select * from #ID_Canales;
select * from #Facturas;
select * from #ID_Autos;
select * from #Presupuesto;

--
--Consulta con Join

select 
	f.Factura,
	f.Fecha,
	ven.Vendedor,
	s.Nombre_SEDE,
	c.canal,
	veh.Marca_Vehiculo,
	veh.Modelo_Vehiculo,
	f.Tipo_cliente,
	f.Precio_Venta
from #Facturas f
inner join #ID_Vendedores ven on f.ID_Vendedor = ven.ID_Vendedor
inner join #ID_Sedes s on f.ID_SEDE = s.ID_SEDE
inner join #ID_Canales c on f.ID_canal = c.ID_Canal
inner join #ID_Autos veh on f.ID_Vehiculo = veh.ID_Vehiculo;




----presupuesto contra ventas por sede

select
	f.Factura,
	s.Nombre_SEDE,
	p.Periodo,
	p.Mes,
	p.Presupuesto,
	f.Precio_Venta
from #Facturas f
inner join #ID_Sedes s on f.ID_SEDE = s.ID_SEDE
inner join #Presupuesto p on f.ID_SEDE = p.ID_SEDE;


----Consulta resumen

select count (*) as total_Ventas
from #Facturas;

select sum (Precio_Venta) as Total_Vendido
from #Facturas;

select avg (Precio_venta) as Promedio_Venta
from #Facturas;

select max (Precio_Venta) as Max_venta,
		min (Precio_Venta) as Min_Venta
from #Facturas;


----Consulta Negocio

--Que vehiculo vende mas?

select veh.Marca_Vehiculo, veh.Modelo_Vehiculo, count(*) as Veces_Vendidas
from #Facturas f
inner join #ID_Autos veh on f.ID_Vehiculo = veh.ID_Vehiculo
group by veh.Marca_Vehiculo, veh.Modelo_Vehiculo
order by Veces_Vendidas DESC;

--qué tipo de cliente compra más?

select f.Tipo_Cliente, sum(f.Precio_Venta) as Total_Ventas
from #Facturas f
group by f.Tipo_Cliente
order by Total_Ventas DESC;

--que vendedor factura mas?

select f.ID_Vendedor, count(*) as Total_Facturas
from #Facturas f
group by f.ID_Vendedor
having count(*) > 1;


----Consulta por Tiempo

select year (Fecha) as Año, count(*) as Total_Ventas
from #Facturas
group by year(Fecha)
order by Año;

select month(Fecha) as Mes, sum(Precio_Venta) as Total_ventas
from #Facturas
group by month(Fecha)
order by Mes;


----comparacion costo vs precio de venta para ver margen

select
	Factura,
	Costo_Vehiculo,
	Precio_Venta,
	Precio_Venta - Costo_Vehiculo as Margen
from #Facturas
order by Margen DESC;


-- Precio venta a Total venta

select
	Factura,
	Fecha,
	precio_Venta,
	sum(Precio_Venta) over () as Total_General
from #Facturas;

--Precio venta a promedio por SEDE

select 
	Factura,
	ID_SEDE,
	Precio_venta,
	avg(Precio_Venta) over (partition by ID_SEDE) as Promedio_SEDE
from #Facturas;


--Rango

WITH Top_Venta AS (
	select 
		Factura,
		Precio_Venta,
		RANK() over (order by Precio_Venta DESC) as Rango
	from #Facturas
)
select *
from Top_Venta
where Rango <= 5
Order by Rango;