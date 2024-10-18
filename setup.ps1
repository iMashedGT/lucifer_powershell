# Tools that need to download
# remove the # if u need the gmail log
$DownloadMegaList = @(
    @{ Link = "https://mega.nz/file/l6VGDZLa#c9Vd_DVY5BQzpzb8_Rg0c9m6umf-JPgnNyqOVm2QhOY"; Description = "lucifer" },
    #@{ Link = "https://mega.nz/file/FiEyXRoR#BEPvFWNxrmW6M6f7_z0d9la5P_NguoaMl8r7EoMO22o"; Description = "gmailog" },
    @{ Link = "https://mega.nz/file/EzlC1bjA#xy169n9LXQmBhpa6s7HJj3Cc7ZSOJWPUsjGmB5_ace0"; Description = "steamlog" }
)



# do not touch if dont know any of these
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Vcredist
$vcredistDisplayName = "Microsoft Visual C++ 2015-2022 Redistributable (x64)*"
$vcredistInstalled = Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -like $vcredistDisplayName
}

if (-not $vcredistInstalled) {
    Write-Host "Installing Vcredist"
    $vcredistUrl = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
    $vcredistInstaller = "$env:TEMP\vc_redist.x64.exe"
    Invoke-WebRequest -Uri $vcredistUrl -OutFile $vcredistInstaller
    Start-Process -FilePath $vcredistInstaller -ArgumentList "/install", "/quiet", "/norestart" -Wait
    Remove-Item -Path $vcredistInstaller
} else {
    Write-Host "Vcredist alr installed"
}

# Chrome
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
if (-not (Test-Path $chromePath)) {
    Write-Host "Installing Google Chrome"
    $chromeInstaller = "$env:TEMP\chrome_installer.exe"
    Invoke-WebRequest -Uri "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $chromeInstaller
    Start-Process -FilePath $chromeInstaller -ArgumentList "/silent", "/install" -Wait
    Remove-Item -Path $chromeInstaller
} else {
    Write-Host "Google Chrome alr installed"
}

# MEGAcmd
$megacmdPath = "C:\Users\Administrator\AppData\Local\MEGAcmd\mega-get.bat"
if (-not (Test-Path $megacmdPath)) {
    Write-Host "Installing MEGAcmd"
    $megacmdUrl = "https://mega.nz/MEGAcmdSetup64.exe"
    $megacmdInstaller = "$env:TEMP\MEGAcmdSetup64.exe"
    Invoke-WebRequest -Uri $megacmdUrl -OutFile $megacmdInstaller
    Start-Process -FilePath $megacmdInstaller -ArgumentList "/silent" -Wait
    Remove-Item -Path $megacmdInstaller
} else {
    Write-Host "MEGAcmd alr installed"
}
$extractPath = "$env:USERPROFILE\Desktop\Luciferimas"
foreach ($item in $DownloadMegaList) {
    $destinationPath = "$env:TEMP\$($item.Description).zip"

    Write-Host "Download $($item.Description)"
    & "$megacmdPath" "$($item.Link)" "$destinationPath"
    if (Test-Path $destinationPath) {
        Write-Host "$($item.Description) Extract"
        Expand-Archive -Path $destinationPath -DestinationPath "$extractPath\$($item.Description)" -Force
        $sourcePath = "$extractPath\$($item.Description)"
        Get-ChildItem -Path $sourcePath -Recurse | ForEach-Object {
            if ($_.PSIsContainer) {
                Get-ChildItem -Path $_.FullName -Recurse | Move-Item -Destination $extractPath -Force
            } else {
                Move-Item -Path $_.FullName -Destination $extractPath -Force
            }
        }
        Remove-Item -Path $sourcePath -Recurse -Force

        Write-Host "Delete $($item.Description)..."
        Remove-Item -Path $destinationPath
    } else {
        Write-Host "$($item.Description) Failed to download."
    }
}

# Windows Things
Write-Host "Windows Things Deleting Windows Defender"
Set-MpPreference -DisableRealtimeMonitoring $true
Uninstall-WindowsFeature -Name Windows-Defender-Features
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -standby-timeout-ac 0
powercfg -change -standby-timeout-dc 0
powercfg -change -hibernate-timeout-ac 0
powercfg -change -hibernate-timeout-dc 0
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#Write-Host "Proses selesai. Tekan Enter untuk menutup PowerShell."
#Read-Host

Write-Host "Restarting Because removing Windows Defender"
Restart-Computer
