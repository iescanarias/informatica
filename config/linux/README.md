# Configuración de equipos con GNU/Linux (Debian)

Para configurar los equipos con Debian instalado ejecutamos un script que hace lo siguiente:

1. Instala el software de la siguiente [lista](packages.txt) de paquetes.

2. Instala el software de la siguiente [lista](urls.txt) de URLs.

2. Crear los perfiles de los usuarios: `Profesor` y `Alumno`.

3. Programa el apagado del sistema a las 15:00 de lunes a viernes (al terminar las clases).

## Requisitos

* LinuxMint 19.1

## Ejecución del script

Ejecutar el siguiente comando desde la BASH:

```bash
wget -qO- https://raw.githubusercontent.com/iesdpm/informatica/master/config/linux/config-computer.sh | sudo bash
```
