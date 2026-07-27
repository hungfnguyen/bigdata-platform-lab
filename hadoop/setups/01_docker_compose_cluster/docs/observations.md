# Observations

Verified on 2026-07-26 with Docker Engine 29.1.3 on `linux-x86_64`,
Hadoop 3.5.0, and Temurin Java 17.0.19.

## Results

- HDFS registered three live DataNodes.
- The 36-byte fixture produced one block with three live replicas.
- Stopping one DataNode produced two live nodes, one dead node,
  `Live_repl=2`, and one under-replicated block.
- The file remained `HEALTHY`; restarting the DataNode restored three replicas.
- YARN registered three NodeManagers with 3072 MiB and 6 vcores in total.
- WordCount completed with one map and one reduce and returned the expected
  four word counts.
- Killing `nodemanager-3` changed `nodemanager-3:8041` to `LOST`.
- The DistributedShell application remained running, retried lost containers,
  and finished with `Final-State: SUCCEEDED`.
- HDFS data remained available after `docker compose down` and a full restart.
- The destroy command refused to run without confirmation and removed all four
  persistent HDFS volumes when confirmation was supplied.

## Troubleshooting

- Hadoop 3.5.0 requested 1536 MiB for the default MapReduce ApplicationMaster.
  The lab config sets the AM to 512 MiB to fit its 1024 MiB scheduler limit.
- Graceful NodeManager shutdown does not produce `LOST`; SIGKILL is required to
  exercise heartbeat expiry.
- The correct expiry key is `yarn.nm.liveness-monitor.expiry-interval-ms`.
- DataNode state and block replication views can converge at different times,
  so the drill polls both independently.
