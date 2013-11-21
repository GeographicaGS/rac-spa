/*

  Returns a polygonal grid that covers a geometry at a regular step.

*/
create or replace function public.gs__grid(
  _geom geometry,
  _size float
) returns setof geometry as
$$
declare
  _bounds float[];
  _width float;
  _height float;
  _cols integer;
  _rows integer;
  _x float;
  _y float;
  _c integer;
  _r integer;
  _g geometry;
begin
  _bounds = gs__geom_boundaries(_geom);
  
  raise notice 'A: %', _bounds;

  _cols = ((_bounds[3]-_bounds[1])/_size)::integer;
  _rows = ((_bounds[4]-_bounds[2])/_size)::integer;

  if (_bounds[3]-_bounds[1])::numeric%_size::numeric<>0 then
    _cols = _cols+1;
  end if;

  if (_bounds[4]-_bounds[2])::numeric%_size::numeric<>0 then
    _rows = _rows+1;
  end if;

  raise notice 'B: %, %', _cols, _rows;

  _width = _cols*_size;
  _height = _rows*_size;

  raise notice 'B2: %, %', _width, _height;

  _x = _bounds[1]-((_width-(_bounds[3]-_bounds[1]))/2);
  _y = _bounds[2]-((_height-(_bounds[4]-_bounds[2]))/2);

  raise notice 'C: %, %', _x, _y;

  for _c in 0.._cols-1 loop
    for _r in 0.._rows-1 loop
      raise notice 'E: %, %', _c, _r;

      raise notice 'F: %', array[_x+(_c*_size), _y+(_r*_size), 
                                 _x+(_c*_size)+_size, _y+(_r*_size)+_size]::float[];

      _g = gs__rectangle(array[_x+(_c*_size), _y+(_r*_size), 
                                 _x+(_c*_size)+_size, _y+(_r*_size)+_size]::float[]);

      return next _g;
    end loop;
  end loop;
end;
$$
language plpgsql;


