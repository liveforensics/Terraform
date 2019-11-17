$start = get-date   
terraform destroy --var-file="..\Common\terraform.tfvars" -auto-approve
Remove-Item -Force terraform.tfplan
Remove-Item -Force terraform.tfstate
Remove-Item -Force terraform.tfstate.backup
$end = Get-Date
$delay = New-TimeSpan $start $end
Write-Host "Teardwon took" $delay.TotalMinutes "minutes"