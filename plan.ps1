# from the exercise folder, run me with ..\..\plan.ps1

push-location
get-childitem -recurse . | Where { $_.PsIsContainer -eq $true } | foreach-object {
    set-location $_.FullName
    terraform fmt
}
pop-location
terraform init
terraform plan --var-file="..\Common\terraform.tfvars" -out terraform.tfplan
