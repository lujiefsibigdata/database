DOCKER_NETWORK = database_default
ENV_FILE = hbase-distributed-local.env
current_branch = database
PHOENIX_HOME =  /opt/phoenix-hbase-2.4.0-5.1.2-bin
build:
	docker build -t lujiefsi/atlas:$(current_branch) ./atlas
	docker build -t lujiefsi/atlas:$(current_branch)-distributed ./atlas-distributed
	docker build -t lujiefsi/hbase-base:$(current_branch) ./hbase
	docker build -t lujiefsi/hbase-master:$(current_branch) ./hmaster
	docker build -t lujiefsi/hbase-regionserver:$(current_branch) ./hregionserver
	docker build -t lujiefsi/hadoop-base:$(current_branch) ./hadoop
	docker build -t lujiefsi/hadoop-namenode:$(current_branch) ./namenode
	docker build -t lujiefsi/hadoop-datanode:$(current_branch) ./datanode
	docker build -t lujiefsi/hadoop-kms:$(current_branch) ./kms
	docker build -t lujiefsi/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t lujiefsi/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t lujiefsi/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t lujiefsi/hadoop-encryption:$(current_branch) ./encryption
test:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} lujiefsi/hbase-base:$(current_branch) psql.py zookeeper:2181 $(PHOENIX_HOME)/examples/WEB_STAT.sql $(PHOENIX_HOME)/examples/WEB_STAT.csv $(PHOENIX_HOME)/examples/WEB_STAT_QUERIES.sql
