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

echo "Inputs:"
echo "artifactory_base_url: ${artifactory_base_url}"
echo "project_name: ${project_name}"
echo
echo "Creating..."
echo 

(
    cd terraform

    docker run \
        -w /tform \
        --volume ~/git/development-infrastructure/terraform:/tform \
        hashicorp/terraform plan \
        -var="github_repo_name=${project_name}" \
        -var="artifactory_base_url=${artifactory_base_url}" \
        -out provision.plan

    echo
    echo "Plan created, applying..."

    docker run \
        -w /tform \
        --volume ~/git/development-infrastructure/terraform:/tform \
        hashicorp/terraform apply \
        provision.plan
)

echo "${project_name} set up completed successfully!"
