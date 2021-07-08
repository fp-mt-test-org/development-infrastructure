#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

terraform_path=$(realpath ./project-archetypes/library/terraform)
provision_script_path=$(realpath ./infrastructure/artifactory/provision-artifactory.sh)

github_repo_name="${library_name}" \
    terraform_path="${terraform_path}" \
    "${provision_script_path}"

echo "${library_name} set up completed successfully!"
