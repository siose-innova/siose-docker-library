FROM sioseinnova/postgres-ext

ENV POSTGIS_MAJOR 2.4

RUN apt-get update \
&& apt-get install --yes --no-install-recommends \
	postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
	postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
	postgis \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

