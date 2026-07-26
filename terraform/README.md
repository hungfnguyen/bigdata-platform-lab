# Terraform

Terraform owns the AWS resources required for the EC2 k3s Spark lab. Kubernetes
and Spark configuration remain outside the Terraform root module unless a clear
infrastructure dependency requires otherwise.

See [Kubernetes and Infrastructure](../docs/platform/kubernetes-and-infrastructure.md)
for the target environment and ownership boundaries.

No Terraform state, plan files, credentials, or private keys may be committed.
