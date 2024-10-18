# Instalación de software en los equipos de 1ºSMR (Windows)

Este script instala de forma automática las siguientes aplicaciones:
- VirtualBox
- Libre Office
- Packet Tracer
- AdoptOpenJDK JRE8
- OpenSSH

## Ejecución del script

Ejecutar el siguiente comando como `Administrador` desde:

### Símbolo del sistema (CMD):

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/iescanarias/informatica/master/config/windows/1smr/config-computer.ps1'))"
```

### PowerShell (PS):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/iescanarias/informatica/master/config/windows/1smr/config-computer.ps1'))
```

Made with :heart: by [@fvarrui](https://github.com/fvarrui)
