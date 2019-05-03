# Cómo arreglar el arranque dual Windows 10 + GNU/Linux en sistemas con BIOS UEFI

En ocasiones, en equipos nuevos con BIOS UEFI, tras instalar en un mismo equipo un sistema Windows 10 junto con un sistema GNU/Linux (arranque dual), no aparece el menú del gestor de arranque GRUB que permite elegir el sistema que queremos arrancar, y directamente inicia Windows.

Para resolver este problema, debemos iniciar Windows y seguir los siguientes pasos:

1. Abrir "cmd" como Administrador.

2. Ejecutar el comando:

   ```
   bcdedit /set {bootmgr} path \EFI\ubuntu\grubx64.efi
   ```

3. Reiniciar el equipo.

## Referencias

- [FIX: Windows 10 Ubuntu dual boot not working](https://windowsreport.com/fix-dual-boot-windows-10-ubuntu/)