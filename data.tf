data "external" "my_ip" {
  program = ["./scripts/myip.sh"]
}

data "external" "max_spot_price" {
  query = {
    instance_type = "${var.instance_size}"
    az            = "${var.aws_region}-1a"
    region        = "${var.aws_region}"
    aws_profile   = "${var.aws_profile}"
  }

  program = ["./scripts/spotinstancepricing.sh"]
}

data "external" "ssh_public_key" {
  program = ["./scripts/getpublickey.sh"]

  query = {
    cluster_id = "${random_pet.cluster_id.id}"
  }
}
