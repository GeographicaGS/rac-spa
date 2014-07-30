-- Survey points

-- create or replace view www.survey as
-- with species as(
--   select
--     a.id_survey as id_survey,
--     array_agg(c.name) as species
--   from
--     data.survey a inner join
--     data.survey_species b on
--     a.id_survey=b.id_survey inner join
--     data.species c on
--     b.id_species=c.id_species
--   where
--     original and geom is not null
--   group by
--     a.id_survey
-- ),
-- communities as(
--   select
--     a.id_survey as id_survey,
--     array_agg(c.description_fr) as community
--   from
--     data.survey a inner join
--     data.survey_community b on
--     a.id_survey=b.id_survey inner join
--     data.community c on
--     b.id_community=c.id_community
--   where
--     original and geom is not null
--   group by
--     a.id_survey
-- )
-- select
--   a.id_survey as id_survey,
--   a.name as name,
--   -depth as depth,
--   b.description_fr as bottom,
--   community,
--   species,
--   st_transform(geom, 4326) as geom
-- from
--   data.survey a inner join
--   data.bottom b on
--   a.id_bottom=b.id_bottom inner join
--   species c on
--   a.id_survey=c.id_survey inner join
--   communities d on
--   a.id_survey=d.id_survey
-- where
--   original and geom is not null
-- order by
--   a.id_survey;



-- Bottom type map

drop table www.bottom_map cascade;

create table www.bottom_map as
with a as(
  select
    st_union(a.geom) as geom,
    b.description_fr
  from
    trash.voronoi a inner join
    data.bottom b on
    a.id_bottom=b.id_bottom
  group by 
    b.description_fr)
select
  row_number() over (order by geom) as gid,
  description_fr,  
  (st_dump(geom)).geom as geom
from a;



-- Communities

drop table trash.com6;

create table trash.com6 as
with a as(
  select
    a.id_survey,
    array_agg(c.description_fr) as com,
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
  com,
  st_setsrid(st_multi(geom), 3857) as geom
from
  a;

drop table www.community_map;

create table www.community_map as
select
  row_number() over (order by com) as gid,
  com,
  trim(com::varchar, '{}') as com_varchar,
  st_union(geom) as geom
from
  trash.com6
group by
  com;



-- Species

drop table www.astroides_calycularis_map;

create table www.astroides_calycularis_map as
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


drop table www.cystoseira_mediterranea_map;

create table www.cystoseira_mediterranea_map as
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


drop table www.ophidiaster_ophidianus_map;

CREATE table www.ophidiaster_ophidianus_map as
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


drop table www.pinna_rudis_map;

create table www.pinna_rudis_map as
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


drop table www.savalia_savaglia_map;

create table www.savalia_savaglia_map as
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
