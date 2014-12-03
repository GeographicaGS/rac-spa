/*

  (Re)Creates the full database.

*/

\i 00-config.sql

\i :database
\i :import
\i :data
\i :digitalization
\i :functions
\i :importdata
\i :translation

\c :dbname :superuser

vacuum analyze;

\c :dbname :user
