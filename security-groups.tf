resource "aws_security_group" "spot_instance" {
  name   = "spot-instance-terraform-example"
  vpc_id = "${aws_default_vpc.default.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.my_ip.result.my_ip}/32"]
  }
}
