-- This two created the community map

alter table trash.voronoi
drop constraint enforce_srid_geom;

alter table trash.voronoi
drop constraint enforce_geotype_geom;

update geometry_columns
set srid=3857
where f_table_name='voronoi';

update trash.voronoi
set geom=st_setsrid(st_multi(geom), 3857);

with a as(
  select geom
  from context.bathimetry_mask
)
update trash.voronoi b
set geom=st_intersection(a.geom, b.geom)
from a;

drop table trash.com6;

create table trash.com6 as
with a as(
  select
    a.id_survey,
    array_agg(c.id_community)::varchar as com,
    st_union(a.geom) as geom
  from
    trash.voronoi a inner join
    data.survey_community b on
    a.id_survey=b.id_survey inner join
    data.community c on
    b.id_community=c.id_community
  group by
    a.id_survey
)
select
  id_survey,
  ltrim(rtrim(com, '}'), '{') as com,
  st_setsrid(st_multi(geom), 3857) as geom
from
  a;

drop table context.community_map;

create table context.community_map as
select
  row_number() over (order by com) as gid,
  com,
  st_union(geom) as geom
from
  trash.com6
group by
  com;



-- Bottom type

drop table context.bottom_map cascade;

create table context.bottom_map as
with a as(
  select
    st_union(a.geom) as geom,
    b.description
  from
    trash.voronoi a inner join
    data.bottom b on
    a.id_bottom=b.id_bottom
  group by 
    b.description)
select
  row_number() over (order by geom) as gid,
  description,  
  (st_dump(geom)).geom as geom
from a;



-- Species

drop table context.astroides_calycularis_map;

create table context.astroides_calycularis_map as
with a as (
  select
    (st_dump(st_union(a.geom))).geom as geom
  from
    trash.voronoi a inner join
    data.survey_species b on
    a.id_survey=b.id_survey inner join
    data.species c on
    b.id_species=c.id_species
  where
    c.id_species=4
)
select
  row_number() over (order by geom) as gid,
  geom
from a;


drop table context.cystoseira_mediterranea_map;

create table context.cystoseira_mediterranea_map as
with a as (
  select
    (st_dump(st_union(a.geom))).geom as geom
  from
    trash.voronoi a inner join
    data.survey_species b on
    a.id_survey=b.id_survey inner join
    data.species c on
    b.id_species=c.id_species
  where
    c.id_species=66
)
select
  row_number() over (order by geom) as gid,
  geom
from a;


drop table context.ophidiaster_ophidianus_map;

CREATE table context.ophidiaster_ophidianus_map as
with a as (
  select
    (st_dump(st_union(a.geom))).geom as geom
  from
    trash.voronoi a inner join
    data.survey_species b on
    a.id_survey=b.id_survey inner join
    data.species c on
    b.id_species=c.id_species
  where
    c.id_species=46
)
select
  row_number() over (order by geom) as gid,
  geom
from a;


drop table context.pinna_rudis_map;

create table context.pinna_rudis_map as
with a as (
  select
    (st_dump(st_union(a.geom))).geom as geom
  from
    trash.voronoi a inner join
    data.survey_species b on
    a.id_survey=b.id_survey inner join
    data.species c on
    b.id_species=c.id_species
  where
    c.id_species=74
)
select
  row_number() over (order by geom) as gid,
  geom
from a;


drop table context.savalia_savaglia_map;

create table context.savalia_savaglia_map as
with a as (
  select
    (st_dump(st_union(a.geom))).geom as geom
  from
    trash.voronoi a inner join
    data.survey_species b on
    a.id_survey=b.id_survey inner join
    data.species c on
    b.id_species=c.id_species
  where
    c.id_species=105
)
select
  row_number() over (order by geom) as gid,
  geom
from a;
