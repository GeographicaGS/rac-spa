/*

  Returns a polygonal grid that covers a geometry at a regular step.

*/
create or replace function public.gs__grid(
  _geom geometry
) returns setof geometry as
$$
declare
  _bounds float[];
begin
  _bounds = gs__geom_boundaries(_geom);
  
  raise notice 'A: %', _bounds;
end;
$$
language plpgsql;


