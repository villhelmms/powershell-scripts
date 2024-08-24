# Disable Desktop Wallpaper Customization
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" -Name "NoAddingComponents" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" -Name "NoChangingWallPaper" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" -Name "NoComponents" -Value 1 -PropertyType DWord -Force

# Disable Lock Screen Customization
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoChangingLockScreen" -Value 1 -PropertyType DWord -Force

# Disable Windows Color Customization
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "ColorPrevalence" -Value 0 -PropertyType DWord -Force

# Disable Theme Customization
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoThemesTab" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoThemesTab" -Value 1 -PropertyType DWord -Force

# Disable Color Customization
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "NoDispAppearancePage" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "NoDispAppearancePage" -Value 1 -PropertyType DWord -Force