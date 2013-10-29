/*

  Database drop script.

*/

\i 00-config.sql

\c postgres :superuser

drop database if exists :dbname;
drop role if exists :dbname;
