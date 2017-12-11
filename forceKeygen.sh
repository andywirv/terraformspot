terraform plan -target=null_resource.create_key -out createsshkey.plan && \
terraform apply createsshkey.plan
rm createsshkey.plan