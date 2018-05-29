#!/bin/bash -e

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

echo "Load extensions into $POSTGRES_DB"
for DB in "$POSTGRES_DB"; do

	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE SCHEMA s2005;
		CREATE SCHEMA s2011;
EOSQL
done

#############
# Load data #
#############

# Import sample data
#ogr2ogr -f "PostgreSQL" "PG:dbname=db schemas=public user=postgres password=postgres" "/data/castellon.shp" -lco GEOMETRY_NAME=geom -lco FID=gid -lco PRECISION=no -nlt PROMOTE_TO_MULTI -nln roi -overwrite
shp2pgsql -s 4326 /data/castellon.shp public.roi | psql -d db -U postgres


# Now restore using concurrent import
pg_restore -d db -U postgres -j 3 -O -x /data/dump2005-castellon
