# Terraform

Terraform will provision the AWS resources required for the EC2 k3s Spark lab.
The first implementation will remain a single root module; reusable modules will
be introduced only when more than one environment needs the same abstraction.

No Terraform state, plan files, credentials, or private keys may be committed.
