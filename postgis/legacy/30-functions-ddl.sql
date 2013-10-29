/*

  Process a coordinate.

*/
create or replace function g__process_coordinate(
  _coord varchar(300)
) returns double precision as
$$
declare
  _out double precision;
  _degrees double precision;
  _minutes double precision;
  _seconds double precision;
begin
  _out = null;

  -- Check type of coordinate
  if strpos(_coord, 'º')>0 then
    -- Process DGMS
    _degrees = (substr(_coord, 1, strpos(_coord, 'º')-1))::double precision;
    _coord = substr(_coord, strpos(_coord, 'º')+2);

    _minutes = (substr(_coord, 1, strpos(_coord, '´')-1))::double precision;
    _coord = substr(_coord, strpos(_coord, '´')+1);

    _seconds = (replace((substr(_coord, 1, strpos(_coord, '´')-1)), ',', '.'))::double precision;

    _out = _degrees+((_minutes+(_seconds/60))/60);
  else
    if _coord<>'ver observaciones' then
      -- Process UTM
      _out = (replace(_coord, ',', '.'))::double precision;
    end if;
  end if;

  return _out;
end;
$$
language plpgsql;

/*

  Process a pair of coordinates to produce a point.

*/
create or replace function g__process_point(
  _x varchar(300),
  _y varchar(300)
) returns geometry as
$$
declare
  _geom geometry;
  _px double precision;
  _py double precision;
begin
  _px = g__process_coordinate(_x);
  _py = g__process_coordinate(_y);

  if _px is not null and _py is not null then
    if _px<100 and _py<100 then
      return st_transform(st_setsrid(st_makepoint(-_px, _py), 4326), 3857);
    else
      return st_setsrid(st_makepoint(_px, _py), 3857);
    end if;
  end if;

  return null;
end;
$$
language plpgsql;

/*

  Process import.datos_generales

*/
create or replace function g__process_data()
returns void as
$$
declare
  _r record;
  _sql text;
  _g geometry;
  _gps integer;
  _bottom integer;
  _facies text;
  _species text;
  _p integer;
  _f integer;
  _id_species integer;
  _abundance integer;
begin
  _sql = 'select * from import.datos_generales order by numero';

  for _r in execute _sql loop
    _g = g__process_point(_r.longitud, _r.latitud);

    select id_gps into _gps
    from data.gps
    where description=_r.tipo_gps;

    select id_bottom into _bottom
    from data.bottom
    where description=_r.tipo_sustrato;

    insert into data.survey
    values(
      _r.numero,
      _r.nomenclatura,
      _gps,
      _r.profundidad,
      _r.fecha,
      _r.orientacion,
      _bottom,
      _r.observaciones,
      _g
    );

    _facies = _r.facies;

    while _facies<>'' loop
      _p = strpos(_facies, ',');
  
      if _p=0 then
        _f = (trim(_facies))::integer;
        _facies = '';
      else
        _f = (trim(substr(_facies, 1, _p-1)))::integer;
        _facies = substr(_facies, _p+1);
      end if;

      insert into data.survey_community
      values(_r.numero, _f);      
    end loop;

    _species = trim(_r.especies);

    while _species<>'' loop
      _p = strpos(_species, ',');

      if _p=0 then
        _id_species = (g__process_species(trim(_species)))[1];
        _abundance = (g__process_species(trim(_species)))[2];
        _species = '';
      else
        _id_species = (g__process_species(trim(substr(_species, 1, _p-1))))[1];
        _abundance = (g__process_species(trim(substr(_species, 1, _p-1))))[2];
        _species = trim(substr(_species, _p+1))p;
      end if;

      insert into data.survey_species
      values(_r.numero, _id_species, _abundance);
    end loop;    

  end loop;
end;
$$
language plpgsql;

/*

  Extract species and abundance.

*/
create or replace function g__process_species(
  _species text
) returns integer[] as
$$
declare
  _t text;
  _s integer;
  _a integer;
begin
  _species = trim(_species);
  _s = (trim(split_part(_species, '(', 1)))::integer;
  _a = (trim(substr(split_part(_species, '(', 2), 1, length(split_part(_species, '(', 2))-1)))::integer;

  return array[_s, _a];
end;
$$
language plpgsql;

/*

  Create views.

*/
create or replace function g__create_views()
returns void as
$$
declare
  _t text;
  _sql text;
  _r record;
begin
  _sql = 'select * from data.species;';

  for _r in execute _sql loop
    _t = 'create or replace view data_views.' || g__tidy_species_names(_r.name) || ' as ';
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

  Tidy up species names.

*/
create or replace function g__tidy_species_names(
  _name text
) returns text as
$$
begin
  _name = replace(lower(trim(_name)), ' ', '_');
  _name = replace(replace(replace(replace(_name, '.', ''), '(', ''), '=', ''), ')', '');

  return _name;
end;
$$
language plpgsql;
