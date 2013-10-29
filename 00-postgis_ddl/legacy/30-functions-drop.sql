/*

 Drop functions.

*/

begin;

drop function g__process_coordinate(varchar);
drop function g__process_point(varchar, varchar);
drop function g__process_data();
drop function g__process_species(text);
drop function g__create_views();
drop function g__tidy_species_names(text);

commit;
