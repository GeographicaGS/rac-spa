select
  a.id_survey,
  a.depth,
  b.range_text
from
  data.survey a inner join
  context.height_ranges b on st_within(a.geom, b.geom)
order by a.depth desc;
