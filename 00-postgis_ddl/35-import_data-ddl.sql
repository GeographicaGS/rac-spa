/*

  Import data.

*/

\i 00-config.sql

\c :dbname :superuser

begin;

copy import.datos_generales from :'data_datos_generales' with delimiter '|' csv header quote '"';
copy import.especies from :'data_especies' with delimiter '|' csv header quote '"';
copy import.facies from :'data_facies' with delimiter '|' csv header quote '"';

commit;

\c :dbname :user

begin;

update import.datos_generales
set
  longitud='3º 00´45,06´´',
  latitud='35º 23´30,18´´'
where numero=23;

update import.datos_generales
set
  longitud='3º 00´37,62´´',
  latitud='35º 23´48,18´´'
where numero=24;

update import.datos_generales
set tipo_gps='interpolación'
where tipo_gps='ver observaciones';

update import.datos_generales
set tipo_gps='Garmin'
where tipo_gps='garmin';

update import.datos_generales
set tipo_gps='Google Earth'
where tipo_gps='google earth';

update import.datos_generales
set tipo_gps='Topcom'
where tipo_gps='topcom';

update import.datos_generales
set tipo_sustrato=trim(tipo_sustrato);

update import.datos_generales
set tipo_sustrato='mixto arena y roca'
where tipo_sustrato='mixto arena/roca';

update import.datos_generales
set tipo_sustrato='mixto detrítico y roca'
where tipo_sustrato='mixto detrítico/roca';

commit;
