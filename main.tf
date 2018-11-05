module "cluster" {
  source = "modules/cluster"
}

module "handler" {
  source = "modules/handler"
}

module "trigger" {
  source = "modules/trigger"

  cluster_arn = "${module.cluster.arn}"
  subnet_id   = "${module.cluster.subnet_id}"
}

# ---

# NOTE: count is not supported in modules thus it requires for all task
# definitions to be instantiated manually. This will be made configurable as
# soon as support for count is introduced in later version of terraform. 

module "task_cohesion" {
  source = "modules/task"

  name  = "opendevsecops_scanner_cohesion"
  image = "opendevsecops/cohesion:latest"
}

module "task_wpscan" {
  source = "modules/task"

  name  = "opendevsecops_scanner_wpscan"
  image = "opendevsecops/wpscan:latest"
}

module "task_nmap" {
  source = "modules/task"

  name  = "opendevsecops_scanner_nmap"
  image = "opendevsecops/nmap:latest"
}

module "task_masscan" {
  source = "modules/task"

  name  = "opendevsecops_scanner_masscan"
  image = "opendevsecops/masscan:latest"
}
