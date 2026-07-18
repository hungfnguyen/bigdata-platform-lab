# Implementation Roadmap

The repository is developed in vertical phases. A phase is complete only when
its setup is reproducible, has a smoke test, and documents normal operations and
known failure modes.

## Phase 1 - Repository foundation

- Define the project scope and non-goals.
- Establish domain ownership and documentation boundaries.
- Remove the legacy multi-tool Docker environment.

## Phase 2 - Hadoop foundations

- Build a pseudo-distributed Hadoop environment.
- Build a Docker Compose HDFS and YARN cluster.
- Add HDFS and YARN smoke tests and operational notes.

## Phase 3 - Spark local and standalone

- Build one reusable Spark image and shared configuration.
- Run the same workload in local and standalone modes.
- Inspect jobs, stages, tasks, executors, and event logs.

## Phase 4 - Spark on YARN

- Submit the shared workload to YARN in client and cluster modes.
- Compare YARN's ApplicationMaster and container lifecycle with standalone mode.

## Phase 5 - Spark on Kubernetes

- Create one lightweight local Kubernetes cluster.
- Configure namespace, service account, and RBAC.
- Run Spark through native `spark-submit`, then through Spark Operator.

## Phase 6 - EC2 infrastructure

- Provision EC2 networking and compute resources with Terraform.
- Bootstrap k3s and deploy the verified Kubernetes Spark setup.
- Keep infrastructure replaceable and document teardown procedures.

## Phase 7 - Performance and operations

- Benchmark a fixed, versioned workload across supported runtime modes.
- Investigate shuffle, skew, partitioning, spill, and executor sizing.
- Add failure drills, debugging guides, and evidence from Spark UI and logs.
