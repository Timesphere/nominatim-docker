FROM ubuntu:eoan

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get -y update -qq && \
    apt-get -y install locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install -y build-essential cmake g++ libboost-dev libboost-system-dev \
    postgresql-server-dev-11 postgresql-11-postgis-2.5 postgresql-contrib-11 \
    libboost-filesystem-dev libexpat1-dev zlib1g-dev libxml2-dev\
    libbz2-dev libpq-dev libgeos-dev libgeos++-dev libproj-dev \
    apache2 php php-pgsql libapache2-mod-php php-pear php-db \
    php-intl git curl sudo \
    python3-pip libboost-python-dev \
    osmosis && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/*

WORKDIR /app

# Nominatim install
ENV NOMINATIM_VERSION v3.4.2
RUN git clone --recursive https://github.com/openstreetmap/Nominatim ./src
RUN cd ./src && git checkout tags/$NOMINATIM_VERSION && git submodule update --recursive --init && \
    mkdir build && cd build && cmake .. && make

# Osmium install to run continuous updates
RUN pip3 install osmium

# Apache configure
COPY local.php /app/src/build/settings/local.php
COPY nominatim.conf /etc/apache2/sites-enabled/000-default.conf

# Load initial data
RUN chmod o=rwx /app/src/build

EXPOSE 8080

COPY start.sh /app/start.sh
COPY startapache.sh /app/startapache.sh
COPY init.sh /app/init.sh

CMD [". /app/start.sh"]
