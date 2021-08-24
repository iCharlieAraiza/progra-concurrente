#!/bin/bash
FECHA_Y_HORA=`date "+%d-%m-%y_%H-%M-%S"`
NOMBRE_ARCHIVO="$FECHA_Y_HORA.tgz"
CARPETA_DESTINO="./respaldos"
CARPETA_RESPALDAR="cosas_importantes"
# Creamos el directorio para los respaldos por si no existe
mkdir -p "$CARPETA_DESTINO"
tar cfvz "$CARPETA_DESTINO/var_$NOMBRE_ARCHIVO" "/var"
