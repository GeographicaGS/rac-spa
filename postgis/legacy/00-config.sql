/*

  version(): PostgreSQL 9.1.2 on x86_64-unknown-linux-gnu, compiled by
  gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, 64-bit

  postgis_full_version(): POSTGIS="1.5.8" GEOS="3.3.7-CAPI-1.7.7"
  PROJ="Rel. 4.8.0, 6 March 2012" LIBXML="2.7.8" USE_STATS

  Database configuration.

*/

\set superuser postgres
\set user racspa
\set pass racspa
\set dbname racspa
\set prefix '/home/git/rac-spa/'
\set geoext '/home/malkab/Dropbox/ragnarok/code/GeographicaPostGisExtensions/redux/'
\set pgprefix '/usr/local/postgresql-9.1.2-postgis-1.5.3/share/contrib/postgis-1.5/'

\set postgis :pgprefix postgis.sql
\set spatial_ref_sys :pgprefix spatial_ref_sys.sql
\set proj4 :geoext proj4.sql
\set geometricconstructor :geoext geometric_constructors.sql

\set database :prefix 00-postgis_ddl/05-database-ddl.sql
\set import :prefix 00-postgis_ddl/10-import-ddl.sql
\set data :prefix 00-postgis_ddl/20-data-ddl.sql
\set digitalization :prefix 00-postgis_ddl/25-digitalization-ddl.sql
\set functions :prefix 00-postgis_ddl/30-functions-ddl.sql
\set importdata :prefix 00-postgis_ddl/35-import_data-ddl.sql
\set translation :prefix 00-postgis_ddl/40-translation-ddl.sql

\set data_datos_generales :prefix 00-postgis_ddl/99-data-datos_generales.csv
\set data_especies :prefix 00-postgis_ddl/99-data-especies.csv
\set data_facies :prefix 00-postgis_ddl/99-data-facies.csv
\set data_bathimetry :prefix 00-postgis_ddl/99-data-emodnet_bathimetry.csv