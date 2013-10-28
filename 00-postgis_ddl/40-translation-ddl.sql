/*

  Data translation.

*/

\i 00-config.sql

begin;

-- Species
insert into data.species(id_species, name)
select id_especie, nombre from import.especies
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
