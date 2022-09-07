Log("Removing bloatware, wait...")
    $BloatwareList = @(
        "Microsoft.BingNews"
        "Microsoft.BingWeather"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftSolitaireCollection"
        #"Microsoft.MicrosoftStickyNotes" # Issue by V1ce | Breaks sysprep
        "Microsoft.PowerAutomateDesktop" # Thanks V1ce
        "Microsoft.SecHealthUI" # Thanks V1ce
        "Microsoft.People"
        "Microsoft.Todos"
        #"Microsoft.Windows.Photos"
        "Microsoft.WindowsAlarms"
        #"Microsoft.WindowsCamera"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.YourPhone"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
        "MicrosoftTeams"
    )
    foreach($Bloat in $BloatwareList){
        if((Get-AppxPackage -Name $Bloat).NonRemovable -eq $false)
        {
            Log("Trying to remove $Bloat")
            Try {
                Get-AppxPackage -Name $Bloat | Remove-AppxPackage -ErrorAction Stop | Out-Null
                Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online -ErrorAction Stop
            }
            Catch {
                Error("Failed to remove $Bloat, exception : $($_)")
            }
            
        }  
    }
    Log("Bloatware is removed.")