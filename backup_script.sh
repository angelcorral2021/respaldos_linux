#!/bin/bash

# Directorio de origen y repositorio
ORIGEN="/home/jidu/Downloads"
REPO_DIR="/home/jidu/Desktop/ARCHIVOS_BACKUP"

# Fecha actual para el nombre del backup
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVO_BACKUP="backup_$FECHA.tar.gz"

# Crear backup en el directorio del repositorio
mkdir -p "$REPO_DIR"
tar -czvf "$REPO_DIR/$ARCHIVO_BACKUP" "$ORIGEN"

# Subir cambios al repositorio de GitHub
cd "$REPO_DIR"
git add "$ARCHIVO_BACKUP"
git commit -m "Backup: $FECHA"
git push origin main  # Asegúrate de que la rama sea 'main' o ajusta según corresponda

echo "Respaldo y subida a GitHub completados."
