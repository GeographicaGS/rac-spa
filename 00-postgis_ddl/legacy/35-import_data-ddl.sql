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
set
  longitud=-333523,
  latitud=4221755
where numero=51;

update import.datos_generales
set
  longitud=-333285,
  latitud=4222970
where numero=57;

update import.datos_generales
set
  longitud=-329800,
  latitud=4223847
where numero=73;

update import.datos_generales
set
  longitud=-329089,
  latitud=4223543
where numero=75;

update import.datos_generales
set
  longitud=-328907,
  latitud=4219067
where numero=12;

update import.datos_generales
set
  longitud=-335096,
  latitud=4218619
where numero=28;

update import.datos_generales
set
  longitud=-334430,
  latitud=4219908
where numero=33;

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

update import.datos_generales
set especies=null
where numero=85;

update import.datos_generales
set especies='4(2), 9(1), 15(3), 20(1), 46(1), 32(1), 7(1), 3(2), 12(1), 28(1), 31(1), 8(3), 11(1), 107(1)'
where numero=4;

update import.datos_generales
set especies='12(3), 9(2), 4(2), 1(1), 78(1), 63(1), 27(2), 32(1), 30(1), 20(1), 79(1), 6(1), 11(1), 80(1), 18(1), 33(1), 53(1), 38(1), 81(1), 85(1), 89(1)'
where numero=48;

commit;
