
# ----------------------------------
# Users/groups related functions
# ----------------------------------

# Get system administrator's username
Function Get-AdminUsername() {
    return (Get-LocalUser | Where-Object SID -Match "S-1-5-21.*-500").Name
}

# Check if current user has admin privileges
Function Test-UserIsMemberOfAdminsGroup() {
    return (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -Match "S-1-5-32-544")
}

# Stop script execution if is not running with admin privileges
Function Test-RunningAsAdministrator() {
    If (-Not (Test-UserIsMemberOfAdminsGroup)) {
        Write-Host -ForegroundColor Red "Must be run as" (Get-AdminUsername)
        Exit 1
    }
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
function Install-Choco([string]$package) {
    Write-Host "Installing Chocolatey..."
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install a package with Chocolatey
function Install-Package([string]$package) {
    Write-Host -NoNewline "Installing $package ... "
    choco install -y $package | Out-Null
    If ($LASTEXITCODE -eq 0) {
        Write-Host "[Ok]"
    } else {
        Write-Host "[Error]"
    }
}
