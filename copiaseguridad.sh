#!/bin/bash
#
# Generar una copia de seguridad
# Autor: Miguel Chamorro
#

# 
# Constantes utilizadas en las funciones
#
source proyecto.properties


function CopiaSeguridad(){
	#Almaceno en una variable la fecha, hora y minutos del momento de realizar la copia de seguridad
	fecha=$(date "+%Y%m%d_%H%M")
	
	#Creamos la ruta de carpetas necesarias para almacenar la copia
	mkdir temp &> /dev/null
	mkdir temp/backups &> /dev/null
	mkdir temp/backups/src &> /dev/null
	mkdir temp/backups/src/$fecha &> /dev/null

	#Comprimimos la copia de seguridad
	tar -cvf ./temp/backups/src/$fecha/$PROYECTO.tar.gz ./src
	
	#Cambiamos permisos y propietario al tar.gz creado
	sudo chmod -R 604 ./temp/backups/src/$fecha
	sudo chown -R backupP ./temp/backups/src/$fecha
	
	#Copiamos el tar.gz a backup
	sudo mv ./temp/backups/src/$fecha ./backup/src
	
	#Borramos la carpeta temporal creada
	sudo rm -R ./temp

	echo "Creada copia de seguridad src"
	echo_pausa
}
