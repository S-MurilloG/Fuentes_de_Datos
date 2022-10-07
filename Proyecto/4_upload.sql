drop schema if exists raw cascade;


create schema raw;


drop table if exists raw.estaciones;


drop sequence id_estacion_estaciones_seq;
drop sequence estacion_servicio_precios_seq;


create table raw.estaciones (
id_estacion numeric(5,0) constraint pk_estacion primary key,
nombre varchar(100) NOT NULL ,
latitud numeric(10,6) NOT NULL,
longitud numeric(10,6) NOT NULL
);
CREATE SEQUENCE id_estacion_estaciones_seq START 1 INCREMENT 1;
--ALTER TABLE estaciones ALTER COLUMN id_estacion SET NOT 0;
ALTER TABLE estaciones ALTER COLUMN id_estacion SET DEFAULT nextval('id_estacion_estaciones_seq');


drop table if exists raw.precios;


create table raw.precios (
estacion_servicio numeric(5,0) constraint pk_precios primary key,
regular numeric(4,2),
premium numeric(4,2),
diesel numeric(4,2)
);
CREATE SEQUENCE estacion_servicio_precios_seq START 1 INCREMENT 1;
--ALTER TABLE precios ALTER COLUMN estacion_servicio SET NOT 0;
ALTER TABLE precios ALTER COLUMN estacion_servicio SET DEFAULT nextval('estacion_servicio_precios_seq');

