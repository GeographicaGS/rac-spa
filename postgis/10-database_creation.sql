\c postgres postgres

create role racspa with login password 'racspa';
create database racspa owner racspa encoding 'UTF8';

\c racspa postgres

alter schema public owner to racspa;

\c racspa racspa
