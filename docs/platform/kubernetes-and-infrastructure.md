# Kubernetes and Infrastructure

## Platform role

Kubernetes is the cloud-native cluster manager for Spark workloads in this
repository. Terraform provides the EC2 environment on which the same Kubernetes
configuration can be reproduced.

Ownership is intentionally separated:

```text
Terraform       -> EC2, networking, access, bootstrap, outputs
Kubernetes      -> namespace, identity, RBAC, storage, pod resources
Spark           -> image, application, executor policy, Spark configuration
```

## Kubernetes target

The Kubernetes layer covers:

- A lightweight local cluster for development and failure testing
- An EC2-hosted k3s cluster for reproducible cloud execution
- Namespace and ServiceAccount isolation
- Least-privilege Role and RoleBinding resources
- Driver and executor requests, limits, labels, and scheduling constraints
- ConfigMaps, Secrets, volumes, logs, events, and cleanup
- Native Spark submission and one selected Spark operator

The local and EC2 environments must consume the same Spark image and application
definition wherever environment-specific storage and access details permit.

## Terraform target

Terraform is responsible for the smallest useful AWS environment:

- EC2 compute
- Security groups and required network rules
- SSH access configuration without committed private keys
- k3s bootstrap through repeatable instance initialization
- Outputs needed by operators and automation
- Explicit teardown and cost-awareness documentation

The Terraform configuration should remain a single root module until reuse
across multiple environments justifies module extraction.

Managed Kubernetes, a dedicated Hadoop EC2 cluster, and broad AWS platform
coverage are outside scope.

## Storage boundary

Spark requires explicit locations for input, output, shuffle spill, and event
logs. A local-path or host-backed persistent volume is acceptable for a local or
single-node k3s lab, provided its node affinity and durability limits are stated.

A multi-node k3s topology requires a separate storage decision. It must not be
presented as portable or fault tolerant while relying on node-local volumes.
Shared or object storage should be introduced only through an explicit design
decision that changes repository scope.

## Production-like definition

The EC2 environment is production-like only in the limited sense that it uses
real networking, remote compute, infrastructure automation, Kubernetes identity,
resource controls, and operational teardown. It is not a production platform and
must not be described as highly available or fault tolerant without evidence.
