#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [[ "${project_name:=}" == "" ]]; then
    echo "project_name value is missing, please specify it to run:"
    echo
    echo "   project_name=cool-proj flex provision-project"
    echo
    exit 1
fi

echo "Creating ${project_name}!"
echo 

(
    cd terraform

    docker run \
        -w /tform \
        --volume ~/git/development-infrastructure/terraform:/tform \
        hashicorp/terraform plan \
        -var="github_repo_name=${project_name}" \
        -var-file=main.tfvars \
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
