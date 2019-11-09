get-location
push-location
get-childitem -recurse . | Where { $_.PsIsContainer -eq $true } | foreach-object {
    write-host $_.FullName
    set-location $_.FullName
    terraform fmt
}
pop-location