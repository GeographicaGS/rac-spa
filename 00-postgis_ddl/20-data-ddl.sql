/*

  Creates the data schema.

*/

\i 00-config.sql

begin;

create schema data authorization :user;


create table data.survey(
  id_survey integer,
  name varchar(500),
  id_gps integer,
  depth integer,
  date date,
  orientation integer,
  id_bottom integer,
  notes text
);

select addgeometrycolumn('data', 'survey', 'geom', 3857, 'POINT', 2);

alter table data.survey owner to :user;

alter table data.survey add constraint
survey_pkey primary key(id_survey);

create index survey_geom_gist on data.survey
using gist(geom);


create table data.gps(
  id_gps integer,
  description varchar(250)
);

alter table data.gps owner to :user;

alter table data.gps add constraint
gps_pkey primary key(id_gps);


create table data.bottom(
  id_bottom integer,
  description varchar(250)
);

alter table data.bottom owner to :user;

alter table data.bottom add constraint
bottom_pkey primary key(id_bottom);


create table data.survey_community(
  id_survey integer,
  id_community integer
);

alter table data.survey_community owner to :user;

alter table data.survey_community add constraint
survey_community_pkey primary key(id_survey, id_community);


create table data.community(
  id_community integer,
  description varchar(250)
);

alter table data.community owner to :user;

alter table data.community add constraint
community_pkey primary key(id_community);


create table data.survey_species(
  id_survey integer,
  id_species integer,
  id_abundance integer
);

alter table data.survey_species owner to :user;

alter table data.survey_species add constraint
survey_species_pkey primary key(id_survey, id_species);


create table data.species(
  id_species integer,
  name varchar(300)
);

alter table data.species owner to :user;

alter table data.species add constraint
species_pkey primary key(id_species);


create table data.abundance(
  id_abundance integer,
  description varchar(150)
);

alter table data.abundance owner to :user;

alter table data.abundance add constraint
abundance_pkey primary key(id_abundance);


alter table data.survey add constraint
survey_gps_fkey foreign key (id_gps) references
data.gps(id_gps);

alter table data.survey add constraint
survey_bottom_fkey foreign key (id_bottom) references
data.bottom(id_bottom);

alter table data.survey_community add constraint
survey_community_survey_fkey foreign key (id_survey) references
data.survey(id_survey);

alter table data.survey_community add constraint
survey_community_community_fkey foreign key (id_community) references
data.community(id_community);

alter table data.survey_species add constraint
survey_species_survey_fkey foreign key (id_survey) references
data.survey(id_survey);

alter table data.survey_species add constraint
survey_species_abundance_fkey foreign key (id_abundance) references
data.abundance(id_abundance);

alter table data.survey_species add constraint
survey_species_species_fkey foreign key (id_species) references
data.species(id_species);

commit;
