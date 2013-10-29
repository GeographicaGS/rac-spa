/*

  Database creation script. (Re)creates the database from the ground
  up, including all its schemas.

*/

\i 00-config.sql

\c postgres :superuser

create role :user with login password :'pass';

create database :dbname owner :user encoding 'UTF8';

\c :dbname :superuser

\i :postgis
\i :spatial_ref_sys
\i :proj4
\i :geometricconstructor

alter schema public owner to :user;
alter table public.geometry_columns owner to :user;
alter table public.spatial_ref_sys owner to :user;
alter view public.geography_columns owner to :user;

\c :dbname :user

select gs__test_grid_proj4();
