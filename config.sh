Set-MpPreference -DisableRealtimeMonitoring $true
Uninstall-WindowsFeature -Name Windows-Defender-Features
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -standby-timeout-ac 0
powercfg -change -standby-timeout-dc 0
powercfg -change -hibernate-timeout-ac 0
powercfg -change -hibernate-timeout-dc 0
$chromeInstaller = "chrome_installer.exe"
Invoke-WebRequest -Uri "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $chromeInstaller
Start-Process -FilePath .\$chromeInstaller -ArgumentList "/silent /install" -Wait
Remove-Item -Path .\$chromeInstaller
Restart-Computer
