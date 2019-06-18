Write-Host @"
Script de configuración automática de Windows 10

Departamento de Informática del IES Domingo Pérez Minik
"@

# instalación de paquetes
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# crear los perfiles de los usuarios

# mover perfil del usuario a la unidad D:

# eliminar el perfil viejo

# automatizar los marcadores de google y firefox
# C:\Users\alumno\AppData\Local\Google\Chrome\User Data\Default

# programar el apagado del sistema a las 15:00 todos los días

# desinstalar onedrive

# instalar drivers

