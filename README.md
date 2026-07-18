# k8s-bigdata

A hands-on platform engineering lab for learning Hadoop, Apache Spark, and
Spark on Kubernetes.

## Overview

This repository explores how Spark applications run across different execution
environments, from local mode to cloud-hosted Kubernetes. It focuses on runtime
internals, cluster deployment, resource management, debugging, and performance
tuning.

## Topics

- HDFS and YARN fundamentals
- Spark driver, executor, job, stage, and task lifecycle
- Spark local, standalone, and YARN deployment modes
- Spark on Kubernetes and Spark Operator
- Kubernetes RBAC and resource management for Spark
- Terraform-provisioned EC2 infrastructure with k3s
- Spark performance tuning, benchmarking, and failure analysis

## Repository structure

```text
.
|-- docs/          Architecture, design decisions, and roadmap
|-- hadoop/        HDFS and YARN labs
|-- spark/         Spark runtimes, jobs, and tuning labs
|-- kubernetes/    Kubernetes resources for Spark
|-- terraform/     AWS EC2 and k3s infrastructure
|-- data/          Reproducible workload fixtures
`-- scripts/       Repository automation
```

## Learning path

```text
Hadoop -> Spark Local -> Standalone -> YARN -> Kubernetes
       -> Spark Operator -> EC2/k3s -> Benchmarking and Operations
```

The same Spark workloads are reused across runtime modes to make their
execution, resource usage, and failure behavior directly comparable.

## Roadmap

See [docs/roadmap.md](docs/roadmap.md) for the implementation phases and current
progress.

```bash
make help
make roadmap
```

## Status

Under active development.
