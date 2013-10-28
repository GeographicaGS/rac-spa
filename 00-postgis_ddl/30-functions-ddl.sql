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
begin

  _sql = 'select * from import.datos_generales order by numero';

  for _r in execute _sql loop
    raise notice '%', _r;

    _g = g__process_point(_r.longitud, _r.latitud);

    raise notice '%', _g;

    select id_gps into _gps
    from data.gps
    where description=_r.tipo_gps;

    raise notice '%', _gps;

    select id_bottom into _bottom
    from data.bottom
    where description=_r.tipo_sustrato;

    raise notice '%', _bottom;

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


  end loop;
end;
$$
language plpgsql;
