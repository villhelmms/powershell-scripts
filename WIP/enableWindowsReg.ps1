# Delete Disabled Desktop Wallpaper Customization registry keys
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" -Name "NoAddingComponents" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" -Name "NoChangingWallPaper" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" -Name "NoComponents" -ErrorAction SilentlyContinue

# Delete Disabled Lock Screen Customization registry keys
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoChangingLockScreen" -ErrorAction SilentlyContinue

# Delete Disabled Windows Color Customization registry keys
Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "ColorPrevalence" -ErrorAction SilentlyContinue

# Delete Disabled Theme Customization registry keys
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoThemesTab" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoThemesTab" -ErrorAction SilentlyContinue

# Delete Disabled Color Customization registry keys
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "NoDispAppearancePage" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "NoDispAppearancePage" -ErrorAction SilentlyContinue