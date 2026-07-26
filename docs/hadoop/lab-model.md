# Hadoop Lab Model

## Purpose

Hadoop is included to establish the storage and resource-management concepts
required to understand Spark on traditional data platforms. It is a supporting
foundation, not the primary identity of the repository.

## Local topology

The Hadoop lab targets two local execution models:

| Model | Processes | Purpose |
| --- | --- | --- |
| Pseudo-distributed | NameNode, DataNode, ResourceManager, NodeManager | Learn configuration and daemon responsibilities on one host. |
| Docker Compose cluster | NameNode, three DataNodes, ResourceManager, NodeManagers, JobHistory Server | Model process isolation, replication, scheduling, and component failure. |

The Compose cluster should use a shared definition with separate HDFS and YARN
profiles instead of duplicating two almost identical environments.

## Required knowledge

- HDFS namespace, blocks, checksums, replication, and heartbeats
- NameNode metadata, safemode, checkpoints, and recovery
- DataNode storage, failure reporting, decommissioning, and balancing
- ResourceManager, NodeManager, ApplicationMaster, and YARN containers
- YARN application logs, resource allocation, and Spark on YARN
- Client versus cluster deployment behavior

## Operational exercises

The lab must include observable failure scenarios:

- Stop a DataNode and inspect block health and under-replication.
- Restore a DataNode and verify recovery behavior.
- Inspect block placement with `hdfs fsck`.
- Exercise safemode and document its effect on writes.
- Run the balancer and explain when it is useful.
- Stop a NodeManager during a job and inspect container/application behavior.
- Submit Spark on YARN and collect driver and executor logs.

## Production boundary

Docker Compose models daemon boundaries and failure mechanics; it does not model
independent hardware, racks, real disks, network partitions, Kerberos, or a
production operating model.

Production concepts such as NameNode HA, Quorum Journal Manager, ZooKeeper/ZKFC,
ResourceManager HA, rack awareness, security, rolling upgrades, and capacity
planning should be explained and may be simulated selectively. They are not
required to become a second infrastructure project.

HDFS on Kubernetes and a dedicated multi-node Hadoop deployment on EC2 remain
outside the core scope.

## References

- [HDFS User Guide](https://hadoop.apache.org/docs/current3/hadoop-project-dist/hadoop-hdfs/HdfsUserGuide.html)
- [HDFS High Availability with QJM](https://hadoop.apache.org/docs/current3/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html)
