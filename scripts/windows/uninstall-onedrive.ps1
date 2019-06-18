# https://lifehacker.com/how-to-completely-uninstall-onedrive-in-windows-10-1725363532

Write-Output "Uninstalling OneDrive..."
exit 1

If (-Not (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -Match "S-1-5-32-544")) {
    Write-Host -ForegroundColor Red "Debe ejecutar el script como Administrador"
    Exit 1
}

# Detener el proceso de OneDrive
Write-Host "Deteniendo el proceso de OneDrive ..."
Stop-Process -Force -Name OneDrive

# Ejecuta el desinstalador de OneDrive para la aquitectura correspondiente
Write-Host "Desinstalando OneDrive ..."
If ([System.Environment]::Is64BitOperatingSystem) {
    &"$env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall
} else {
    &"$env:SystemRoot\System32\OneDriveSetup.exe" /uninstall
}

Write-Host "Proceso completado"