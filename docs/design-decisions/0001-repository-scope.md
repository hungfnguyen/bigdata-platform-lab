# ADR 0001: Focus the repository on Spark platform engineering

- Status: Accepted
- Date: 2026-07-18

## Context

The previous repository combined Hadoop, Hive, Spark, Kafka, SQL Server, and
notebook services. It demonstrated tool installation but did not provide enough
depth in Spark execution, deployment, tuning, or operations.

## Decision

Keep the repository name `k8s-bigdata` and focus implementation on Hadoop,
Spark, Kubernetes, and Terraform-provisioned EC2 infrastructure.

Hadoop provides HDFS and YARN foundations. Spark is the primary subject.
Kubernetes and EC2 provide the platform environment used to deploy and operate
Spark workloads.

## Consequences

- Existing Hive, Kafka, SQL Server, and notebook stacks are removed.
- New setup directories are created only when their implementation begins.
- Shared workloads must remain portable across Spark runtime modes.
- Datasets remain supporting fixtures rather than a new platform domain.
