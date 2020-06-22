provider "aws" {
  assume_role {
    role_arn     = "${var.role_arn}"
    session_name = "Jenkins_Terraform"
  }
  region  = "${var.aws_region}"
}
