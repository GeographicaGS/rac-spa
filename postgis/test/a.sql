create view trash.com as
select
  a.id_survey,
  c.description,
  a.geom as geom
from
  context.voronoi a left join
  data.survey_community b on
  a.id_survey=b.id_survey inner join
  data.community c on
  b.id_community=c.id_community;  
