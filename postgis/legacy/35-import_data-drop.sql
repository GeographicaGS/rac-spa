/*

  Drop imported data.

*/

begin;

delete from import.datos_generales;
delete from import.especies;
delete from import.facies;

commit;
