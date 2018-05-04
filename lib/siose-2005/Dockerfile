FROM sioseinnova/postgis-ext

#################
# Download data #
#################
WORKDIR /data

RUN wget https://www.dropbox.com/s/d1rukoz1qv6ldu7/castellon.tar.gz \
&& tar zxvpf castellon.tar.gz && rm castellon.tar.gz

WORKDIR /


ADD init-db.sh /docker-entrypoint-initdb.d/init-db.sh
