create or replace view context.bathimetry_line as
select
  row_number() over (order by height) as gid,
  height,
  st_linemerge(st_collect(geom)) as geom
from
  context.height_line
where
  height<0
group by
  height;

