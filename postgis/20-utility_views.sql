create or replace view utility_views.survey_communities as
with a as(
  select 
    a.id_survey as id_survey,
    c.description as description,
    a.geom as geom
  from
    data.survey a left join 
    data.survey_community b on 
    a.id_survey=b.id_survey inner join
    data.community c on
    b.id_community=c.id_community)
select
  id_survey,
  array_agg(description) as communities,
  geom
from
  a
group by
  id_survey, geom;


create or replace view utility_views.survey_original as
select
  *
from
  data.survey
where original;
