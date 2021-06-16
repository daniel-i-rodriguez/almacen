--crear Base de datos
create database almacen

--crear tabla productos
create table Productos(
	Productos serial primary key,
	Nombre varchar(100),
	Precio money
)

--crear tabla cajeros
create table Cajeros(
	Cajero serial primary key,
	NomApels varchar(255)
)

--crear tabla de maquinas
create table Maquinas_registradoras(
	Maquinas serial primary key,
	Piso int
)

--crear tabla venta
create table Venta(
	Cajero int,
	Maquina int,
	Producto int,
	foreign key (Cajero) references Cajeros(Cajero),
	foreign key (Maquina) references Maquinas_registradoras(Maquinas),
	foreign key (Producto) references Productos(Productos)
)


-- Punto 1 para poblar las tablas
insert into Productos(Nombre,Precio)
values('Tequila Gran Malo',249),('Whisky William Lawsons',276),('Whisky Jack Daniels', 371),
('Tequila Don Julio 70', 832), ('Tequila Don Ramon Reposado', 210),('Brandy Torres 10',289),
('Whisky Johnnie Walker Black Label', 693),('Vodka Smirnoff Tamarindo', 200),('Tequila Gran Centenario', 386),
('Licor Baileys',390),('Brandy torres 5',205),('Tequila Cuervo Especial Blanco',212),
('Ron Flor de Caña 12 Años', 479),('Tequila Cabrito Reposado', 185),('Maestro Tequilero Dobel Diamante',649),
('Mezcal Aleron', 501),('Vodka Absolut',272),('Mezcal Mitre Artesanal',556),('Tequila Patron Silver',579),
('Tequila Herradura Plata',576)

insert into Cajeros(NomApels)
values('Juan Carlos'),('Ana Carmen'),('Deborah Michelle'),('Alfredo'),('karla'),
('Christian'),('Vanessa')


insert into Maquinas_registradoras(Piso)
values(1),(2),(3),(4)

insert into Venta(Cajero,Maquina,Producto)
values(3,2,11),(3,2,3),(3,1,10),
(3,1,17),(3,1,7),(7,3,1),(5,2,10),(2,4,20),(3,2,19),(7,1,12),(2,3,8),
(5,1,9),(3,3,3),(7,1,18),(7,2,5),(2,2,14),(3,1,4),(2,1,7),(3,1,4),(5,1,7),
(2,4,12),(3,1,13),(2,2,7)

--Punto 2
select po.Nombre,count(po.Productos) as cantidad from Venta v
inner join Productos po on v.Producto = po.Productos
group by po.Productos
order by cantidad desc

-- Punto 3
select ca.NomApels,po.Nombre,po.Precio,mr.piso from Venta v
inner join Productos po on v.Producto = po.Productos
inner join Cajeros ca on ca.Cajero = v.Cajero
inner join Maquinas_registradoras mr on v.Maquina = mr.Maquinas

-- punto 4 
select mr.piso,sum(po.Precio) as Total_Venta from Venta v
inner join Productos po on v.Producto = po.Productos
inner join Maquinas_registradoras mr on v.Maquina = mr.Maquinas
group by mr.piso
order by mr.piso asc

-- Punto 5
select ca.Cajero,ca.Nomapels,sum(po.Precio) as Ventas_Totales from Venta v
inner join Productos po on v.Producto = po.Productos
inner join Cajeros ca on ca.Cajero = v.Cajero
group by ca.Cajero

-- punto 6
select ca.Cajero,ca.Nomapels,sum(po.Precio) as Ventas_Totales from Venta v
inner join Productos po on v.Producto = po.Productos
inner join Cajeros ca on ca.Cajero = v.Cajero
group by ca.Cajero
having sum(po.Precio)::numeric::int < 5000 


