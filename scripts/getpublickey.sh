#!/bin/sh

# Wrapper to conform to the requirements of Terraform external data source
# accepts input as JSON and outputs a JSON result as per
# https://www.terraform.io/docs/providers/external/data_source.html and this comment
# https://github.com/hashicorp/terraform/pull/8768#issuecomment-257131458

set -ue
eval "$(jq -r '@sh "CLUSTER_ID=\(.cluster_id)"')"
# Access the key generated by the resource "null_resource" "create_key"
SSH_PUB_KEY="$(cat ./generated_files/$CLUSTER_ID.key.pub)"
#Output from external data source will be accesible as ${data.external.ssh_public_key.result["ssh_pub_key"]}
jq -n --arg ssh_pub_key "$SSH_PUB_KEY" '{"ssh_pub_key":$ssh_pub_key}'