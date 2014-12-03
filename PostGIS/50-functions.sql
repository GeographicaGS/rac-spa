/*

  Create species views.

*/
create or replace function g__create_species_views()
returns void as
$$
declare
  _t text;
  _sql text;
  _r record;
begin
  _sql = 'select * from data.species;';

  for _r in execute _sql loop
    _t = 'create or replace view species_views.species_' || _r.id_species::varchar || ' as ';
    _t = _t || '
      select
        a.id_survey as id_survey,
        a.name as name,
        c.name as species,
        d.score as score,
        a.geom as geom
      from
        ((data.survey a inner join 
        data.survey_species b on a.id_survey=b.id_survey) inner join
        data.species c on b.id_species=c.id_species) inner join
        data.abundance d on b.id_abundance=d.id_abundance
      where c.id_species=' || _r.id_species::text || ' and active;';

    execute _t;

  end loop;
end;
$$
language plpgsql;

/*

  Create communities views.

*/
create or replace function g__create_communities_views()
returns void as
$$
declare
  _t text;
  _sql text;
  _r record;
begin
  _sql = 'select * from data.community;';

  for _r in execute _sql loop
    _t = 'create or replace view communities_views.community_' || _r.id_community || ' as ';
    _t = _t || '
      select
        a.id_survey as id_survey,
        a.name as name,
        c.description as community,
        a.geom as geom
      from
        (data.survey a inner join 
        data.survey_community b on a.id_survey=b.id_survey) inner join
        data.community c on b.id_community=c.id_community
      where c.id_community=' || _r.id_community::text || ' and active;';

    execute _t;

  end loop;
end;
$$
language plpgsql;

/*

  Launches the whole analysis.

*/
create or replace function run_analysis(
  _grid_size float
) returns boolean as
$$
declare
  _sql text;
  _r record;
begin
  -- Refresh species and communities views
  execute(select g__create_species_views());
  execute(select g__create_communities_views());

  drop table if exists grid_analysis.masked_grid cascade;

  _sql = '
    create or replace view grid_analysis.test_grid as
    with c as(
      select
        st_setsrid(gs__grid(geom, ' || _grid_size || '), 3857) as geom
      from context.zone_small)
    select
      row_number() over (order by geom) as gid,
      geom
    from c;';
  
  execute _sql;

  create table grid_analysis.masked_grid as
  select
    gid,
    st_setsrid(st_difference(
      geom,
      (select geom from context.land_mask)), 3857) as geom
  from
    grid_analysis.test_grid;

  create index masked_grid_geom_gist on grid_analysis.masked_grid using gist(geom);
  
  create or replace view grid_analysis.number_points_grid as
  select 
    b.gid as gid,
    count(a.id_survey) as n,
    b.geom as geom
  from
    data.survey a inner join
    grid_analysis.masked_grid b on st_within(a.geom, b.geom)
  where
    a.active
  group by
    b.gid, b.geom
  order by n;

  _sql = 'select * from data.species';

  for _r in execute _sql loop
    _sql = '
      create or replace view grid_analysis.grid_species_' || _r.id_species || ' as
      select 
        b.gid as gid,
        max(a.score) as score,
        b.geom as geom
      from
        species_views.species_' || _r.id_species || ' a inner join
        grid_analysis.masked_grid b on st_within(a.geom, b.geom)
      group by
        b.gid, b.geom
      order by gid;';

    execute _sql;
  end loop;

  _sql = 'select * from data.community';

  for _r in execute _sql loop
    _sql = '
      create or replace view grid_analysis.grid_communities_' || _r.id_community || ' as
      select 
        b.gid as gid,
        b.geom as geom
      from
        communities_views.community_' || _r.id_community || ' a inner join
        grid_analysis.masked_grid b on st_within(a.geom, b.geom)
      group by
        b.gid, b.geom
      order by gid;';

    execute _sql;
  end loop;

  return true;
end;
$$
language plpgsql;
