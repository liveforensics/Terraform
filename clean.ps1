terraform destroy --var-file="..\Common\terraform.tfvars" -auto-approve
Remove-Item -Force terraform.tfplan
Remove-Item -Force terraform.tfstate
Remove-Item -Force terraform.tfstate.backup