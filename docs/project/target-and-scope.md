# Project Target and Scope

## Identity

`bigdata-platform-lab` is a focused Hadoop and Spark platform engineering lab. It exists
to demonstrate understanding of distributed storage, Spark execution, cluster
managers, Kubernetes-native operation, infrastructure automation, and
performance diagnosis.

Spark is the core skill represented by the repository. Hadoop provides the
traditional HDFS and YARN foundation. Kubernetes and Terraform-provisioned EC2
provide the cloud-native platform environment.

## Target capabilities

The repository should provide evidence that its author can:

- Explain how Spark drivers, executors, jobs, stages, and tasks interact.
- Diagnose shuffle, skew, spill, memory pressure, and failed applications.
- Compare Spark standalone, YARN, and Kubernetes execution models.
- Operate HDFS and YARN through normal and degraded conditions.
- Configure Kubernetes identity, resources, storage, and debugging for Spark.
- Reproduce an EC2 k3s environment with Terraform and tear it down safely.
- Support technical conclusions with logs, Spark UI metrics, and benchmarks.

## In scope

- HDFS architecture and operations
- YARN architecture and Spark on YARN
- Spark local and standalone modes
- Spark on Kubernetes through native submission
- One explicitly selected Kubernetes Spark operator
- Spark UI, History Server, JVM diagnostics, and performance tuning
- Local Kubernetes and Terraform-provisioned EC2/k3s environments
- Small deterministic fixtures and immutable benchmark snapshots

## Out of scope

- Kafka, Hive, Trino, Airflow, dbt, ClickHouse, and BI applications
- A general-purpose data platform containing many loosely connected services
- Production deployment of HDFS on Kubernetes
- A dedicated Hadoop cluster on EC2 as a core deliverable
- Full Hadoop security and governance implementation
- Claims that local or EC2 lab environments are production systems

## Design principle

Depth is measured by observed behavior, not by the number of installed tools.
Every setup must explain what it models, what it cannot model, and what evidence
supports its conclusions.
