-- Survey points

create or replace view www.survey as
with species as(
  select
    a.id_survey as id_survey,
    array_agg(c.name) as species
  from
    data.survey a inner join
    data.survey_species b on
    a.id_survey=b.id_survey inner join
    data.species c on
    b.id_species=c.id_species
  where
    original and geom is not null
  group by
    a.id_survey
),
communities as(
  select
    a.id_survey as id_survey,
    array_agg(c.description_fr) as community
  from
    data.survey a inner join
    data.survey_community b on
    a.id_survey=b.id_survey inner join
    data.community c on
    b.id_community=c.id_community
  where
    original and geom is not null
  group by
    a.id_survey
)
select
  a.id_survey as id_survey,
  a.name as name,
  -depth as depth,
  b.description_fr as bottom,
  community,
  species,
  st_transform(geom, 4326) as geom
from
  data.survey a inner join
  data.bottom b on
  a.id_bottom=b.id_bottom inner join
  species c on
  a.id_survey=c.id_survey inner join
  communities d on
  a.id_survey=d.id_survey
where
  original and geom is not null
order by
  a.id_survey;
