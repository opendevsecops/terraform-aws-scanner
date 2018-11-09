[![Codacy Badge](https://api.codacy.com/project/badge/Grade/5815b10c6daf46b0a3e6606ce812898e)](https://www.codacy.com/app/OpenDevSecOps/terraform-aws-scanner?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=opendevsecops/terraform-aws-scanner&amp;utm_campaign=Badge_Grade)
[![Follow on Twitter](https://img.shields.io/twitter/follow/opendevsecops.svg?logo=twitter)](https://twitter.com/opendevsecops)

# AWS Scanner Terraform Module

Terraform module which provides easy to configure an environment for running automated security scanning solutions.

## Introduction 

This module provides an end-to-end solution for orchestrating automated vulnerability scanning tools. You can configure, designate, schedule regular scans and process the result with ease.

## Getting Started

Getting started is easy. All resources such as ECS cluster, VPCs, and task definitions are provisioned out of the box. Here is a complete example:

```terraform
module "scanner" {
  source = "opendevsecops/scanner/aws"
}

module "scanner_cohesion" {
  source = "opendevsecops/scanner/aws//modules/cohesion"

  schedule = "rate(24 hours)"
  target = "http://target"

  trigger_arn = "${module.scanner.trigger_arn}"
}
```

This module is automatically published to the Terraform Module Registry. More information about the available inputs, outputs, dependencies, and instructions on how to use the module can be found at the official page [here](https://registry.terraform.io/modules/opendevsecops/scanner).

## Supported Scanner

The following scanners are currently supported:

* [Cohesion](https://secapps.com/cohesion)
* [WPScan](https://wpscan.org/)
* [Nmap](https://nmap.org/)

### Cohesion

```
module "scanner_cohesion" {
  source = "opendevsecops/scanner/aws//modules/cohesion"

  schedule = "rate(24 hours)"
  target = "http://target"

  trigger_arn = "${module.scanner.trigger_arn}"
}
```

### WPScan

```
module "scanner_wpscan" {
  source = "opendevsecops/scanner/aws//modules/wpscan"

  schedule = "rate(24 hours)"
  target = "http://target"

  trigger_arn = "${module.scanner.trigger_arn}"
}
```

### Nmap

```
module "scanner_cohesion" {
  source = "opendevsecops/scanner/aws//modules/cohesion"

  schedule = "rate(24 hours)"
  target = "10.10.10.0/24"
  flags = ["-sS"]

  trigger_arn = "${module.scanner.trigger_arn}"
}
```