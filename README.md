[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/big-data-europe/Lobby)

# DataBase

编译
```
make
```

启动database
```
sudo docker-compose up -d
```
查看各个节点的状态：

```
sudo docker-compose ps
```

如果节点状态不健康：

```
docker inspect --format '{{json .State.Health}}' kms #  假设kms为不健康的节点
```

