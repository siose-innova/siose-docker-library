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

# Restore backup
ogr2ogr -f "PostgreSQL" "PG:dbname=db schemas=public user=postgres password=postgres" "/data/castellon.shp" -lco GEOMETRY_NAME=geom -lco FID=gid -lco PRECISION=no -nlt PROMOTE_TO_MULTI -nln roi -overwrite



# Now restore using concurrent import
pg_restore -d postgresql://postgres:postgres@dbm/db -j 3 -O -x /data/dump2005-castellon
