[TOC]

# 使用 docker 编译和运行 Pika 

## 生成用于编译 Pika 的 Docker 基础镜像 
pika 是由 C++ 编写，编译 Pika 需要依赖 cmake3、GCC9 和很多第三方库、为了避免每次搭建可以编译 Pika 的环境，使用 Docker 生成一个基础的 Pika 编译环境镜像，在镜像中集成了编译 Pika 和 Codis 所需要的软件和库。

运行下面的命令编译基础镜像，基础镜像只需要编译执行一次即可。
```
./build_docker.sh
```
生成的镜像名字为 pika/pika_build:v0.1

## 使用 Docker 编译 Pika

### 使用脚本自动编译 Pika
```
./build_pika.sh -b
```

### 使用容器手动编译 Pika
启动并进入容器
```
docker run  -it  --rm  -v [源码目录]/github.com/OpenAtomFoundation/pika:/pika -h pika_build --privileged --name pika_build pika/pika_build:v0.1 /bin/bash
```
进入容器后，手动编译 Pika
```
# cd /pika
# ./build.sh
```

## 使用 Docker 编译 Codis

### 使用脚本自动编译 Codis
```
./build_pika.sh -o
```

### 使用容器手动编译 Codis
启动并进入容器
```
docker run  -it  --rm  -v [源码目录]/github.com/OpenAtomFoundation/pika:/pika -h pika_build --privileged --name pika_build pika/pika_build:v0.1 /bin/bash
```
进入容器后，手动编译 Codis
```
# cd /pika/codis
# make
```

## 运行主从单实例 Pika 服务
后台运行主从单实例 Pika 服务
```
docker-compose -f pika-compose.yaml up -d
```

停止主从单实例 Pika 服务
```
docker-compose -f pika-compose.yaml down
```

## 运行 Codis Pika 集群服务（Etcd）

后台运行 Codis Pika 集群
```
docker-compose -f pika-cluster-compose.yaml up -d
```

停止 Codis Pika 集群
```
docker-compose -f pika-cluster-compose.yaml down
```