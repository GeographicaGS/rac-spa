exit
ls
cd scripts/
ls
chmod 755 00-configure_location.grass 
./00-configure_location.grass 
g.proj -p
./00-configure_location.grass 
./00-configure_location.grass 
./00-configure_location.grass 
g.region -l
g.region -p
g.region -l
./00-configure_location.grass 
./00-configure_location.grass 
./00-configure_location.grass 
./00-configure_location.grass 
./00-configure_location.grass 
./00-configure_location.grass 
ls
rm 00-configure_location
rm 00-configure_location.grass 
ls
chmod 755 00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
g.mremove vect=survey
g.mremove -f vect=survey
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
v.voronoi --overwrite --verbose input=survey output=survey_voronoi
./00-configure_location.sh 
exit
ls
cd ..
ls
cd scripts/
ls
less 00-configure_location.sh 
./00-configure_location.sh 
exit
exit
v.out.ogr input=survey_voronoi@PERMANENT type=area dsn="PG:host=localhost dbname=racspa user=racspa" olayer=trash.voronoi format=PostgreSQL lco="GEOMETRY_NAME=geom, FID=gif"
v.out.ogr input=survey_voronoi@PERMANENT type=area dsn=PG:host=localhost dbname=racspa user=racspa olayer=trash.voronoi format=PostgreSQL lco="GEOMETRY_NAME=geom, FID=gif"
v.out.ogr --verbose input=survey_voronoi@PERMANENT type=area dsn=PG:host=localhost dbname=racspa user=racspa olayer=trash.voronoi format=PostgreSQL lco=GEOMETRY_NAME=geom FID=gif
v.out.ogr --verbose input=survey_voronoi@PERMANENT type=area dsn=PG:host=localhost dbname=racspa user=racspa olayer=trash.voronoi format=PostgreSQL lco=GEOMETRY_NAME=geom FID=gif
cd ..
ls
cd grass/
ls
cd scripts/
ls
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
exit
cd scripts/
ls
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
./00-configure_location.sh 
exit
cd ..
cd scripts/
./00-configure_location.sh
./00-configure_location.sh
exit
