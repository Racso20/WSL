# WSL (Windows Subsystem for Linux) Configuration Script

Este script de configuración está diseñado para mejorar la experiencia de usuario al utilizar WSL en Windows. Automatiza varias configuraciones y ajustes para hacer que el entorno sea más funcional y cómodo.

## Características

- Actualización del sistema operativo.
- Instalación de herramientas y aplicaciones útiles.
- Solución de errores relacionados con WFUZZ.
- Configuración del sistema y descarga de complementos de WSL.
- Configuración de Nano y Inputrc.
- Estandarización de carpetas de usuario y enlace de carpetas OneDrive.
- Configuración de alias para mejorar la interactividad en la terminal.
- Eliminación de ZSH (opcional).
- Actualización de la base de datos de archivos.

## Requisitos

- Kali-linux compatible de WSL. *(Con la Distro de Ubuntu genera error al instalar las aplicaciones)*

## Uso

1. Abre WSL.
2. Descarga e instala el script usando los siguientes comandos:

    ```bash
    wget https://raw.githubusercontent.com/Racso20/WSL/main/install.sh
    chmod +x install.sh
    ./install.sh
    ```

3. Este script automatizará la configuración y mejoras en el entorno de WSL.
4. Desde Powershell reiniciar WSL después de completar el proceso para aplicar todas las configuraciones.
   ```bash
   wsl --shutdown
   ```
6. Ingrese nuevamente a WS y ejecute
   ```bash
   sudo systemctl enable squid
   sudo systemctl start squid
   ```

**Nota:** Si prefieres clonar el repositorio manualmente, puedes hacerlo con el siguiente comando:
```bash
git clone https://github.com/Racso20/WSL.git
```
## Notas adicionales

- Puedes personalizar el banner en el archivo `/etc/$usuario.sh`.
- Si deseas eliminar ZSH, sigue las instrucciones proporcionadas durante la ejecución del script.
  
---

**Template Banner** <a href="https://patorjk.com/software/taag/#p=display&f=Big&t=Racso" target="_blank">Template Banner</a>

**Autor:** Racso

**Perfil de GitHub:** <a href="https://github.com/Racso20" target="_blank">Racso20</a>
