#-------------------------#
# Microsoft Edge Settings #
#-------------------------#

# Define the registry key paths
$edgePaths = @("HKLM:\SOFTWARE\Policies\Microsoft\Edge", "HKLM:\SOFTWARE\Policies\Microsoft\Edge\Recommended")

# Define the properties to be deleted
$properties = @(
    "NewTabPageContentEnabled",
    "NewTabPageQuickLinksEnabled",
    "SpotlightExperiencesAndRecommendationsEnabled",
    "NewTabPageAllowedBackgroundTypes",
    "ShowCastIconInToolbar",
    "EnableMediaRouter",
    "GamerModeEnabled",
    "PasswordManagerEnabled",
    "AutofillAddressEnabled",
    "BrowserSignin",
    "CryptoWalletEnabled",
    "EdgeCollectionsEnabled",
    "EdgeEDropEnabled",
    "EdgeFollowEnabled",
    "EdgeShoppingAssistantEnabled",
    "EdgeWalletCheckoutEnabled",
    "EdgeWalletEtreeEnabled",
    "HubsSidebarEnabled",
    "ShowMicrosoftRewards",
    "SyncDisabled",
    "NewTabPageBingChatEnabled",
    "WalletDonationEnabled",
    "BrowserAddProfileEnabled",
    "EdgeDefaultProfileEnabled",
    "MSAWebSiteSSOUsingThisProfileAllowed",
    "AIGenThemesEnabled",
    "PinBrowserEssentialsToolbarButton",
    "SplitScreenEnabled",
    "AutofillCreditCardEnabled",
    "ImportPaymentInfo",
    "PrintingEnabled",
    "HideFirstRunExperience",
    "DefaultBrowserSettingEnabled"
)

# Delete the properties for each path
foreach ($path in $edgePaths) {
    foreach ($property in $properties) {
        Remove-ItemProperty -Path $path -Name $property -ErrorAction SilentlyContinue
    }
}

#----------------#
# Edge Blocklist #
#----------------#

# Define the registry key path
$blocklistPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist"

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
    $blocklistPath32 = "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Edge\URLBlocklist"

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