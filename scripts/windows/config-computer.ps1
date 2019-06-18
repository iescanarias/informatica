Write-Host @"

Windows automatic configuration script
Computer Science Department (IES Domingo Pérez Minik)

"@

# Load functions from library
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/iesdpm/informatica/master/scripts/windows/functions.ps1"))

# Check if is running as administrator
If (Test-RunningAsAdministrator) {

    # Packages installation
    Install-Packages

    # Change user profiles location to a secondary disk drive if it's possible
    # https://www.nextofwindows.com/how-to-change-user-profile-default-location-in-windows-7
    Change-ProfilesLocation

    # Create new users
    Write-Output "Creating users..."
    Create-User "Profesor", "roseforp"
    Create-User "Alumno", "onmula"

    # Schedule a task to shutdown computer everyday at 3pm
    Schedule-Shutdown

    # desinstalar onedrive
    Uninstall-OneDrive

} Else {

    Write-Host -ForegroundColor Red "Must be run as" (Get-AdminUsername)

 }