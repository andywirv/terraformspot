resource "null_resource" "create_key" {
  # Currently there is an issue whereby this resource will not have been
  # created before the data source 
  triggers {
    key = "${random_pet.cluster_id.id}"
  }

  provisioner "local-exec" {
    command = "mkdir -p ./generated_files && CLUSTER_NAME=${random_pet.cluster_id.id} && echo -e 'n' | ssh-keygen -o -b 4096 -t rsa -N '' -C generateduser@terraform -f ./generated_files/$CLUSTER_NAME.key && chmod 600 ./generated_files/$CLUSTER_NAME.key"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "CLUSTER_NAME=${random_pet.cluster_id.id} && rm ./generated_files/$CLUSTER_NAME.key && rm ./generated_files/$CLUSTER_NAME.pub"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "${random_pet.cluster_id.id}"
  public_key = "${data.external.ssh_public_key.result["ssh_pub_key"]}"
}
