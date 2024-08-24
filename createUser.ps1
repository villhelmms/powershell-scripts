# Enter new account username and password
$UsernameNew = ""
$PasswordNew = ""

$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
$existing = $adsi.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameNew }

# Check if the user exists
if ($null -eq $existing) {
    # If user does not exist
    # create new user
    Write-Host "-----> Creating user "$UsernameNew"..." -ForegroundColor Yellow
    & NET USER $UsernameNew $PasswordNew /add /y /expires:never | Out-Null
    Write-Host "-----> User "$UsernameNew" created successfully!" -ForegroundColor Green
} else {
    # Set password if user already exists
    Write-Host "-----> Setting password for existing user "$UsernameNew"..." -ForegroundColor Yellow
    $existing.SetPassword($PasswordNew)
    Write-Host "-----> Password for existing user "$UsernameNew" has been set successfully!" -ForegroundColor Green
}
# Set user password to never expire
Write-Host "-----> Ensuring password for "$UsernameNew" never expires..." -ForegroundColor Yellow
& WMIC USERACCOUNT WHERE "Name='$UsernameNew'" SET PasswordExpires=FALSE | Out-Null
Write-Host "-----> Password for "$UsernameNew" has beed set to never expire!" -ForegroundColor Green