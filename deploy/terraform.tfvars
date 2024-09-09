# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

project_id = "prime-granite-432915-v0"
region     = "us-central1"
zone       = "us-central1-b"
vault_app = "mysite"       # Name of Hashicorp Cloud secrets application.
repository_name = "mysite" # The repository configured in the github.tf . If the repo has already been created before,
                           # it must be imported via Terraform.
