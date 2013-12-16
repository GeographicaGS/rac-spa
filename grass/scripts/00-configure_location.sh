#!/bin/bash

# Enviroment variables

export PG_LIST_ALL_TABLES=YES
host=localhost
port=5432
user=racspa
pass=racspa
dbname=racspa

# Set projection

g.proj -c proj4="+proj=merc +a=6378137 +b=6378137 \
			 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 \
			 +units=m +nadgrids=@null +wktext +no_defs"

g.region n=4272313 s=4166585 w=-404256 e=-230490 -s

v.in.ogr dsn="PG:host=${host} dbname=${dbname} user=${user} port=${port}" \
		layer=context.active_survey output=survey --verbose --overwrite -o

v.voronoi --overwrite --verbose input=survey output=survey_voronoi

v.out.ogr input=survey_voronoi@PERMANENT type=area \
		dsn="PG:host=${host} dbname=${dbname} user=${user} port=${port}" \
		format=PostgreSQL olayer=trash.voronoi --verbose --overwrite lco="GEOMETRY_NAME=geom" \
		lco="FID=gid"
