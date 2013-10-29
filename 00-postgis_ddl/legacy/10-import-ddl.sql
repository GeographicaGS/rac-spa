/*

  Creates the import schema.

*/

\i 00-config.sql

begin;

create schema import authorization :user;

create table import.datos_generales(
  numero integer,
  nomenclatura varchar(500),
  longitud varchar(100),
  latitud varchar(100),
  tipo_gps varchar(30),
  profundidad integer,
  fecha date,
  orientacion integer,
  tipo_sustrato varchar(25),
  facies varchar(50),
  especies text,
  observaciones text
);

alter table import.datos_generales owner to :user;

create table import.especies(
  id_especie integer,
  nombre varchar(250)
);

alter table import.especies owner to :user;

create table import.facies(
  id_facie integer,
  descripcion varchar(500)
);

alter table import.facies owner to :user;

commit;
