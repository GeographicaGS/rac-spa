/*

  Clean data translation.

*/

\i 00-config.sql

begin;

delete from data.species;
delete from data.community;
delete from data.abundance;
delete from data.gps;
delete from data.bottom;

commit;
