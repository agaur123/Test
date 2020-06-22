#### Passed in via Jenkins #####

variable "name" {
  description = "The name prefix for AWS resources"
}

variable "version" {
  description = "The version of the Application."
}

variable "environment" {
  description = "Name of the environment"
}

variable asg_image_id {
  description = "AWS AMI Id"
}

variable "aws_region" {}

variable "role_arn" {
  description = "Arn of the role to assume."
}

variable "vpc_id" {
  description = "VPC id to create ASG and ELB"
}

variable "zone_id" {
  description = "Zone id of AWS account to create hostnames"
}

variable "private_subnet_ids" {
  description = "A list of public subnet IDs to launch aws resources"
  type        = "list"
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs to launch aws resources"
  type        = "list"
}

variable "asg_ingress_rules" {
  description = "A map of sg_asg ingress rules"
  type        = "list"
}

variable "elb_ingress_rules" {
  description = "A map of sg_elb ingress rules"
  type        = "list"
}


#### Infra Parameters #####

variable "asg_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "asg_health_check_type" {
  description = "Controls how health checking is done. Values are - EC2 and ELB"
}

variable "asg_max_size" {
  description = "The maximum size of the auto scale group"
  # Note this is set to the number of subnets for HA purpose.
  default = 0
}

variable "asg_min_size" {
  description = "The minimum size of the auto scale group"
  default     = 1
}

variable "asg_key_name" {
description = "The key name that should be used for the instance"
default     = ""
}

variable "asg_instance_type" {
description = "The size of instance to launch"
}

variable "asg_min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = 0
}

variable "asg_wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  default     = 0
}

variable "elb_record_name" {
  description = "ELB record name to create as Alias with endpoint"
  default     = "default"
}


#### Application Parameters Required #####

variable "elb_listeners" {
  description = "ELB listerners"
  type        = "list"
}

variable "elb_health_check" {
  type = "map"
  description = "Describes the configuration for ELB health checks."
}

#### Application Parameters Optional #####
variable "asg_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 60
}

variable "asg_target_group_arns" {
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  default     = []
}

variable "asg_default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "asg_force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "asg_termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  type        = "list"
  default     = ["Default"]
}

variable "asg_suspended_processes" {
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "asg_placement_group" {
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}

variable "asg_enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = "list"

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "asg_metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  default     = "1Minute"
}

variable "asg_wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  default     = "10m"
}

variable "asg_protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
  default     = false
}

variable "asg_iam_instance_profile" {
  description = "The IAM instance profile to associate with launched instances"
  default     = ""
}

variable "asg_associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  default     = false
}

variable "asg_enable_monitoring" {
  description = "Enables/disables detailed monitoring. This is enabled by default."
  default     = true
}

variable "asg_placement_tenancy" {
  description = "The tenancy of the instance. Valid values are 'default' or 'dedicated'"
  default     = "default"
}

variable "asg_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "asg_ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = "list"
  default     = []
}

variable "asg_ephemeral_block_device" {
  description = "Customize Ephemeral (also known as 'Instance Store') volumes on the instance"
  type        = "list"
  default     = []
}

variable "asg_root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = "list"
  default     = []
}
