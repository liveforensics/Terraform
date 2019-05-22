# from the exercise folder, run me with ..\..\plan.ps1

terraform init
terraform plan --var-file="..\Common\terraform.tfvars" -out terraform.tfplan
