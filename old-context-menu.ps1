New-Item -Path "HKCU:\SOFTWARE\Classes\CLSID" -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force -Value "" | Out-Null
Restart-Process -Process explorer
Log("Old context menu enabled!")