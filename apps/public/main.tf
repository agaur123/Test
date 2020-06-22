module "asg" {
  source = "You ASG module github repo url"

  name                      = "${var.name}-${var.environment}-${var.version}"
  vpc_zone_identifier       = "${var.private_subnet_ids}"
  max_size                  = "${length(var.private_subnet_ids)}"
  min_size                  = "${var.asg_min_size}"
  desired_capacity          = "${var.asg_desired_capacity}"
  load_balancers            = ["${module.elb.elb_id}"]
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"
  min_elb_capacity          = "${var.asg_min_elb_capacity}"
  wait_for_elb_capacity     = "${var.asg_desired_capacity}"
  target_group_arns         = "${var.asg_target_group_arns}"
  default_cooldown          = "${var.asg_default_cooldown}"
  force_delete              = "${var.asg_force_delete}"
  termination_policies      = "${var.asg_termination_policies}"
  suspended_processes       = "${var.asg_suspended_processes}"
  placement_group           = "${var.asg_placement_group}"
  enabled_metrics           = "${var.asg_enabled_metrics}"
  metrics_granularity       = "${var.asg_metrics_granularity}"
  wait_for_capacity_timeout = "${var.asg_wait_for_capacity_timeout}"
  protect_from_scale_in     = "${var.asg_protect_from_scale_in}"
  asg_sg                    =  "${aws_security_group.sg_asg.id}"
  tags  = [
    {
      key = "Environment"
      value = "${var.environment}"
      propagate_at_launch = true
      
    },
    {
      key = "Application"
      value = "${var.name}"
      propagate_at_launch = true
    },
    {
      key = "Version"
      value = "${var.version}"
      propagate_at_launch = true
    }
  ]
  vpc_id                      = "${var.vpc_id}"
  asg_image_id                = "${var.asg_image_id}"
  instance_type               = "${var.asg_instance_type}"
  iam_instance_profile        = "${var.asg_iam_instance_profile}"
  key_name                    = "${var.asg_key_name}"
  associate_public_ip_address = "${var.asg_associate_public_ip_address}"
  enable_monitoring           = "${var.asg_enable_monitoring}"
  placement_tenancy           = "${var.asg_placement_tenancy}"
  ebs_optimized               = "${var.asg_ebs_optimized}"
  ebs_block_device            = "${var.asg_ebs_block_device}"
  ephemeral_block_device      = "${var.asg_ephemeral_block_device}"
  root_block_device           = "${var.asg_root_block_device}"
}

resource "aws_security_group" "sg_asg" {
  name_prefix = "${var.name}-sg-"
  description = "${var.name} security group"
  vpc_id      = "${var.vpc_id}"
  tags {
    Environment = "${var.environment}"
    CreatedBy   = "${var.name}-${var.environment}-${var.aws_region}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "egress_asg" {
  security_group_id = "${aws_security_group.sg_asg.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"/
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_asg" {
  count                    = "${length(var.asg_ingress_rules)}"
  security_group_id        = "${aws_security_group.sg_asg.id}"
  type                     = "ingress"
  from_port                = "${lookup(var.asg_ingress_rules[count.index], "from_port")}"
  to_port                  = "${lookup(var.asg_ingress_rules[count.index], "to_port")}"
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.sg_elb.id}"
}

module "elb" {
  source = "your elb module link here"
  name        = "${var.name}"
  internal    = false
  vpc_id      = "${var.vpc_id}"
  subnets     = "${var.public_subnet_ids}"
  zone_id     = "${var.zone_id}"
  record_name = "${var.name}-fis"
  elb_sg      = "${aws_security_group.sg_elb.id}"
  health_check = "${var.elb_health_check}"
  listener    = "${var.elb_listeners}"
  tags {
    Environment = "${var.environment}"
    CreatedBy   = "${var.name}-${var.aws_region}"
  }
}

resource "aws_security_group" "sg_elb" {
  description = "${var.name} elb security group"
  vpc_id      = "${var.vpc_id}"
  name_prefix = "${var.name}-elb-sg-"
  tags {
    Environment = "${var.environment}"
    CreatedBy   = "${var.name}-${var.aws_region}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "egress_elb" {
  security_group_id = "${aws_security_group.sg_elb.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_elb" {
  count             = "${length(var.elb_ingress_rules)}"
  security_group_id = "${aws_security_group.sg_elb.id}"
  type              = "ingress"
  from_port         = "${lookup(var.elb_ingress_rules[count.index], "from_port")}"
  to_port           = "${lookup(var.elb_ingress_rules[count.index], "to_port")}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
