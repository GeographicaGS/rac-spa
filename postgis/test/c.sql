create table trash.ey32 as

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

