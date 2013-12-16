-- create table context.bathimetry_mask as
-- with a as(
--   select
--     st_union(geom) as geom
--   from
--     context.height_ranges
--   where
--     upper between -40 and 0
-- ),
-- b as(
--   select
--     geom
--   from
--     context.zone_big
-- )
-- select
--   1,
--   st_difference(b.geom, a.geom) as geom
-- from
--   a,b;

-- create table context.voronoi_bathimetry_mask as
-- with a as(
--   select geom
--   from context.bathimetry_mask
-- )
-- select
--   gid,
--   id_survey,
--   st_difference(b.geom, a.geom) as geom
-- from
--   context.voronoi b, a;

--create table context.voronoi_ramsar as
with a as(
  select geom
  from context.height_ranges
  where lower=-50
)
update context.community_map b
set geom=st_difference(b.geom, a.geom)
from a;
