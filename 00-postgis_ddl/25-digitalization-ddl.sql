/*

  Creates the digitalization schema.

*/

\i 00-config.sql

begin;

create schema digitalization authorization :user;


create table digitalization.toponism(
  id_toponism serial,
  toponism_ar varchar(500),
  toponism_es varchar(500)
);

select addgeometrycolumn('digitalization', 'toponism', 'geom', 3857, 'POINT', 2);

alter table digitalization.toponism owner to :user;

alter table digitalization.toponism add constraint
toponism_pkey primary key(id_toponism);

create index toponism_geom_gist on digitalization.toponism
using gist(geom);


create table digitalization.height_line(
  id_height_line serial,
  height double precision
);

select addgeometrycolumn('digitalization', 'height_line', 'geom', 3857, 'LINESTRING', 2);

alter table digitalization.height_line owner to :user;

alter table digitalization.height_line add constraint
height_line_pkey primary key(id_height_line);

create index height_line_geom_gist on digitalization.height_line
using gist(geom);


create table digitalization.height_point(
  id_height_point serial,
  height double precision
);

select addgeometrycolumn('digitalization', 'height_point', 'geom', 3857, 'POINT', 2);

alter table digitalization.height_point owner to :user;

alter table digitalization.height_point add constraint
height_point_pkey primary key(id_height_point);

create index height_point_geom_gist on digitalization.height_point
using gist(geom);


create table digitalization.stream(
  id_stream serial
);

select addgeometrycolumn('digitalization', 'stream', 'geom', 3857, 'LINESTRING', 2);

alter table digitalization.stream owner to :user;

alter table digitalization.stream add constraint
stream_pkey primary key(id_stream);

create index stream_geom_gist on digitalization.stream
using gist(geom);

commit;
