create view trash.test_grid2 as
with c as(
  select st_collect(geom) as geom
  from data.survey
)
select
  row_number() over (order by geom) as gid,
  gs__grid(geom, 250) as geom
from c;
