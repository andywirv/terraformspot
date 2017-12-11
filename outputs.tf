output "SSH Login:" {
  value = "ssh -i ./generated_files/${random_pet.cluster_id.id}.key core@${aws_spot_instance_request.dcos_config_generator.public_ip}"
}

output "IP Whitelisted for SSH Access" {
  value = "${data.external.my_ip.result.my_ip}"
}

output "Max Spot Price Last 7 days" {
  value = "${data.external.max_spot_price.result.max_price}"
}
