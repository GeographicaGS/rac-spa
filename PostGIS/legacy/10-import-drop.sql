/*

  Drops the import schema.

*/

\i 00-config.sql

begin;

drop schema if exists import cascade;

commit;
