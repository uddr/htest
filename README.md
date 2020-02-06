# htest

### K8s cluster on GCP cloud with Prometheus and Vault

### Prerequisites

1. GCP account
2. Install locally
    * gcloud SDK
    * kubectl
    * helm

## Steps:

1. Create GCP project.
2. Create service account for terraform.
    * Make sure that account has an Owner permissions for containers
    * Make sure that account has an Editor permissions for buckets, GKE, LB, etc...
3. Initialize gcloud for your GCP project
4. Create Bucket to store Terrform state
`
gsutil mb gs://dark-garden-256113-tfstate
gsutil versioning set on gs://dark-garden-256113-tfstate
`

5. Clone Vault Helm charts (for Vault installation only)
`
git clone https://github.com/hashicorp/vault-helm.git ../vault-helm
`

6. Run Terrform
    * Pass variables: account config file, bucket for Kubernetes, project name 
`terraform init`
`terraform plan`
`terraform apply`

### Vault and Prometheus are installed by local exec in terraform because modules do not work with Helm3.
Commands examples were used for Vault and Prometheus installation
`
helm --kubeconfig=modules/gke/kubeconfig install vault ../vault-helm
helm --kubeconfig=modules/gke/kubeconfig install -f modules/helm/monitoring/prometheus/values.yml prometheus stable/prometheus-operator
`
