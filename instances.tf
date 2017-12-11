data "template_file" "user_data" {
  template = "${file("templates/mask_services.yml.tpl")}"
}

resource "aws_spot_instance_request" "dcos_config_generator" {
  # use of __builtin_StringToFloat is a workaround as per
  # https://github.com/hashicorp/terraform/issues/14967#issuecomment-305277001
  ami = "${lookup(var.coreos_images, var.aws_region)}"

  spot_price             = "${data.external.max_spot_price.result.max_price * __builtin_StringToFloat(var.percentage_of_max)}"
  wait_for_fulfillment   = true
  spot_type              = "one-time"
  user_data              = "${data.template_file.user_data.rendered}"
  instance_type          = "c4.large"
  key_name               = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids = ["${aws_security_group.spot_instance.id}"]

  root_block_device {
    volume_size = 50
    volume_type = "standard"
  }

  tags {
    Name = "terraform managed"
  }
}
