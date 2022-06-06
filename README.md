Terraform VPC Showcase
======================

# Overview

This project sets up following AWS resources:
- VPC,
- public and private subnets, 
- route tables, 
- Internet Gateway, 
- NAT gateways (1 per public subnet)
- EIPs (1 per per public subnet).

The repository leverages AWS VPC Terraform module. See https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.0 for more details.

# Usage

## Init

Terraform backend configuration is provided as configuration file. The repository ships with `dev.hcl` and terraform can be initialized using `terraform init -config-file=dev.hcl`.

## Variables

Repository ships with predefined variables file `dev.tfvars` that allow for non-interactive execution of `plan` and `apply` commands.

### Running in CI

Run with `-input=false and -var-file` switches: `terraform plan -input=false -var-file=dev.tfvars`.