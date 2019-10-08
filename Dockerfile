FROM fabric8/java-centos-openjdk11-jre

VOLUME /tmp

USER root

RUN yum -y install bind-utils

RUN curl -SLO https://www.foundationdb.org/downloads/6.1.8/rhel7/installers/foundationdb-clients-6.1.8-1.el7.x86_64.rpm
RUN rpm -Uvh foundationdb-clients-6.1.8-1.el7.x86_64.rpm \
    foundationdb-clients-6.1.8-1.el7.x86_64.rpm

RUN mkdir -p /app
WORKDIR /app

COPY --from=foundationdb/foundationdb:6.1.8 /usr/lib/libfdb_c.so /usr/lib
COPY --from=foundationdb/foundationdb:6.1.8 /usr/bin/fdbcli /usr/bin/
COPY --from=foundationdb/foundationdb:6.1.8 /var/fdb/scripts/create_cluster_file.bash /app

EXPOSE 8080

COPY start.bash /app
RUN chmod u+x /app/start.bash

COPY target/fdb-docker-compose-sample-1.0.0-SNAPSHOT.jar /app/app.jar
CMD /app/start.bash