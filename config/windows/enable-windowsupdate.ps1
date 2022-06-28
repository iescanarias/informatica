Write-Host @"

Script de para habilitar Windows Update.
Departamento de Informática del IES Domingo Pérez Minik

"@

# Load functions from library
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/iesdpm/informatica/master/config/windows/functions.ps1"))

# Check if is running as administrator
If (Test-RunningAsAdministrator) {

    Enable-WindowsUpdate

} Else {

    Write-Host -ForegroundColor Red "Must be run as" (Get-AdminUsername)

 }