# Enter existing account username
$UsernameDelete = ""

$adsiDelete = [ADSI]"WinNT://$env:COMPUTERNAME"
$existingDelete = $adsiDelete.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameDelete }

# Check if the user exists
if ($null -ne $existingDelete) {
    # If user exists
    # delete old user
    Write-Host "-----> Deleting user "$UsernameDelete"..." -ForegroundColor Yellow
    & NET USER $UsernameDelete /delete | Out-Null
    Write-Host "-----> User "$UsernameDelete" deleted successfully!" -ForegroundColor Green

# If user does not exist
} else {
    Write-Host "-----> User "$UsernameDelete" does not exist!" -ForegroundColor Red
}