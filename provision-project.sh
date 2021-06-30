#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

source ./scripts/validation-tools.sh

validate "project_name" 

# ./provision-artifactory.sh # Commenting out for now to speed up testing of k8s.
./provision-kubernetes.sh

echo "${project_name} set up completed successfully!"
