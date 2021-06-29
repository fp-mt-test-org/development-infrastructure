#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo "Installing gcloud..."

google_sdk_path='./google-cloud-sdk'
filename='google-cloud-sdk-346.0.0-darwin-x86_64.tar.gz'

if [[ -d "${google_sdk_path}" ]]; then
    download_url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${filename}"
    echo "Downloading ${download_url}"
    curl "${download_url}" --output "${filename}"
    tar -xzvf "${filename}"
fi

echo "Installing gcloud..."
./google-cloud-sdk/install.sh

echo
echo "Initializing gcloud..."
gcloud init

echo "Installing kubectl..."
gcloud install kubectl

echo "Setting up kubectl with creds..."
gcloud container clusters get-credentials cluster-1 --zone us-west1-a --project praxis-flight-317920

echo
echo "Provisioning of Kubernetes completed successfully!"
