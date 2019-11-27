$start = get-date   

terraform init
# terraform destroy -auto-approve
terraform apply "terraform.tfplan"
terraform output > outputs.txt
terraform output -json > outputs.json
$end = Get-Date
$delay = New-TimeSpan $start $end
Write-Host "Provisioning took" $delay.TotalMinutes "minutes"