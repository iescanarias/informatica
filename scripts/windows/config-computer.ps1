Write-Host @"
Script de configuraci�n autom�tica de Windows 10

Departamento de Inform�tica del IES Domingo P�rez Minik
"@

# Load functions from library
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/iesdpm/informatica/master/scripts/windows/functions.ps1"))

# Check if is running as administrator
If (Test-RunningAsAdministrator) {

    # instalaci�n de paquetes
    Install-Packages

    # cambiar perfiles a la unidad D
    Write-Output "Changing profiles location in Windows Registry..."

    # crear los perfiles de los usuarios
    Write-Output "Creating users..."
    Write-Output "+ Alumno user created"
    Write-Output "+ Profesor user created"

    # automatizar los marcadores de google y firefox
    # C:\Users\alumno\AppData\Local\Google\Chrome\User Data\Default
    Write-Output "Creating browser markers..."

    # programar el apagado del sistema a las 15:00 todos los días
    Write-Output "Programming system shutdown everyday at 3pm..."

    # desinstalar onedrive
    Uninstall-OneDrive

} Else {

    Write-Error "Must be run as" (Get-AdminUsername)

 }