# Hadoop Docker Compose Cluster

A local HDFS and YARN operations lab built from the official Apache Hadoop
binary distribution.

## Topology

```text
HDFS client -> NameNode -> DataNode 1
                       -> DataNode 2
                       -> DataNode 3

YARN client -> ResourceManager -> NodeManager 1
                              -> NodeManager 2
                              -> NodeManager 3
                              -> JobHistory Server
```

HDFS starts by default. The `yarn` profile adds YARN and JobHistory Server.

| Component | Version or size |
| --- | --- |
| Hadoop | 3.5.0 |
| Java | Temurin 17 |
| HDFS replicas | 3 |
| YARN capacity | 1024 MiB and 2 vcores per NodeManager |

## Requirements

- Docker with Compose
- At least 6 GiB assigned to Docker
- Ports `9870`, `8088`, `19888`, `9864-9866`, and `8042-8044`

## Run

```bash
make hadoop-build
make hadoop-format
make hadoop-hdfs-up
make hadoop-smoke-hdfs

make hadoop-yarn-up
make hadoop-smoke-yarn
```

Formatting is explicit and never overwrites existing NameNode metadata.

Inspect the cluster:

```bash
make hadoop-status
make hadoop-logs SERVICE=namenode
```

Web interfaces:

- NameNode: <http://localhost:9870>
- ResourceManager: <http://localhost:8088>
- JobHistory Server: <http://localhost:19888>
- DataNodes: `http://localhost:9864` through `9866`
- NodeManagers: `http://localhost:8042` through `8044`

## Failure exercises

```bash
make hadoop-drill-datanode
make hadoop-drill-nodemanager
```

Both drills restore the stopped daemon before exiting.

## Cleanup

```bash
make hadoop-down
make hadoop-destroy CONFIRM=DELETE_HADOOP_DATA
```

`hadoop-down` preserves HDFS volumes. `hadoop-destroy` deletes them.

## Boundary

This lab models daemon isolation, replication, scheduling, and component loss.
It does not model independent hosts, rack awareness, HA, Kerberos, production
disks, or production capacity.

See [configuration](docs/configuration.md),
[experiments](docs/experiments.md), and
[observations](docs/observations.md).
