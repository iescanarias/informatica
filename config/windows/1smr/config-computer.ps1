Write-Host @"

Script de instalación de apps automática en Windows para los equipos de 1ºSMR.
Departamento de Informática del IES Canarias

"@

# ----------------------------------
# Users/groups related functions
# ----------------------------------

# Check if current user has admin privileges
Function Test-RunningAsAdministrator() {
    return (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -Match "S-1-5-32-544")
}

# ----------------------------------
# Chocolatey related functions
# ----------------------------------

# Checking if Chocolatey is installed
function Test-ChocoInstalled() {
    Write-Host -NoNewline "Checking if Chocolatey is installed ... "
    $ChocoInstalled = $false
    if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
        $ChocoInstalled = $true
        Write-Host "[INSTALLED]"
    } else {
        Write-Host "[NOT INSTALLED]"
    }
    return $ChocoInstalled
}

# Install Chocolatey
function Install-Choco() {
    Write-Host "Installing Chocolatey..."
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install a package with Chocolatey
function Install-Package([string]$package) {
    Write-Host -NoNewline "Installing $package ... "
    choco install --ignore-checksum -y $package | Out-Null
    If ($LASTEXITCODE -eq 0) {
        Write-Host "[Ok]"
    } else {
        Write-Host "[Error]"
    }
}

# ----------------------------------
# Software installation related functions
# ----------------------------------

Function Install-Packages($packages) {

    Write-Host "Installing packages ..."

    # Instalación del gestor de paquetes Chocolatey
    If (-Not (Test-ChocoInstalled)) {
        Install-Choco
    }

    # Instalación de paquetes
    $packages | ForEach-Object { 
        Install-Package $_
    }

}

Function Install-FromUrl($url, $options) {

    # get filename from url
    $filename = [System.IO.Path]::GetFileName($url)
    Write-Output "Installing $filename from $url"

    # download file
    Write-Output "Downloading installer from $url..."
    $file = "$env:TEMP\$filename"
    Invoke-WebRequest -Uri $url -OutFile $file

    # run installer
    Write-Output "Running installer: $file..."
    Start-Process -FilePath $file -ArgumentList $options -Wait

}

# ----------------------------------
# Main (installs all packages from the list)
# ----------------------------------

# Check if is running as administrator
If (Test-RunningAsAdministrator) {
    
    # Packages installation
    Install-Packages @( "virtualbox", "libreoffice-fresh", "adoptopenjdk8openj9jre", "openssh" )
    Install-FromUrl "https://github.com/iescanarias/informatica/releases/download/2024.10.17/pt822.exe", @("/SILENT")

    # Shutdown computer after installations
    Write-Host "Shutting down computer ..."
    #Stop-Computer -Force

} Else {

    Write-Host -ForegroundColor Red "Must be run as" (Get-AdminUsername)

 }