Write-Host "-----> Google Chrome: Testing path..." -ForegroundColor Yellow
# Chrome policies
$chromePath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
if (!(Test-Path $chromePath)) {
    Write-Host "-----> Google Chrome: New path created" -ForegroundColor Green
    New-Item -Path $chromePath -Force
} else {
    Write-Host "-----> Google Chrome: path already exists" -ForegroundColor Green
}

$chromeProperties = @{
    #"BrowserGuestModeEnforced" = $null
    "NTPCustomBackgroundEnabled" = $null
    "BrowserThemeColor" = $null
    "BrowserSignin" = $null
    "PasswordManagerEnabled" = $null
    "PasswordSharingEnabled" = $null
    "BrowserAddPersonEnabled" = $null
    "SyncDisabled" = $null
    "DefaultBrowserSettingEnabled" = $null
    "PaymentMethodQueryEnabled" = $null
    "AutofillAddressEnabled" = $null
    "ForceGoogleSafeSearch" = $null
    "PrintingEnabled" = $null
    "AutofillCreditCardEnabled" = $null
}

if ($State -eq "Enable") {
    $chromeValues = @{
        #"BrowserGuestModeEnforced" = 1
        "NTPCustomBackgroundEnabled" = 0
        "BrowserThemeColor" = "#060606"
        "BrowserSignin" = 0
        "PasswordManagerEnabled" = 0
        "PasswordSharingEnabled" = 0
        "BrowserAddPersonEnabled" = 0
        "SyncDisabled" = 1
        "DefaultBrowserSettingEnabled" = 0
        "PaymentMethodQueryEnabled" = 0
        "AutofillAddressEnabled" = 0
        "ForceGoogleSafeSearch" = 1
        "PrintingEnabled" = 0
        "AutofillCreditCardEnabled" = 0
    }
} elseif ($State -eq "Disable") {
    $chromeValues = @{
        #"BrowserGuestModeEnforced" = $null
        "NTPCustomBackgroundEnabled" = $null
        "BrowserThemeColor" = $null
        "BrowserSignin" = $null
        "PasswordManagerEnabled" = $null
        "PasswordSharingEnabled" = $null
        "BrowserAddPersonEnabled" = $null
        "SyncDisabled" = $null
        "DefaultBrowserSettingEnabled" = $null
        "PaymentMethodQueryEnabled" = $null
        "AutofillAddressEnabled" = $null
        "ForceGoogleSafeSearch" = $null
        "PrintingEnabled" = $null
        "AutofillCreditCardEnabled" = $null
    }
}

Write-Host "-----> Google Chrome: setting properties..." -ForegroundColor Yellow
foreach ($property in $chromeProperties.GetEnumerator()) {
    if ($chromeValues.ContainsKey($property.Name)) {
        $value = $chromeValues[$property.Name]
        if ($null -eq $value) {
            Remove-ItemProperty -Path $chromePath -Name $property.Name -ErrorAction SilentlyContinue
        } else {
            New-ItemProperty -Path $chromePath -Name $property.Name -Value $value -PropertyType $(if ($value -is [string]) { "String" } else { "Dword" }) -Force | Out-Null
        }
    }
}
if ($null -eq $value) {
    Write-Host "-----> Google Chrome: properties deleted" -ForegroundColor Green
} else {
    Write-Host "-----> Google Chrome: properties created" -ForegroundColor Green
}

# Microsoft Edge policiess
$edgePaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
    "HKLM:\SOFTWARE\Policies\Microsoft\EdgeUpdate"
)
Write-Host "-----> Edge: Testing path..." -ForegroundColor Yellow

foreach ($pathEdge in $edgePaths) {
    if (-not (Test-Path $pathEdge)) {
        New-Item -Path $pathEdge -Force
        Write-Host "-----> Edge: New path created" -ForegroundColor Green
    }
}

