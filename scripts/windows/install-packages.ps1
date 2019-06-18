# Instalacián automática de paquetes



# ------------------------------------------
# Script
# ------------------------------------------

Write-Output "Installing packages ..."
exit 0

# Comprueba si el script se está ejecutando como Administrador
If (-Not (Test-RunningAsAdministrator)) {
    Write-Host -ForegroundColor Red "Debe ejecutar el script como Administrador"
    Exit 1
}

# Instalación del gestor de paquetes Chocolatey
If (-Not (Test-ChocoInstalled)) {
    Install-Choco
}

# Instalación de paquetes
Get-PackagesList | ForEach-Object { 
    Install-Package $_
}