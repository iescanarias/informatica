# Configuración de equipos con GNU/Linux (Ubuntu)

Para configurar los equipos con Debian instalado ejecutamos un script que hace lo siguiente:

1. Instala los certificados de los repositorios de la siguiente [lista](keys.txt).
2. Configura en el sistema los repositorios de la siguiente [lista](repos.txt).
3. Instala los paquetes de la siguiente [lista](packages.txt).
4. Instala los paquetes DEB de la siguiente [lista](debs.txt) de URLs.
5. Crear los perfiles de los usuarios: `Profesor` y `Alumno`.
6. Programa el apagado del sistema a las 15:00 todos los días (al terminar las clases).

## Requisitos

* Distribución basada en Ubuntu

## Ejecución del script

Ejecutar el siguiente comando desde la BASH:

```bash
wget -qO- https://raw.githubusercontent.com/iesdpm/informatica/master/config/linux/config-computer.sh | sudo bash
```
