# Enter existing account username
$UsernameDelete = ""

# Enter new account username
$UsernameNew = ""
$PasswordNew = ""

# Enter new admin account username and password
$UsernameAdmin = ""
$PasswordAdmin = ""

# Windows Admin Group
$GroupAdmin = "Administrators"

# ----------- #
# Delete user #
# ----------- #

$adsiDelete = [ADSI]"WinNT://$env:COMPUTERNAME"
$existingDelete = $adsiDelete.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameDelete }

# Check if the user exists
if ($null -ne $existingDelete) {

    # Delete old user
    Write-Host "-----> Deleting user "$UsernameDelete"..." -ForegroundColor Yellow
    & NET USER $UsernameDelete /delete | Out-Null
    Write-Host "-----> User "$UsernameDelete" deleted successfully!" -ForegroundColor Green

# If user does not exist
} else {
    Write-Host "-----> User "$UsernameDelete" does not exist!" -ForegroundColor Red
}

# --------------- #
# Create new user #
# --------------- #

$adsiNew = [ADSI]"WinNT://$env:COMPUTERNAME"
$existingNew = $adsiNew.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameNew }

# Check if the user exists
if ($null -eq $existingNew) {

    # Create new user
    Write-Host "-----> Creating user "$UsernameNew"..." -ForegroundColor Yellow
    & NET USER $UsernameNew $PasswordNew /add /y /expires:never | Out-Null
    Write-Host "-----> User "$UsernameNew" created successfully!" -ForegroundColor Green

    # Add admin user to Administrators
    Write-Host "-----> Adding user "$UsernameNew" to "$GroupAdmin" group..." -ForegroundColor Yellow
    & NET LOCALGROUP $GroupAdmin $UsernameNew /add | Out-Null
    Write-Host "-----> User "$UsernameNew" added to "$GroupAdmin" group!" -ForegroundColor Green
} else {

    # Set password if user already exists
    Write-Host "-----> Setting password for existing user "$UsernameNew"..." -ForegroundColor Yellow
    $existingNew.SetPassword($PasswordNew)
    Write-Host "-----> Password for existing user "$UsernameNew" has been set successfully!" -ForegroundColor Green
    
}

# Set user password to never expire
Write-Host "-----> Ensuring password for "$UsernameNew" never expires..." -ForegroundColor Yellow
& WMIC USERACCOUNT WHERE "Name='$UsernameNew'" SET PasswordExpires=FALSE | Out-Null
Write-Host "-----> Password for "$UsernameNew" has beed set to never expire!" -ForegroundColor Green

# ----------------- #
# Create admin user #
# ----------------- #

$adsiAdmin = [ADSI]"WinNT://$env:COMPUTERNAME"
$existingAdmin = $adsiAdmin.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameAdmin }

# Check if the user exists
if ($null -eq $existingAdmin) {

    # Create admin user
    Write-Host "-----> Creating user "$UsernameAdmin"..." -ForegroundColor Yellow
    & NET USER $UsernameAdmin $PasswordAdmin /add /y /expires:never | Out-Null
    Write-Host "-----> User "$UsernameAdmin" created successfully!" -ForegroundColor Green
    
    # Add admin user to Administrators
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