/*

  Drop the data schema.

*/

\i 00-config.sql

begin;

drop schema data cascade;
drop schema data_views cascade;

delete from public.geometry_columns
where f_table_schema='data';

commit;
