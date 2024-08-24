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