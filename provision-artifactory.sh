#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

source ./scripts/validation-tools.sh

validate "artifactory_base_url"
validate "artifactory_username"
validate "artifactory_password"

terraform_path="$(realpath ./terraform)"

echo "terraform_path: $terraform_path"

docker run \
    -w /tform \
    --volume "${terraform_path}:/tform" \
    hashicorp/terraform init

docker run \
    -w /tform \
    --volume "${terraform_path}:/tform" \
    hashicorp/terraform plan \
    -var="github_repo_name=${project_name}" \
    -var="artifactory_base_url=${artifactory_base_url}" \
    -var="artifactory_username=${artifactory_username}" \
    -var="artifactory_password=${artifactory_password}" \
    -out provision.plan

echo
echo "Plan created, applying..."

docker run \
    -w /tform \
    --volume "${terraform_path}:/tform" \
    hashicorp/terraform apply \
    provision.plan


echo "Artifactory provisioning completed!"