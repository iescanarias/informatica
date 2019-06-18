Write-Host @"
Script de configuración automática de Windows 10

Departamento de Informática del IES Domingo Pérez Minik
"@

# Load functions from library
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/iesdpm/informatica/master/scripts/windows/functions.ps1"))

# Check if is running as administrator
If (Test-RunningAsAdministrator) {

    # instalación de paquetes
    #Install-Packages
    Write-Output "Installing packages..."

    # cambiar perfiles a la unidad D
    Write-Output "Changing profiles location in Windows Registry..."

    # crear los perfiles de los usuarios
    Write-Output "Creating users..."
    Write-Output "+ Alumno user created"
    Write-Output "+ Profesor user created"

    # automatizar los marcadores de google y firefox
    # C:\Users\alumno\AppData\Local\Google\Chrome\User Data\Default
    Write-Output "Creating browser markers..."

    # programar el apagado del sistema a las 15:00 todos los dÃ­as
    Write-Output "Programming system shutdown everyday at 3pm..."

    # desinstalar onedrive
    #Uninstall-OneDrive
    Write-Output "Uninstalling OneDrive..."

} Else {

    Write-Host -ForegroundColor Red "Must be run as" (Get-AdminUsername)
    Exit 1

 }