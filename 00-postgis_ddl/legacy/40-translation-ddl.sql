/*

  Data translation.

*/

\i 00-config.sql

\c :dbname :superuser

begin;

copy digitalization.emodnet_bathimetry
from :'data_bathimetry'
with delimiter ';';

commit;

\c :dbname :user

insert into digitalization.zone(name, geom)
values('Macro', st_setsrid(gs__rectangle(
  array[-404256, 4166585, -230490, 4272313]), 3857));

-- Species
insert into data.species(id_species, name)
select id_especie, trim(nombre) from import.especies
order by id_especie;


-- Communities
insert into data.community(id_community, description)
select id_facie, descripcion from import.facies
order by id_facie;


-- Abundance
insert into data.abundance
values(1, 'Dominante');

insert into data.abundance
values(2, 'Secundaria');

insert into data.abundance
values(3, 'Presente');


-- GPS
insert into data.gps
select 
  row_number() over (order by a.tipo_gps), 
  a.tipo_gps 
from (
  select distinct tipo_gps 
  from import.datos_generales 
  order by tipo_gps) a;


-- Bottom
insert into data.bottom
select 
  row_number() over (order by a.tipo_sustrato), 
  a.tipo_sustrato
from (
  select distinct tipo_sustrato
  from import.datos_generales 
  order by tipo_sustrato) a;

commit;

-- All

select g__process_data();
