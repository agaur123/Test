### All these should be passed in via Jenkins
# name                      =            # Combined from the App Name and Envrionment.
# aws_region                =            # Comes from the region Jenkins is deployed in.
# role_arn                  =            # Based on the branch/environment used.
# vpc_id                    =            # Is populated from the deploy-infra job.
# zone_id                   =            # Is populated from the deploy-infra job.
# private_subnet_ids        =            # Is populated from the deploy-infra job.
# public_subnet_ids         =            # Is populated from the deploy-infra job.
# environment               =            # Is based on the branch.
# asg_image_id              =            # Is populated from the bake-ami job.
# asg_ingress_rules         =            # is generated based on the elb_listeners the App specifies
# elb_ingress_rules         =            # is generated based on the elb_listeners the App specifies

### Infra variables are based on the tier and environment

asg_desired_capacity        = 1          # The number of Amazon EC2 instances that should be running.
asg_health_check_type       = "ELB"      # Controls how health checking is done. Values are - EC2 and ELB.
# asg_max_size              =            # Note: This is set to the number of subnets.
asg_min_size                = 1          # The minimum size of the auto scale group.
asg_key_name                = "mykey"    # The key name that should be used for the instance.
asg_instance_type           = "t2.micro" # The size of instance to launch.
# asg_wait_for_elb_capacity =            # Note: This is set to the asg_desired_capacity variable.
# elb_record_name           =            # This is set using the App Name and the Environment
