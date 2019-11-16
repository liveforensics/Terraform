terraform destroy --var-file="../Common/terraform.tfvars" -auto-approve
rm -Rf terraform.tfplan
rm -Rf terraform.tfstate
rm -Rf terraform.tfstate.backup