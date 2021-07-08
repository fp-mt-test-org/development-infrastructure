#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

./infrastructure/gcloud/setup-kubectl-for-gcloud.sh

kubectl \
    create namespace ${service_name}-service-dev \
    --dry-run=client \
    -o yaml | kubectl apply -f -

echo
echo "Provisioning of Kubernetes completed successfully!"
