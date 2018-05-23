FROM postgres:10

# Install packages required for developing extensions on Postgres
RUN apt-get update \
&& apt-get install --yes --no-install-recommends \
	build-essential \
	checkinstall \
	apt-utils \
	wget \
	ca-certificates \
	git-core \
	postgresql-server-dev-$PG_MAJOR \
	postgresql-contrib-$PG_MAJOR \
	postgresql-plpython3-$PG_MAJOR \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
