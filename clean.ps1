$start = get-date   
terraform destroy --var-file="..\Common\terraform.tfvars" -auto-approve
if(Test-Path terraform.tfplan) { Remove-Item -Force terraform.tfplan }
if(Test-Path terraform.tfstate) { Remove-Item -Force terraform.tfstate }
if(Test-Path terraform.tfstate.backup) { Remove-Item -Force terraform.tfstate.backup }

$end = Get-Date
$delay = New-TimeSpan $start $end
Write-Host "Teardwon took" $delay.TotalMinutes "minutes"