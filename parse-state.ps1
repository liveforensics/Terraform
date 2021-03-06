Set-Location E:\code\github\terraform\Azure\liveforensics
$raw = get-content -raw -path terraform.tfstate 
$json = convertfrom-json $raw
foreach($item in $json.resources)
{
    # Write-Host $item.module
    if($item.module -eq "module.windows-client" -and $item.type -eq "azurerm_public_ip")
    {
        Write-Host $item.instances[0].attributes.fqdn
    }
}