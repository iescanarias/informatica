# Configuración de equipos con GNU/Linux (Ubuntu)

Para configurar los equipos con Debian instalado ejecutamos un script que hace lo siguiente:

1. Actualiza el sistema completo.
2. Crea el perfil de usuario **alumno** si no existe, con privilegios de administrador.
3. Añade nuevos repositorios al sistema declarados en el fichero de configuración.
4. Instala los paquetes declarados en el fichero de configuración.
5. Descarga e instala los ficheros DEB declarados en el fichero de configuración.
6. Descarga  y ejecuta los instaladores declarados en el fichero de configuración.
7. Programa el apagado del sistema a las 15:00 todos los días (al terminar las clases).

> El fichero de configuración es [install.conf](install.conf).

## Requisitos

* Distribución basada en Ubuntu

## Ejecución del script

Ejecutar el siguiente comando desde la BASH:

```bash
wget -qO- https://raw.githubusercontent.com/iesdpm/informatica/master/config/linux/config-computer.sh | sudo bash
```
