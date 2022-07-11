FROM centos:7

RUN groupadd hadoop && \
	useradd -m -d /opt/atlas -g hadoop atlas


COPY apache-atlas-2.2.0-server.tar.gz /apache-atlas.tar.gz

RUN yum update -y \
	&& yum install -y python python36 java-1.8.0-openjdk java-1.8.0-openjdk-devel net-tools \
	&& yum clean all

RUN pip3 install amundsenatlastypes==1.1.0

USER atlas
RUN cd /opt \
	&& tar xzf /apache-atlas.tar.gz -C /opt/atlas --strip-components=1

USER root

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

USER atlas

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]

EXPOSE 21000
