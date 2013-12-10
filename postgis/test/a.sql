-- This two created the community map

create table trash.com6 as
with a as(
  select
    a.id_survey,
    array_agg(c.id_community)::varchar as com,
    st_union(a.geom) as geom
  from
    context.voronoi a inner join
    data.survey_community b on
    a.id_survey=b.id_survey inner join
    data.community c on
    b.id_community=c.id_community
  group by
    a.id_survey
)
select
  id_survey,
  ltrim(rtrim(com, '}'), '{') as com,
  st_setsrid(st_multi(geom), 3857) as geom
from
  a;


create table context.community_map as
select
  row_number() over (order by com) as gid,
  com,
  st_union(geom)
from
  trash.com6
group by
  com;