$edgeProperties = @{
    "NewTabPageContentEnabled" = $null
    "NewTabPageQuickLinksEnabled" = $null
    "SpotlightExperiencesAndRecommendationsEnabled" = $null
    "NewTabPageAllowedBackgroundTypes" = $null
    "ShowCastIconInToolbar" = $null
    "EnableMediaRouter" = $null
    "GamerModeEnabled" = $null
    "PasswordManagerEnabled" = $null
    "AutofillAddressEnabled" = $null
    "BrowserSignin" = $null
    "CryptoWalletEnabled" = $null
    "EdgeCollectionsEnabled" = $null
    "EdgeEDropEnabled" = $null
    "EdgeFollowEnabled" = $null
    "EdgeShoppingAssistantEnabled" = $null
    "EdgeWalletCheckoutEnabled" = $null
    "EdgeWalletEtreeEnabled" = $null
    "HubsSidebarEnabled" = $null
    "ShowMicrosoftRewards" = $null
    "SyncDisabled" = $null
    "NewTabPageBingChatEnabled" = $null
    "WalletDonationEnabled" = $null
    "BrowserAddProfileEnabled" = $null
    "EdgeDefaultProfileEnabled" = $null
    "MSAWebSiteSSOUsingThisProfileAllowed" = $null
    "AIGenThemesEnabled" = $null
    "PinBrowserEssentialsToolbarButton" = $null
    "SplitScreenEnabled" = $null
    "AutofillCreditCardEnabled" = $null
    "ImportPaymentInfo" = $null
    "PrintingEnabled" = $null
    "HideFirstRunExperience" = $null
    "DefaultBrowserSettingEnabled" = $null
    "CreateDesktopShortcutDefault" = $null
    "PersonalizationReportingEnabled" = $null
    "ShowRecommendationsEnabled" = $null
    "ConfigureDoNotTrack" = $null
    "DiagnosticData" = $null
    "EdgeAssetDeliveryServiceEnabled" = $null
}

