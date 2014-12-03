/*

  PostGIS database creation.

*/
\i 00-config.sql

\c postgres :superuser

create role :user with login password :'pass';
create database :dbname owner :user encoding 'UTF8';

\c :dbname :superuser

alter schema public owner to :user;

\c :dbname :user

create schema utility_views;
