#---------------------------#
# Mozilla Firefox Blocklist #
#---------------------------#

# Edge Blocklist Path
$blocklistPath = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter"
if (!(Test-Path $blocklistPath)) {
    New-Item -Path $blocklistPath -Force
}

# Define the blocklist
$blocklist = @{
    "1" = "y8.com"
    "2" = "roblox.com"
}

# Set the blocklist properties using a single loop
foreach ($entry in $blocklist.GetEnumerator()) {
    New-ItemProperty -Path $blocklistPath -Name $entry.Name -Value $entry.Value -PropertyType String -Force
}