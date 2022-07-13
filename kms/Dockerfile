FROM lujiefsi/hadoop-base:database

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

ENV HADOOP_KEYSTORE_PASSWORD 123456

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9600

CMD ["/run.sh"]
