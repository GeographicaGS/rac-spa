create table trash.grid075 as
select
  gs__grid(geom, 0.75)
from trash.test_grid;
