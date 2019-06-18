# Instalaci�n autom�tica de paquetes



# ------------------------------------------
# Script
# ------------------------------------------

Write-Output "Installing packages ..."
exit 0

# Comprueba si el script se est� ejecutando como Administrador
If (-Not (Test-RunningAsAdministrator)) {
    Write-Host -ForegroundColor Red "Debe ejecutar el script como Administrador"
    Exit 1
}

# Instalaci�n del gestor de paquetes Chocolatey
If (-Not (Test-ChocoInstalled)) {
    Install-Choco
}

# Instalaci�n de paquetes
Get-PackagesList | ForEach-Object { 
    Install-Package $_
}