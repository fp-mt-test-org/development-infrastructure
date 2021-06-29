#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

source ./scripts/validation-tools.sh

validate "request_token"
validate "provision_token"

if [[ "${request_token}" != "${provision_token}" ]]; then
    echo "Invalid request_token"
    exit 1
fi

validate "project_name" 


# ./provision-artifactory.sh # Commenting out for now to speed up testing of k8s.
./provision-kubernetes.sh

echo "${project_name} set up completed successfully!"
