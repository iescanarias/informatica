Write-Host @"

Script de configuración automática de Windows
Departamento de Informática del IES Canarias

"@

# Load functions from library
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/iescanarias/informatica/master/config/windows/functions.ps1"))

# Check if is running as administrator
If (Test-RunningAsAdministrator) {

    # Packages installation from a list in URL
    Install-Packages "https://raw.githubusercontent.com/iescanarias/informatica/master/config/windows/packages.txt"

    # Change user profiles location to a secondary disk drive if it's possible
    # https://www.nextofwindows.com/how-to-change-user-profile-default-location-in-windows-7
    Change-ProfilesLocation

    # Create new users
    Write-Output "Creating users..."
    Create-User -username "Alumno" -password "onmula" -group Administradores

    # Schedule a task to shutdown computer everyday at 3pm
    Schedule-Shutdown

    # Uninstall onedrive
    Uninstall-OneDrive

    # Change computer name and workgroup
    Write-Output "Changing computer name to INFORMATICA and workgroup to IESCANARIAS..."
    Rename-Computer -NewName "INFORMATICA" -ErrorAction SilentlyContinue
    Add-Computer -WorkgroupName "IESCANARIAS" -ErrorAction SilentlyContinue

    # Set timezone
    Write-Output "Setting timezone to GMT Standard Time"
    tzutil /s "GMT Standard Time"

    # Disable Windows Update
    Disable-WindowsUpdate

} Else {

    Write-Host -ForegroundColor Red "Must be run as" (Get-AdminUsername)

 }