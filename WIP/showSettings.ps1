# Define the registry path and property name
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$propertyName = "SettingsPageVisibility"

# Check if the property exists
if (Get-ItemProperty -Path $registryPath -Name $propertyName -ErrorAction SilentlyContinue) {
    # If the property exists, delete it
    Remove-ItemProperty -Path $registryPath -Name $propertyName
    Write-Host "SettingsPageVisibility property has been deleted."
} else {
    Write-Host "SettingsPageVisibility property does not exist."
}