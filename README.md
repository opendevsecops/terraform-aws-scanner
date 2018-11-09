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

* Cohesion - Dynamic Web Application Security Scanner
* WPScan - Wordpress Security Scanner
* Nmap - Network Security Scanner
* GitLeaks - Git Security Scanner
* Amass - Domain Enumeration

### Cohesion

Image: https://github.com/opendevsecops/docker-cohesion
URL: https://secapps.com/cohesion

```
module "scanner_cohesion" {
  source = "opendevsecops/scanner/aws//modules/cohesion"

  schedule = "rate(24 hours)"

  target = "http://target"

  trigger_arn = "${module.scanner.trigger_arn}"
}
```

### WPScan

Image: https://github.com/opendevsecops/docker-wpscan
URL: https://wpscan.org

```
module "scanner_wpscan" {
  source = "opendevsecops/scanner/aws//modules/wpscan"

  schedule = "rate(24 hours)"

  target = "http://target"

  trigger_arn = "${module.scanner.trigger_arn}"
}
```

### Nmap

Image: https://github.com/opendevsecops/docker-nmap
URL: https://nmap.org

```
module "scanner_nmap" {
  source = "opendevsecops/scanner/aws//modules/nmap"

  schedule = "rate(24 hours)"

  target = "10.10.10.0/24"
  flags = ["-sS"]

  trigger_arn = "${module.scanner.trigger_arn}"
}
```

### GitLeaks

Image: https://github.com/opendevsecops/docker-gitleaks
URL: https://github.com/zricethezav/gitleaks

```
module "scanner_gitleaks" {
  source = "opendevsecops/scanner/aws//modules/gitleaks"

  schedule = "rate(24 hours)"

  target = "https://github.com/target/target.git"

  trigger_arn = "${module.scanner.trigger_arn}"
}
```

### Amass

Image: https://github.com/opendevsecops/docker-amass
URL: https://github.com/caffix/amass

```
module "scanner_amass" {
  source = "opendevsecops/scanner/aws//modules/amass"

  schedule = "rate(24 hours)"

  target = "target"

  trigger_arn = "${module.scanner.trigger_arn}"
}
```
