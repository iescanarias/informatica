Write-Host @"
Script de configuraci�n autom�tica de Windows 10

Departamento de Inform�tica del IES Domingo P�rez Minik
"@

Function Run-RemoteScript($scriptName) {
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/iesdpm/informatica/master/scripts/windows/$scriptName"))
}

# instalaci�n de paquetes
Run-RemoteScript "install-packages.ps1"

# crear los perfiles de los usuarios
Run-RemoteScript "create-users.ps1"

# cambiar perfiles a la unidad D
Run-RemoteScript "change-profiles-location.ps1"

# automatizar los marcadores de google y firefox
# C:\Users\alumno\AppData\Local\Google\Chrome\User Data\Default
Run-RemoteScript "create-browser-markers.ps1"

# programar el apagado del sistema a las 15:00 todos los días
Run-RemoteScript "program-shutdown.ps1"

# desinstalar onedrive
Run-RemoteScript "uninstall-onedrive.ps1"
