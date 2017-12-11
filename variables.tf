variable "aws_profile" {
  default = "zooz-dev"
}

variable "instance_size" {
  default = "c4.large"
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "percentage_of_max" {
  default = 1.1
}

#CoreOS-stable-1235.9.0-hvm
variable "coreos_images" {
  type = "map"

  default = {
    eu-central-1   = "ami-9501c8fa"
    ap-northeast-1 = "ami-885f19ef"
    ap-northeast-2 = "ami-d65889b8"
    ca-central-1   = "ami-c8c67bac"
    ap-south-1     = "ami-7e641511"
    sa-east-1      = "ami-3e5d3952"
    ap-southeast-2 = "ami-d92422ba"
    ap-southeast-1 = "ami-14cc7877"
    us-east-1      = "ami-fd6c94eb"
    us-east-2      = "ami-72032617"
    us-west-2      = "ami-4c49f22c"
    us-west-1      = "ami-b6bae7d6"
    eu-west-1      = "ami-ac8fd4ca"
    eu-west-2      = "ami-054c5961"
  }
}

provider "aws" {
  version = "~> 1.5"
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}

# generate a random name for the cluster
resource "random_pet" "cluster_id" {}

provider "random" {
  version = "~> 0.1"
}

provider "null" {
  version = "~> 0.1"
}
