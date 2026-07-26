# ADR 0001: Focus the repository on Spark platform engineering

- Status: Accepted
- Date: 2026-07-18

## Context

The `bigdata-platform-lab` repository needs a clear technical identity. Broad coverage of
unrelated data tools would reduce the time available for Spark internals,
cluster-runtime behavior, performance analysis, and platform operations.

## Decision

Use the repository name `bigdata-platform-lab` and focus implementation on Hadoop,
Spark, Kubernetes, and Terraform-provisioned EC2 infrastructure.

Hadoop provides the HDFS and YARN foundations needed to understand traditional
Spark deployments. Spark is the primary subject. Kubernetes and EC2 provide the
cloud-native environment used to deploy and operate Spark workloads.

## Consequences

- New setup directories are created only when their implementation begins.
- Shared workloads must remain portable across Spark runtime modes.
- Datasets remain supporting fixtures rather than a new platform domain.
- JVM knowledge is documented within Spark because it directly supports Spark
  memory, garbage collection, serialization, and failure analysis.
- A dedicated Hadoop cluster on EC2 is not part of the core repository scope.