if ($State -eq "Enable") {
    $edgeValues = @{
        "NewTabPageContentEnabled" = 0
        "NewTabPageQuickLinksEnabled" = 0
        "SpotlightExperiencesAndRecommendationsEnabled" = 0
        "NewTabPageAllowedBackgroundTypes" = 3
        "ShowCastIconInToolbar" = 0
        "EnableMediaRouter" = 0
        "GamerModeEnabled" = 0
        "PasswordManagerEnabled" = 0
        "AutofillAddressEnabled" = 0
        "BrowserSignin" = 0
        "CryptoWalletEnabled" = 0
        "EdgeCollectionsEnabled" = 0
        "EdgeEDropEnabled" = 0
        "EdgeFollowEnabled" = 0
        "EdgeShoppingAssistantEnabled" = 0
        "EdgeWalletCheckoutEnabled" = 0
        "EdgeWalletEtreeEnabled" = 0
        "HubsSidebarEnabled" = 0
        "ShowMicrosoftRewards" = 0
        "SyncDisabled" = 1
        "NewTabPageBingChatEnabled" = 0
        "WalletDonationEnabled" = 0
        "BrowserAddProfileEnabled" = 0
        "EdgeDefaultProfileEnabled" = "Skolens"
        "MSAWebSiteSSOUsingThisProfileAllowed" = 0
        "AIGenThemesEnabled" = 0
        "PinBrowserEssentialsToolbarButton" = 0
        "SplitScreenEnabled" = 0
        "AutofillCreditCardEnabled" = 0
        "ImportPaymentInfo" = 0
        "PrintingEnabled" = 0
        "HideFirstRunExperience" = 1
        "DefaultBrowserSettingEnabled" = 0
        "CreateDesktopShortcutDefault" = 0
        "PersonalizationReportingEnabled" = 0
        "ShowRecommendationsEnabled" = 0
        "ConfigureDoNotTrack" = 1
        "DiagnosticData" = 0
        "EdgeAssetDeliveryServiceEnabled" = 0
    }
} elseif ($State -eq "Disable") {
    $edgeValues = @{
        "NewTabPageContentEnabled" = $null
        "NewTabPageQuickLinksEnabled" = $null
        "SpotlightExperiencesAndRecommendationsEnabled" = $null
        "NewTabPageAllowedBackgroundTypes" = $null
        "ShowCastIconInToolbar" = $null
        "EnableMediaRouter" = $null
        "GamerModeEnabled" = $null
        "PasswordManagerEnabled" = $null
        "AutofillAddressEnabled" = $null
        "BrowserSignin" = $null
        "CryptoWalletEnabled" = $null
        "EdgeCollectionsEnabled" = $null
        "EdgeEDropEnabled" = $null
        "EdgeFollowEnabled" = $null
        "EdgeShoppingAssistantEnabled" = $null
        "EdgeWalletCheckoutEnabled" = $null
        "EdgeWalletEtreeEnabled" = $null
        "HubsSidebarEnabled" = $null
        "ShowMicrosoftRewards" = $null
        "SyncDisabled" = $null
        "NewTabPageBingChatEnabled" = $null
        "WalletDonationEnabled" = $null
        "BrowserAddProfileEnabled" = $null
        "EdgeDefaultProfileEnabled" = $null
        "MSAWebSiteSSOUsingThisProfileAllowed" = $null
        "AIGenThemesEnabled" = $null
        "PinBrowserEssentialsToolbarButton" = $null
        "SplitScreenEnabled" = $null
        "AutofillCreditCardEnabled" = $null
        "ImportPaymentInfo" = $null
        "PrintingEnabled" = $null
        "HideFirstRunExperience" = $null
        "DefaultBrowserSettingEnabled" = $null
        "CreateDesktopShortcutDefault" = $null
        "PersonalizationReportingEnabled" = $null
        "ShowRecommendationsEnabled" = $null
        "ConfigureDoNotTrack" = $null
        "DiagnosticData" = $null
        "EdgeAssetDeliveryServiceEnabled" = $null
    }
}
Write-Host "-----> Edge: setting properties..." -ForegroundColor Yellow
foreach ($edgePath in $edgePaths) {
    foreach ($property in $edgeProperties.GetEnumerator()) {
        if ($edgeValues.ContainsKey($property.Name)) {
            $value = $edgeValues[$property.Name]
            if ($null -eq $value) {
                Remove-ItemProperty -Path $edgePath -Name $property.Name -ErrorAction SilentlyContinue
            } else {
                New-ItemProperty -Path $edgePath -Name $property.Name -Value $value -PropertyType $(if ($value -is [string]) { "String" } else { "Dword" }) -Force | Out-Null
            }
        }
    }
}
if ($null -eq $value) {
    Write-Host "-----> Edge: properties deleted" -ForegroundColor Green
} else {
    Write-Host "-----> Edge Chrome: properties created" -ForegroundColor Green
}

<# #------------------------#
# Google Chrome Settings #
#------------------------#

# Define the registry key path
$chromePath = "HKLM:\SOFTWARE\Policies\Google\Chrome"

# Define the properties to be deleted
$properties = @(
    "BrowserGuestModeEnforced",
    "NTPCustomBackgroundEnabled",
    "BrowserThemeColor",
    "BrowserSignin",
    "PasswordManagerEnabled",
    "PasswordSharingEnabled",
    "BrowserAddPersonEnabled",
    "SyncDisabled",
    "DefaultBrowserSettingEnabled",
    "PaymentMethodQueryEnabled",
    "AutofillAddressEnabled",
    "ForceGoogleSafeSearch",
    "PrintingEnabled",
    "AutofillCreditCardEnabled"
)

# Delete the properties
foreach ($property in $properties) {
    Remove-ItemProperty -Path $chromePath -Name $property -ErrorAction SilentlyContinue
}

#-------------------------#
# Google Chrome Blocklist #
#-------------------------#

# Define the registry key path
$blocklistPath = "HKLM:\SOFTWARE\Policies\Google\Chrome\URLBlocklist"

