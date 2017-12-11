#!/bin/sh

# Wrapper to conform to the requirements of Terraform external data source
# accepts input as JSON and outputs a JSON result as per
# https://www.terraform.io/docs/providers/external/data_source.html and this comment
# https://github.com/hashicorp/terraform/pull/8768#issuecomment-257131458

set -ue
eval "$(jq -r '@sh "INSTANCE_TYPE=\(.instance_type) AZ=\(.az) REGION=\(.region) AWS_PROFILE=\(.aws_profile)"')"

end_date=$(date +"%Y-%m-%dT%H:%M:%S")
start_date=$(date -v -7d  +"%Y-%m-%dT%H:%M:%S")
price_changes=$(aws ec2 --profile "$AWS_PROFILE" --region "$REGION" describe-spot-price-history --product-description "Linux/UNIX" --instance-types $INSTANCE_TYPE --start-time "$start_date" --end-time "$end_date")

max_price=$(jq -r '.SpotPriceHistory| max_by(.SpotPrice) | .SpotPrice' <<< "$price_changes")
jq -n --arg max_price "$max_price" '{"max_price":$max_price}'
# jq '.SpotPriceHistory[].SpotPrice' <<< $price_changes | sort