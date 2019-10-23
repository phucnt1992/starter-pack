#Requires -RunAsAdministrator

param (
    [switch]$SkipChoco = $false
)
########## Chocolatey Installation ##########
Write-Host "Chocolatey installation is processing..." -ForegroundColor Green
$TestChocoVersion = powershell choco -v

if (-not($TestChocoVersion)) {
    Write-Host "Seems Chocolatey is not installed, installing now..." -ForegroundColor Yellow

    $CurrentExecutionPolicy = Get-ExecutionPolicy | Out-String;

    if ($CurrentExecutionPolicy -eq "Restricted") {
        Write-Host "ExecutionPolicy is $CurrentExecutionPolicy, setting it to AllSigned." -ForegroundColor Yellow
        Set-ExecutionPolicy AllSigned;
    }

    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    Write-Host "Chocolatey Version $TestChocoVersion is already installed" -ForegroundColor Green
}

########## Prerequisites Programs Installation ##########
if (!($SkipChoco)) {
    Write-Host "Prerequisites programs installation is processing..." -ForegroundColor Green
    Get-Content ".\choco.txt" | ForEach-Object {
        choco install $_ -i -y;
    }
}

########## Posh-Git installations ##########
Write-Host "Posh-git installation is processing..." -ForegroundColor Green
if (-not(Get-Module -Name PowerShellGet)) {
    Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber;
}
if (-not(Get-Module -Name posh-git)) {
    PowerShellGet\Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force;
}
else {
    PowerShellGet\Update-Module posh-git;
}

########## Copy Profile.ps1 ##########
Write-Host "Copying Profile.ps1 is processing..." -ForegroundColor Green
Copy-Item ./config/profile.ps1 $HOME/Documents/PowerShell/profile.ps1;

######### Open WSL Feature ##########
Write-Host "Opening WSL is processing..." -ForegroundColor Green
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

########## Done ##########
Write-Host "DONE! Congratulations!" -ForegroundColor Green
