# Configuración de equipos con Windows

Para configurar los equipos con Windows instalado ejecutamos un script que hace lo siguiente:

1. Instala el software de la siguiente [lista](packages.txt).

2. Configura el sistema para que almacene los perfiles de los usuarios en la segundad unidad (unidad D:)
   
   > :warning: Sólo en caso de que se detecte una segunda unidad en el equipo.

3. Crear el perfil de usuario `Alumno` (con privilegios administrativos).

4. Programa el apagado del sistema a las 15:00 todos los días (al terminar las clases).

5. Desinstala OneDrive.

6. Cambia el nombre del equipo a `INFORMATICA` y mete el equipo en el grupo de trabajo `IESCANARIAS`.

7. Cambia la zona horaria a GMT-0 (Atlantic/Canary).

8. Deshabilita Windows Update.

## Requisitos

* Windows 7+/2012+
* PowerShell v2+

## Ejecución del script

Ejecutar el siguiente comando como `Administrador` desde:

### Símbolo del sistema (CMD):

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/iescanarias/informatica/master/config/windows/config-computer.ps1'))"
```

### PowerShell (PS):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/iescanarias/informatica/master/config/windows/config-computer.ps1'))
```

