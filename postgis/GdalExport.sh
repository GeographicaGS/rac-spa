#!/bin/bash

# Export RAC-SPA data to shapefile

PGHOST="localhost"
PGPORT="5432"
PGUSER="postgres"
PGDBAS="racspa"
PGPASS="postgres"

tables=(
		www.survey
		www.savalia_savaglia_map
		www.pinna_rudis_map
		www.ophidiaster_ophidianus_map
		www.cystoseira_mediterranea_map
		www.community_map
		www.bottom_map
		www.astroides_calycularis_map
)

names=(
		survey_points
		savalia_savaglia_map
		pinna_rudis_map
		ophidiaster_ophidianus_map
		cystoseira_mediterranea_map
		community_map
		bottom_map
		astroides_calycularis_map
)

epsg=(
		4326
		3857
		3857
		3857
		3857
		3857
		3857
		3857
)

export SHAPE_ENCODING='ISO-8859-1'

total=${#tables[@]}

for ((i=0;i<=$(($total-1));i++))
do
		echo "Exporting table ${tables[i]}"

		ogr2ogr -overwrite -f "ESRI Shapefile" shape_export/${names[i]} PG:"host=${PGHOST} user=${PGUSER} dbname=${PGDBAS} password=${PGPASS} port=${PGPORT}" ${tables[i]} -a_srs EPSG:${epsg[i]} -nln ${names[i]} -lco ENCODING=ISO-8859-1

		echo
done
