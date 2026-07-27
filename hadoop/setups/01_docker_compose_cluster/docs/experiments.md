# Experiments

## HDFS storage

Command:

```bash
make hadoop-smoke-hdfs
```

Expected:

- Three DataNodes are live.
- The committed fixture can be written and read unchanged.
- `hdfs fsck` shows one block with three replica locations.

Evidence: checksum, cluster report, and block locations printed by the script.

## DataNode loss

Command:

```bash
make hadoop-drill-datanode
```

Expected:

- `datanode-3` becomes dead after the heartbeat timeout.
- The test block remains readable but is under-replicated.
- Returning the DataNode restores three live replicas.

Evidence: degraded and recovered `dfsadmin` and `fsck` output.

## MapReduce on YARN

Command:

```bash
make hadoop-smoke-yarn
```

Expected output:

```text
hadoop  2
hdfs    1
spark   2
yarn    1
```

Evidence: exact HDFS output and three registered NodeManagers.

## NodeManager loss

Command:

```bash
make hadoop-drill-nodemanager
```

Expected:

- A DistributedShell application is running when `nodemanager-3` is killed.
- ResourceManager reports the node as `LOST`.
- Retried containers complete and the application succeeds.
- The restarted NodeManager returns to `RUNNING`.

Evidence: application reports and YARN node-state output.

## References

- [Hadoop single-node and Docker setup](https://hadoop.apache.org/docs/r3.5.0/hadoop-project-dist/hadoop-common/SingleCluster.html)
- [HDFS architecture](https://hadoop.apache.org/docs/r3.5.0/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html)
- [HDFS commands](https://hadoop.apache.org/docs/r3.5.0/hadoop-project-dist/hadoop-hdfs/HDFSCommands.html)
- [YARN commands](https://hadoop.apache.org/docs/r3.5.0/hadoop-yarn/hadoop-yarn-site/YarnCommands.html)
