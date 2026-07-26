# Spark Runtime Model

## Role of Spark

Spark is the central subject of `k8s-bigdata`. The repository studies how the
same application behaves when resource allocation, driver placement, executor
lifecycle, logging, and failure handling are controlled by different runtimes.

## Execution targets

| Target | Cluster manager | Primary observation |
| --- | --- | --- |
| Local | In-process threads | Query plans, jobs, stages, tasks, and baseline correctness |
| Standalone | Spark master and workers | Driver placement, worker resources, executor lifecycle |
| YARN | ResourceManager and NodeManagers | ApplicationMaster, containers, queues, and HDFS access |
| Kubernetes native | Kubernetes scheduler | Driver/executor pods, RBAC, resources, storage, and logs |
| Kubernetes operator | Kubernetes controller and CRDs | Declarative submission, status, retries, and lifecycle policy |

EC2/k3s is a deployment environment for the Kubernetes targets. It is not an
additional Spark runtime and must reuse the same Spark image and manifests used
by the local Kubernetes environment.

## Shared workload contract

Runtime comparison is valid only when application logic remains unchanged.
Shared jobs therefore accept runtime-specific details through arguments and
configuration:

```text
shared job
  +-- input URI
  +-- output URI
  +-- run identifier
  +-- workload profile
  `-- Spark configuration
```

Smoke workloads verify submission and basic execution. Analytical workloads
exercise joins, aggregation, repartitioning, skew, shuffle, and output
partitioning. Runtime adapters may change packaging and storage locations but
must not fork the transformation logic.

## Core analysis areas

- Driver and executor process lifecycle
- DAG, job, stage, task, and query-plan relationships
- Narrow and wide transformations
- Partitioning, repartition, coalesce, and file layout
- Broadcast hash join, sort-merge join, AQE, and skew handling
- Executor sizing, unified memory, overhead, garbage collection, and spill
- Spark UI, event logs, History Server, and application logs
- Retry behavior, lost executors, driver failure, and invalid configuration

## JVM boundary

JVM knowledge belongs inside the Spark domain. Labs and documentation should
cover heap and off-heap memory, garbage collection, serialization, classpaths,
dependency conflicts, thread dumps, heap dumps, and container memory overhead.
For PySpark, analysis must also distinguish Python worker memory from executor
JVM memory.

## Operator boundary

The repository must select and pin one operator implementation before adding
operator manifests. The CRD, supported Spark version, Kubernetes compatibility,
upgrade policy, and project maturity must be recorded in a design decision.
Native `spark-submit` remains required because an operator must not hide the
underlying driver and executor lifecycle.

## References

- [Spark Cluster Mode Overview](https://spark.apache.org/docs/latest/cluster-overview.html)
- [Running Spark on YARN](https://spark.apache.org/docs/latest/running-on-yarn.html)
- [Running Spark on Kubernetes](https://spark.apache.org/docs/latest/running-on-kubernetes.html)
