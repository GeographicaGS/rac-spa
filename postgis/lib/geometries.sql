/*

  Geometry accessor and constructors.

*/

/*

  Creates a polygonal rectangle from two points: lower left and upper
  right corners

*/
create or replace function public.gs__rectangle(
  _point_a geometry,
  _point_b geometry
) returns geometry as
$$
declare
  _point_ll geometry;
  _point_lr geometry;
  _point_ul geometry;
  _point_ur geometry;
  _minx double precision;
  _maxx double precision;
  _miny double precision;
  _maxy double precision;
begin
  _minx = gs__array_min(array[st_x(_point_a), st_x(_point_b)]::numeric[]);
  _maxx = gs__array_max(array[st_x(_point_a), st_x(_point_b)]::numeric[]);
  _miny = gs__array_min(array[st_y(_point_a), st_y(_point_b)]::numeric[]);
  _maxy = gs__array_max(array[st_y(_point_a), st_y(_point_b)]::numeric[]);

  _point_ll = st_makepoint(_minx, _miny);
  _point_lr = st_makepoint(_maxx, _miny);
  _point_ul = st_makepoint(_minx, _maxy);
  _point_ur = st_makepoint(_maxx, _maxy);

  return 
    st_makepolygon(
      st_makeline(array[
        _point_ll,
        _point_lr,
        _point_ur,
        _point_ul,
        _point_ll
    ]));
end;
$$
language plpgsql;

/*

  Same as above, but gets a [minx,miny,maxx,maxy] parameter.

*/
create or replace function public.gs__rectangle(
  _array float[]
) returns geometry as
$$
declare
  _point_ll geometry;
  _point_lr geometry;
  _point_ul geometry;
  _point_ur geometry;
begin
	_point_ll = st_makepoint(_array[1], _array[2]);
  _point_lr = st_makepoint(_array[3], _array[2]);
  _point_ul = st_makepoint(_array[1], _array[4]);
  _point_ur = st_makepoint(_array[3], _array[4]);

  return st_makepolygon(
    st_makeline(array[
      _point_ll,
			_point_lr,
			_point_ur,
			_point_ul,
			_point_ll
	]));
end;
$$
language plpgsql;

/*

  Returns a [minx,miny,maxx,maxy] for a set of geometries passed as a
  geometry array.

*/
create or replace function public.gs__geom_boundaries(
  _geom geometry[]
) returns float[] as
$$
declare
  _g geometry;
  _minx float;
  _miny float;
  _maxx float;
  _maxy float;
begin
  _minx = st_xmin(_geom[1]);
  _miny = st_ymin(_geom[1]);
	_maxx = st_xmax(_geom[1]);
	_maxy = st_ymax(_geom[1]);

	foreach _g in array _geom loop
    if st_xmin(_g)<_minx then
		  _minx = st_xmin(_g);
		end if;

    if st_ymin(_g)<_miny then
		  _miny = st_ymin(_g);
		end if;

    if st_xmax(_g)>_maxx then
		  _maxx = st_xmax(_g);
		end if;

    if st_ymax(_g)>_maxy then
		  _maxy = st_ymax(_g);
		end if;
  end loop;

  return array[_minx,_miny,_maxx,_maxy]::float[];
end;
$$
language plpgsql;

/*

  Returns a [minx,miny,maxx,maxy] for a geometry.

*/
create or replace function public.gs__geom_boundaries(
  _geom geometry
) returns float[] as
$$
declare
  _g geometry;
  _minx float;
  _miny float;
  _maxx float;
  _maxy float;
begin
  _minx = st_xmin(_geom);
  _miny = st_ymin(_geom);
	_maxx = st_xmax(_geom);
	_maxy = st_ymax(_geom);

  return array[_minx,_miny,_maxx,_maxy]::float[];
end;
$$
language plpgsql;

/*

  Takes a set of points and a closed LINESTRING and returns the splits.

*/
create or replace function gs__split_closed_linestring(
  _points geometry[],
  _line geometry,
  _tolerance float
) returns geometry[] as
$$
declare
  _p geometry;
  _lines geometry[]=array[]::geometry[];
  _c boolean=true;
  _i integer;
  _a geometry;
  _b geometry;
  _l1 geometry;
  _l2 geometry;
  _srid integer;
begin
  _srid = st_srid(_points[1]);

	-- Delete all points that doesn't fall within tolerance
	for _i in 1..array_length(_points, 1) loop
	  if st_distance(_points[_i], _line)>_tolerance then
		  _points = gs__pull_from_array(_points, _i);
		end if;
	end loop;

  -- Sort points by distance to the start node
  _i = 1;
  while _c loop
    _c = false;
    while _i<(array_length(_points, 1)) loop
      if st_line_locate_point(_line, _points[_i])>st_line_locate_point(_line, _points[_i+1]) then
        _a = _points[_i];
	_b = _points[_i+1];
	_points[_i] = _b;
	_points[_i+1] = _a;
	_c = true;
      end if;
      _i = _i+1;
    end loop;
    _i = 1;
  end loop;

  -- Cut the line with the string of points
  _i = 1;
  while _i<(array_length(_points, 1)) loop
    _lines = _lines || st_setsrid(st_line_substring(_line, st_line_locate_point(_line, _points[_i]),
                                         st_line_locate_point(_line,_points[_i+1])), _srid);
    _i = _i+1;
  end loop;

  -- Cut from start to first and from last to end, and join them  
  _l1 = st_setsrid(st_line_substring(_line, 0, st_line_locate_point(_line, _points[1])), _srid);
  _l2 = st_setsrid(st_line_substring(_line, st_line_locate_point(_line,
           _points[array_length(_points,1)]), 1), _srid);
  _lines = _lines || st_union(_l1, _l2);

  return _lines;
end;
$$
language plpgsql;
