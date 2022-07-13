FROM lujiefsi/hadoop-base:database

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      python \
    && rm -rf /var/lib/apt/lists

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
