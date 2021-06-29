#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [[ "${project_name:=}" == "" ]]; then
    echo "project_name value is missing, please specify it to run:"
    echo
    echo "   project_name=cool-proj ... flex provision-project"
    echo
    exit 1
fi

if [[ "${artifactory_base_url:=}" == "" ]]; then
    echo "artifactory_base_url value is missing, please specify it to run:"
    echo
    echo "   artifactory_base_url=https://artifactory.base.url ... flex provision-project"
    echo
    exit 1
fi

if [[ "${artifactory_username:=}" == "" ]]; then
    echo "artifactory_username value is missing, please specify it to run:"
    echo
    echo "   artifactory_username=username ... flex provision-project"
    echo
    exit 1
fi

if [[ "${artifactory_password:=}" == "" ]]; then
    echo "artifactory_password value is missing, please specify it to run:"
    echo
    echo "   artifactory_password=username ... flex provision-project"
    echo
    exit 1
fi

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


echo "${project_name} set up completed successfully!"
