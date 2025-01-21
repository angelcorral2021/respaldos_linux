#!/bin/bash

set -e  # Detener el script en caso de error

# Directorio de origen y repositorio
ORIGEN="/home/jidu/Downloads"
REPO_DIR="/home/jidu/Desktop/ARCHIVOS_BACKUP"

# Fecha actual para el nombre del backup
FECHA=$(date '+%Y-%m-%d_%H-%M-%S')
ARCHIVO_BACKUP="backup_$FECHA.tar.gz"

# Verificar si el directorio de origen existe
if [ ! -d "$ORIGEN" ]; then
    echo "Error: El directorio de origen no existe." >&2
    exit 1
fi

# Verificar si el directorio del repositorio existe, si no, crearlo
if [ ! -d "$REPO_DIR" ]; then
    echo "El directorio del repositorio no existe. Creándolo..."
    mkdir -p "$REPO_DIR"
fi

# Crear backup en el directorio del repositorio
echo "Creando el backup..."
if tar -czvf "$REPO_DIR/$ARCHIVO_BACKUP" -C "$ORIGEN" .; then
    echo "Backup creado exitosamente."
else
    echo "Error: Falló la creación del backup." >&2
    exit 1
fi

# Subir cambios al repositorio de GitHub
cd "$REPO_DIR" || { echo "Error: No se pudo acceder al directorio del repositorio." >&2; exit 1; }

echo "Subiendo a GitHub..."
git add "$ARCHIVO_BACKUP" && \
    git commit -m "Backup: $FECHA" && \
    git push origin main && \
    echo "Respaldo y subida a GitHub completados correctamente."

