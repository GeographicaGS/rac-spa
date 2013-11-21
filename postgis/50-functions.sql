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
    _t = 'create or replace view species_views.' || g__tidy_names(_r.name) || ' as ';
    _t = _t || '
      select
        a.id_survey as id_survey,
        a.name as name,
        a.depth as depth,
        c.name as species,
        d.description as abundance,
        a.geom as geom
      from
        ((data.survey a inner join 
        data.survey_species b on a.id_survey=b.id_survey) inner join
        data.species c on b.id_species=c.id_species) inner join
        data.abundance d on b.id_abundance=d.id_abundance
      where c.id_species=' || _r.id_species::text || ';';

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
    _t = 'create or replace view communities_views.' || g__tidy_names(_r.description) || ' as ';
    _t = _t || '
      select
        a.id_survey as id_survey,
        a.name as name,
        a.depth as depth,
        c.description as community,
        a.geom as geom
      from
        (data.survey a inner join 
        data.survey_community b on a.id_survey=b.id_survey) inner join
        data.community c on b.id_community=c.id_community
      where c.id_community=' || _r.id_community::text || ';';

    execute _t;

  end loop;
end;
$$
language plpgsql;
