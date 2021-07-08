#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

terraform_path=$(realpath ./project-archetypes/service/terraform)

provision_kubernetes_path=$(realpath ./infrastructure/kubernetes/provision-kubernetes.sh)
provision_artifactory_path=$(realpath ./infrastructure/artifactory/provision-artifactory.sh)

# Provision Artifactory
github_repo_name="${service_name}" terraform_path="${terraform_path}" "${provision_artifactory_path}"

# Provision Kubernetes
service_name="${service_name}" "${provision_kubernetes_path}"

echo "${service_name} set up completed successfully!"
