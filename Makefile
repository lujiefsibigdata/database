DOCKER_NETWORK = database
ENV_FILE = hadoop.env
current_branch = database
build:
	docker build -t lujiefsi/hbase-base:$(current_branch) ./hbase
	docker build -t lujiefsi/hbase-master:$(current_branch) ./hmaster
	docker build -t lujiefsi/hbase-regionserver:$(current_branch) ./hregionserver
	docker build -t lujiefsi/hadoop-base:$(current_branch) ./hadoop
	docker build -t lujiefsi/hadoop-namenode:$(current_branch) ./namenode
	docker build -t lujiefsi/hadoop-datanode:$(current_branch) ./datanode
	docker build -t lujiefsi/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t lujiefsi/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t lujiefsi/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t lujiefsi/hadoop-submit:$(current_branch) ./submit
wordcount:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} lujiefsi/hadoop-base:$(hadoop_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} lujiefsi/hadoop-base:$(hadoop_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-2.7.4/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} lujiefsi/hadoop-base:$(hadoop_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} lujiefsi/hadoop-base:$(hadoop_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} lujiefsi/hadoop-base:$(hadoop_branch) hdfs dfs -rm -r /input
