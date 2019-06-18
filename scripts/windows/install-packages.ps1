# Instalación automática de paquetes

# ------------------------------------------
# Funciones
# ------------------------------------------

function Test-RunningAsAdministrator {
    return (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
}

# Comprueba si Chocolatey está instalado
function Test-ChocoInstalled() {
    Write-Host -NoNewline "Comprobando si Chocolatey está instalado ... "
    $ChocoInstalled = $false
    if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
        $ChocoInstalled = $true
        Write-Host "[INSTALADO]"
    } else {
        Write-Host "[NO INSTALADO]"
    }
    return $ChocoInstalled
}

# Instalar Chocolatey
function Install-Choco([string]$package) {
    Write-Host "Instalando Chocolatey..."
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Instalar un paquete con Chocolatey
function Install-Package([string]$package) {
    Write-Host -NoNewline "Instalando $package ... "
    choco install -y $package | Out-Null
    If ($LASTEXITCODE -eq 0) {
        Write-Host "[Ok]"
    } else {
        Write-Host "[Error]"
    }
}

# Obtener lista de paquetes a instalar
function Get-PackagesList {

    # Obtiene la lista de paquetes a instalar desde una URL (PRODUCCION)
    return ((New-Object System.Net.WebClient).DownloadString('url al fichero de paquetes')).Split("`n")

}

# ------------------------------------------
# Script
# ------------------------------------------

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