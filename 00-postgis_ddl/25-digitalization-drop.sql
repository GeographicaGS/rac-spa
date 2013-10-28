\i 00-config.sql

begin;

drop schema digitalization cascade;

delete from public.geometry_columns
where f_table_schema='digitalization';

commit;
