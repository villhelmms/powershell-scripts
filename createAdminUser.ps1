# Enter new admin account username and password
$UsernameAdmin = ""
$PasswordAdmin = ""

$GroupAdmin = "Administrators"
$adsiAdmin = [ADSI]"WinNT://$env:COMPUTERNAME"
$existingAdmin = $adsiAdmin.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameAdmin }

# Check if the user exists
if ($null -eq $existingAdmin) {
    # If user does not exist
    # create new user
    Write-Host "-----> Creating user "$UsernameAdmin"..." -ForegroundColor Yellow
    & NET USER $UsernameAdmin $PasswordAdmin /add /y /expires:never | Out-Null
    Write-Host "-----> User "$UsernameAdmin" created successfully!" -ForegroundColor Green
    
    # Add user to Administrators group
    Write-Host "-----> Adding user "$UsernameAdmin" to "$GroupAdmin" group..." -ForegroundColor Yellow
    & NET LOCALGROUP $GroupAdmin $UsernameAdmin /add | Out-Null
    Write-Host "-----> Admin user "$UsernameAdmin" added to "$GroupAdmin" group!" -ForegroundColor Green
}
else {
    # Set password if user already exists
    Write-Host "-----> Setting password for existing user "$UsernameAdmin"..." -ForegroundColor Yellow
    $existingAdmin.SetPassword($PasswordAdmin)
    Write-Host "-----> Password for existing user "$UsernameAdmin" has been set!" -ForegroundColor Green
}

# Set user password to never expire
Write-Host "-----> Ensuring password for "$UsernameAdmin" never expires..." -ForegroundColor Yellow
& WMIC USERACCOUNT WHERE "Name='$UsernameAdmin'" SET PasswordExpires=FALSE | Out-Null
Write-Host "-----> Password for "$UsernameAdmin" has beed set to never expire!" -ForegroundColor Green