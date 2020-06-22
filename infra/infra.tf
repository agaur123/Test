module "vpc" {
  source = "your VPC module internal git url"

  name              = "${var.name}-${var.environment}"
  vpc_cidr          = "${var.vpc_cidr}"
  global_cidr       = "${var.global_cidr}"
  public_subnets    = "${var.public_subnet_ids}"
  private_subnets   = "${var.private_subnet_ids}"
  protected_subnets = "${var.protected_subnet_ids}"
  nat_subnets       = "${var.nat_subnet_ids}"
  enable_transit    = "${var.enable_transit}"
  enable_vpn_gateway  = "${var.enable_vpn_gateway}"
  zone_name         =  "${var.zone_name}"
  tags {
   Environment = "${var.environment}"
   CreatedBy   = "${var.name}-${var.environment}-${var.aws_region}"
   "Jenkins Job Name" = "${var.jenkins_job_name}"
   "Jenkins Build Number" = "${var.jenkins_build_number}"
  }
}
