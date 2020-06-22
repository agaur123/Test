output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr_block" {
  value = "${module.vpc.vpc_cidr_block}"
}

output "private_subnets_ids" {
  value = ["${module.vpc.private_subnets_ids}"]
}

output "protected_subnets_ids" {
  value = ["${module.vpc.protected_subnets_ids}"]
}

output "public_subnets_ids" {
  value = ["${module.vpc.public_subnets_ids}"]
}

output "private_route_table_ids" {
  value = ["${module.vpc.private_route_table_ids}"]
}

output "protected_route_table_ids" {
  value = ["${module.vpc.protected_route_table_ids}"]
}

output "public_route_table_ids" {
  value = ["${module.vpc.public_route_table_ids}"]
}

output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "private_nat_eip_ids" {
  value = ["${module.vpc.private_nat_eip_ids}"]
}

output "private_nat_gw_ids" {
  value = ["${module.vpc.private_nat_gw_ids}"]
}

output "igw_id" {
  value = "${module.vpc.igw_id}"
}

output "zone_id" {
  value = "${module.vpc.zone_id}"
}

output "private_nat_gw_routes" {
  value = ["${module.vpc.private_nat_gw_routes}"]
}
