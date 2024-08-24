# Define an array of settings pages to hide
$settingsPagesToHide = @(
    "personalization-background"
    "personalization-colors"
    "themes"
    "personalization-start-places"
    "lockscreen"
    "taskbar"
    "personalization-touchkeyboard"
    "deviceusage"
    "emailandaccounts"
    "workplace"
    "signinoptions"
    "backup"
    "yourinfo"
    "maps"
    "printers"
    "mobile-devices"
    "nightlight"
    "findmydevice"
    "developers"
    "gaming-gamebar"
    "gaming-gamedvr"
    "gaming-gamemode"
    "quietmomentsgame"
    "gaming-trueplay"
)

# Check if the SettingsPageVisibility property already exists
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$propertyName = "SettingsPageVisibility"

if (Get-ItemProperty -Path $registryPath -Name $propertyName -ErrorAction SilentlyContinue) {
    # If the property exists, update its value
    Set-ItemProperty -Path $registryPath -Name $propertyName -Value ("hide:{0}" -f ($settingsPagesToHide -join ";"))
} else {
    # If the property does not exist, create it
    New-ItemProperty -Path $registryPath -Name $propertyName -PropertyType "String" -Value ("hide:{0}" -f ($settingsPagesToHide -join ";"))
}