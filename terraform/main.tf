terraform {
  required_providers {
    artifactory = {
      source = "jfrog/artifactory"
      version = "2.2.15"
    }
  }
}

variable "artifactory_base_url" {
    type = string
}

variable "artifactory_username" {
    type = string
}

variable "artifactory_password" {
    type = string
}

variable "github_repo_name" {
    type = string
}

# Configure the Artifactory provider
provider "artifactory" {
  url = "${var.artifactory_base_url}/artifactory"
  username = "${var.artifactory_username}"
  password = "${var.artifactory_password}"
}

resource "artifactory_local_repository" "sandbox" {
  key             = "${var.github_repo_name}-mvn-sandbox-local"
  package_type    = "maven"
  repo_layout_ref = "simple-default"
  description     = "A test repo created by Matthew with Terraform!"
}

resource "artifactory_local_repository" "dev" {
  key             = "${var.github_repo_name}-mvn-dev-local"
  package_type    = "maven"
  repo_layout_ref = "simple-default"
  description     = "A test repo created by Matthew with Terraform!"
}
