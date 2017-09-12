FROM debian:stretch

MAINTAINER Alexander Olofsson <ace@haxalot.com>

RUN apt-get update -yqq && apt-get install curl ca-certificates gnupg -yqq --no-install-recommends && curl https://matrix.org/packages/debian/repo-key.asc | apt-key add - \
    && echo "deb http://matrix.org/packages/debian/ stretch main" > /etc/apt/sources.list.d/synapse.list \
    && apt-get update -yqq \
    && apt-get install matrix-synapse python-matrix-synapse-ldap3 python-psycopg2 -yqq --no-install-recommends \
    && apt-get autoclean -yqq \
    && rm -rf /var/lib/apt/ /etc/matrix-synapse/ \
    && mkdir -p /etc/matrix-synapse/conf.d

ADD matrix-synapse.sh /usr/local/bin/matrix-synapse

EXPOSE 8008 8448
ENTRYPOINT [ "/usr/local/bin/matrix-synapse" ]
