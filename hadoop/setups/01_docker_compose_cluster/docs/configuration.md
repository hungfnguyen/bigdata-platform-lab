# Configuration

## HDFS

| Setting | Value | Reason |
| --- | --- | --- |
| `fs.defaultFS` | `hdfs://namenode:8020` | Gives clients one logical HDFS endpoint. |
| `dfs.replication` | `3` | Places one replica on every lab DataNode. |
| Name/DataNode dirs | Separate named volumes | Keeps metadata and block storage independent. |
| Hostname-based transfer | Enabled | Docker DNS resolves daemon hostnames inside the lab network. |
| Registration IP check | Disabled | Container IP and hostname reverse lookup is not reliable. |
| Heartbeat/recheck | `3s` / `5s` | Makes node-loss experiments complete in about 40 seconds. |

The short failure-detection interval and disabled registration check are lab
settings. Production values depend on network stability and host DNS.

## YARN and MapReduce

| Setting | Value | Reason |
| --- | --- | --- |
| NodeManager resources | `1024 MiB`, `2` vcores | Keeps three workers usable on a laptop. |
| Scheduler range | `256-1024 MiB` | Supports small deterministic containers. |
| AM, map, and reduce containers | `512 MiB`, `-Xmx384m` | Fits the scheduler and leaves memory outside the Java heap. |
| NodeManager expiry | `15s` | Makes `LOST` state observable during drills. |
| NodeManager ports | `8040-8042` | Keeps each hostname's NodeID stable after restart. |
| Virtual-memory check | Disabled | JVM virtual address space is misleading in containers. |
| Log aggregation | Enabled | Makes finished application logs available through YARN. |

Physical-memory checks remain enabled. The cluster uses the default Capacity
Scheduler and Hadoop simple authentication.

## Persistent state

Only NameNode and DataNode storage is persistent. NodeManager local files and
daemon logs are container-local because restart recovery is not the subject of
this lab.

The NameNode is formatted only through `make hadoop-format`. Image construction
never initializes runtime state.
