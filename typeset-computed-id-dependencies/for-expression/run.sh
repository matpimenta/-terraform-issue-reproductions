#!/usr/bin/env bash
set -e

rm -rf .terraform terraform.tfstate* module/.terraform module/terraform.tfstate main.tf
cd module
cp ../main-step1.tf main.tf
terraform init
terraform apply -auto-approve
cp ../main-step2.tf main.tf
terraform apply -auto-approve
