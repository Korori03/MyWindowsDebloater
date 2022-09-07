
    $PathToCUXboxGameBar = "HKCU:\Software\Microsoft\GameBar"
    $PathToLMServicesXbgm = "HKLM:\SYSTEM\CurrentControlSet\Services\xbgm"
    $TweakType = "Xbox"

    $XboxServices = @(
        "XblAuthManager"                    # Xbox Live Auth Manager
        "XblGameSave"                       # Xbox Live Game Save
        "XboxGipSvc"                        # Xbox Accessory Management Service
        "XboxNetApiSvc"
    )

    $XboxApps = @(
        "Microsoft.GamingServices"          # Gaming Services
        "Microsoft.XboxApp"                 # Xbox Console Companion (Replaced by new App)
        "Microsoft.XboxGameCallableUI"
        "Microsoft.XboxGameOverlay"
        "Microsoft.XboxSpeechToTextOverlay"
        "Microsoft.XboxGamingOverlay"       # Xbox Game Bar
        "Microsoft.XboxIdentityProvider"    # Xbox Identity Provider (Xbox Dependency)
        "Microsoft.Xbox.TCUI"               # Xbox Live API communication (Xbox Dependency)
    )

    Write-Status -Types "-", $TweakType -Status "Disabling ALL Xbox Services..."
    Set-ServiceStartup -Disabled -Services $XboxServices

    Write-Status -Types "-", $TweakType -Status "Wiping Xbox Apps completely from Windows..."
    Remove-UWPAppx -AppxPackages $XboxApps

    Disable-XboxGameBarDVR

    # Adapted from: https://docs.microsoft.com/en-us/answers/questions/241800/completely-disable-and-remove-xbox-apps-and-relate.html
    Write-Status -Types "-", $TweakType -Status "Disabling Game mode..."
    Set-ItemProperty -Path "$PathToCUXboxGameBar" -Name "AutoGameModeEnabled" -Type DWord -Value 0
    Write-Status -Types "-", $TweakType -Status "Disabling Game Mode Notifications..."
    Set-ItemProperty -Path "$PathToCUXboxGameBar" -Name "ShowGameModeNotifications" -Type DWord -Value 0
    Write-Status -Types "-", $TweakType -Status "Disabling Game Bar tips..."
    Set-ItemProperty -Path "$PathToCUXboxGameBar" -Name "ShowStartupPanel" -Type DWord -Value 0
    Write-Status -Types "-", $TweakType -Status "Disabling Open Xbox Game Bar using Xbox button on Game Controller..."
    Set-ItemProperty -Path "$PathToCUXboxGameBar" -Name "UseNexusForGameBarEnabled" -Type DWord -Value 0

    Write-Status -Types "-", $TweakType -Status "Disabling GameBar Presence Writer..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" -Name "ActivationType" -Type DWord -Value 0

    Write-Status -Types "-", $TweakType -Status "Disabling Xbox Game Monitoring..."
    If (!(Test-Path "$PathToLMServicesXbgm")) {
        New-Item -Path "$PathToLMServicesXbgm" -Force | Out-Null
    }
    Set-ItemProperty -Path "$PathToLMServicesXbgm" -Name "Start" -Type DWord -Value 4
