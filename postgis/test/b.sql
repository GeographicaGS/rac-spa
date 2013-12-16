with a as(
  select
    st_union(geom) as geom
  from
    context.height_ranges
)
update trash.f b
set geom=st_difference(b.geom, a.geom)
from a;

