#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo "Installing gcloud..."

google_sdk_path='./google-cloud-sdk'
filename='google-cloud-sdk-346.0.0-darwin-x86_64.tar.gz'

if [[ -d "${google_sdk_path}" ]]; then
    echo "${google_sdk_path} exists!"
else
    download_url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${filename}"
    echo "Downloading ${download_url}"
    curl "${download_url}" --output "${filename}"
    echo "Download complete, extracting..."
    tar -xzf "${filename}"
    echo "Extract complete."
    echo
fi

# "${google_sdk_path}"/install.sh

# gcloud="${google_sdk_path}/bin/gcloud"

# echo
# echo "Initializing gcloud..."
# "${gcloud}" init

# echo "Installing kubectl..."
# "${gcloud}" components install kubectl

# echo "Setting up kubectl with creds..."
# "${gcloud}" container clusters get-credentials cluster-1 --zone us-west1-a --project praxis-flight-317920
brew install kubectl 

key_file_path='key.json'
echo "${gcloud_service_account}" > "${key_file_path}"
gcloud auth activate-service-account --key-file="${key_file_path}" --project="${gcloud_project}"


# kube_path="$(realpath .kube)"
# config_path="${kube_path}/config"
# echo "Writing ${config_path}"

# kube_config="apiVersion: v1
# clusters:
# - cluster:
#     certificate-authority-data: ${k8s_cluster_certificate_authority_data}
#     server: ${k8s_cluster_server}
#   name: ${k8s_cluster_name}
# contexts:
# - context:
#     cluster: ${k8s_cluster_name}
#     user: ${k8s_user}
#   name: ${k8s_cluster_name}
# current-context: ${k8s_cluster_name}
# kind: Config
# preferences: {}
# users:
# - name: ${k8s_cluster_name}
#   user:
#     auth-provider:
#       config:
#         cmd-args: config config-helper --format=json
#         cmd-path: $(realpath .)/google-cloud-sdk/bin/gcloud
#         expiry-key: '{.credential.token_expiry}'
#         token-key: '{.credential.access_token}'
#       name: gcp"

# mkdir -p "${kube_path}"
# echo "${kube_config}" > "${config_path}"

# gcloud_config="[core]
# account = ${gcloud_account}
# project = ${gcloud_project}"
# gcloud_config_folder="${HOME}/.config/gcloud/configurations"
# mkdir -p "${gcloud_config_folder}"
# echo "${gcloud_config}" > "${gcloud_config_folder}/config_default"

# gcloud auth activate-service-account test-service-account@google.com --key-file=/path/key.json --project=testproject

kubectl config view 

kubectl cluster-info

kubectl get namespaces

echo
echo "Provisioning of Kubernetes completed successfully!"
