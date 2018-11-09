module "cluster" {
  source = "opendevsecops/ecs-cluster/aws"

  name = "opendevsecops_scanner"

  vpc_cidr_block    = "10.52.52.0/24"
  subnet_cidr_block = "10.52.52.0/24"
}

module "trigger" {
  source = "modules/trigger"

  cluster_arn = "${module.cluster.arn}"
  subnet_id   = "${module.cluster.subnet_id}"

  task_role_arn      = "${module.cluster.task_role_arn}"
  execution_role_arn = "${module.cluster.execution_role_arn}"
}

# ---

# NOTE: count is not supported in modules thus it requires for all task
# definitions to be instantiated manually. This will be made configurable as
# soon as support for count is introduced in later version of terraform. 

module "task_cohesion" {
  source = "opendevsecops/ecs-task/aws"

  name  = "opendevsecops_scanner_cohesion"
  image = "opendevsecops/cohesion:latest"
}

module "task_wpscan" {
  source = "opendevsecops/ecs-task/aws"

  name  = "opendevsecops_scanner_wpscan"
  image = "opendevsecops/wpscan:latest"
}

module "task_nmap" {
  source = "opendevsecops/ecs-task/aws"

  name  = "opendevsecops_scanner_nmap"
  image = "opendevsecops/nmap:latest"
}