# Check if the path exists in the 64-bit view of the registry
if (Test-Path -Path $blocklistPath) {
    # Remove each entry in the blocklist
    $entries = Get-ChildItem -Path $blocklistPath

    foreach ($entry in $entries) {
        Remove-ItemProperty -Path $entry.PSPath -Name $entry.Name -Force
    }

    # Remove the URLBlocklist key if it is empty
    if ((Get-ChildItem -Path $blocklistPath).Count -eq 0) {
        Remove-Item -Path $blocklistPath -Force -Recurse
    }
} else {
    # Check if the path exists in the 32-bit view of the registry
    $blocklistPath32 = "HKLM:\SOFTWARE\Wow6432Node\Policies\Google\Chrome\URLBlocklist"

    if (Test-Path -Path $blocklistPath32) {
        # Remove each entry in the blocklist
        $entries = Get-ChildItem -Path $blocklistPath32 -RegistryKey $blocklistPath32

        foreach ($entry in $entries) {
            Remove-ItemProperty -Path $entry.PSPath -Name $entry.Name -Force
        }

        # Remove the URLBlocklist key if it is empty
        if ((Get-ChildItem -Path $blocklistPath32 -RegistryKey $blocklistPath32).Count -eq 0) {
            Remove-Item -Path $blocklistPath32 -Force -Recurse
        }
    } else {
        Write-Host "Registry path $blocklistPath or $blocklistPath32 not found."
    }
} 

#-------------------------#
# Google Chrome Blocklist #
#-------------------------#

# Google Chrome Blocklist Path
$blocklistPath = "HKLM:\SOFTWARE\Policies\Google\Chrome\URLBlocklist"
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

#---------------#
# Edge Settings #
#---------------#

# Paths
$edgePaths = @("HKLM:\SOFTWARE\Policies\Microsoft\Edge", "HKLM:\SOFTWARE\Policies\Microsoft\Edge\Recommended")

# Create the registry keys if they don't exist
foreach ($path in $edgePaths) {
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force
    }
}


# Define the properties to be set
$properties = @{
    "NewTabPageContentEnabled" = 0
    "NewTabPageQuickLinksEnabled" = 0
    "SpotlightExperiencesAndRecommendationsEnabled" = 0
    "NewTabPageAllowedBackgroundTypes" = 3
    "ShowCastIconInToolbar" = 0
    "EnableMediaRouter" = 0
    "GamerModeEnabled" = 0
    "PasswordManagerEnabled" = 0
    "AutofillAddressEnabled" = 0
    "BrowserSignin" = 0
    "CryptoWalletEnabled" = 0
    "EdgeCollectionsEnabled" = 0
    "EdgeEDropEnabled" = 0
    "EdgeFollowEnabled" = 0
    "EdgeShoppingAssistantEnabled" = 0
    "EdgeWalletCheckoutEnabled" = 0
    "EdgeWalletEtreeEnabled" = 0
    "HubsSidebarEnabled" = 0
    "ShowMicrosoftRewards" = 0
    "SyncDisabled" = 1
    "NewTabPageBingChatEnabled" = 0
    "WalletDonationEnabled" = 0
    "BrowserAddProfileEnabled" = 0
    "EdgeDefaultProfileEnabled" = "Skolens"
    "MSAWebSiteSSOUsingThisProfileAllowed" = 0
    "AIGenThemesEnabled" = 0
    "PinBrowserEssentialsToolbarButton" = 0
    "SplitScreenEnabled" = 0
    "AutofillCreditCardEnabled" = 0
    "ImportPaymentInfo" = 0
    "PrintingEnabled" = 0
    "HideFirstRunExperience" = 0
    "DefaultBrowserSettingEnabled" = 0
}

# Set the properties using a single loop for both paths
foreach ($path in $edgePaths) {
    foreach ($property in $properties.GetEnumerator()) {
        $propertyType = if ($property.Value -is [string]) { "String" } else { "Dword" }
        New-ItemProperty -Path $path -Name $property.Name -Value $property.Value -PropertyType $propertyType -Force
    }
}

#----------------#
# Edge Blocklist #
#----------------#

# Edge Blocklist Path
$blocklistPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist"
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

#>