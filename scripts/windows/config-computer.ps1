Write-Host @"
Script de configuración automática de Windows 10

Departamento de Informática del IES Domingo Pérez Minik
"@

Function Run-RemoteScript($scriptName) {
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/iesdpm/informatica/master/scripts/$scriptName"))
}

# instalación de paquetes
Run-RemoteScript "w10-package-installation.ps1"

# crear los perfiles de los usuarios
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/iesdpm/informatica/master/scripts/w10-create-users.ps1'))

# cambiar perfiles a la unidad D
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/iesdpm/informatica/master/scripts/w10-change-profile-location.ps1'))

# automatizar los marcadores de google y firefox
# C:\Users\alumno\AppData\Local\Google\Chrome\User Data\Default

# programar el apagado del sistema a las 15:00 todos los días

# desinstalar onedrive

# instalar drivers

