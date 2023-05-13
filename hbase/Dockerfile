FROM lujiefsi/atlas:database as atlas

FROM public.ecr.aws/docker/library/openjdk:8

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends net-tools curl netcat python

ENV HBASE_VERSION 2.4.0
ENV HBASE_URL https://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz
RUN set -x \
    && curl -fSL "$HBASE_URL" -o /tmp/hbase.tar.gz \
    && curl -fSL "$HBASE_URL.asc" -o /tmp/hbase.tar.gz.asc \
    && tar -xvf /tmp/hbase.tar.gz -C /opt/ \
    && rm /tmp/hbase.tar.gz*

ENV PHOENIX_URL https://archive.apache.org/dist/phoenix/phoenix-5.1.2/phoenix-hbase-2.4.0-5.1.2-bin.tar.gz
RUN set -x \
    && curl -fSL "$PHOENIX_URL" -o /tmp/phoenix.tar.gz \
    && tar -xvf /tmp/phoenix.tar.gz -C /opt/ \
    && rm /tmp/phoenix.tar.gz*

ENV PHOENIX_HOME /opt/phoenix-hbase-2.4.0-5.1.2-bin
ENV PHOENIX_CLASSPATH $PHOENIX_HOME
ENV PATH $PHOENIX_HOME/bin:$PATH



RUN ln -s /opt/hbase-$HBASE_VERSION/conf /etc/hbase
RUN mkdir /opt/hbase-$HBASE_VERSION/logs

RUN mkdir /hadoop-data

ENV HBASE_PREFIX=/opt/hbase-$HBASE_VERSION
ENV HBASE_CONF_DIR=/etc/hbase

ENV USER=root
ENV PATH $HBASE_PREFIX/bin/:$PATH
RUN cp $PHOENIX_HOME/phoenix-server-hbase-2.4.0-5.1.2.jar $HBASE_PREFIX/lib

COPY --from=atlas /opt/atlas/hook/hbase/ /opt/hbase-$HBASE_VERSION/lib
#COPY --from=atlas /opt/apache-atlas-hbase-hook-2.2.0/hook/hbase/hbase-bridge-shim-2.2.0.jar /opt/hbase-$HBASE_VERSION/lib
#COPY --from=atlas /opt/apache-atlas-hbase-hook-2.2.0/hook/hbase/atlas-hbase-plugin-impl /opt/hbase-$HBASE_VERSION/lib
ADD atlas-application.properties /opt/hbase-$HBASE_VERSION/conf/atlas-application.properties

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
