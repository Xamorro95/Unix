#!/bin/bash
#
# Generar una copia de seguridad
# Autor: Miguel Chamorro
#

# 
# Constantes utilizadas en las funciones
#
source proyecto.properties

#
#Recibe por parametro la carpeta sobre la cual hay que realizar la copia
#
function CopiaSeguridad(){
	#Almaceno en una variable la fecha, hora y minutos del momento de realizar la copia de seguridad
	fecha=$(date "+%Y%m%d_%H%M")
	
	#Creamos la ruta de carpetas necesarias para almacenar la copia
	mkdir temp &> /dev/null
	mkdir temp/backups &> /dev/null
	mkdir temp/backups/$1 &> /dev/null
	mkdir temp/backups/$1/$fecha &> /dev/null

	#Comprimimos la copia de seguridad
	tar -cvf ./temp/backups/$1/$fecha/$PROYECTO.tar.gz ./src
	
	#Cambiamos permisos y propietario al tar.gz creado
	sudo chmod -R 604 ./temp/backups/$1/$fecha
	sudo chown -R backupP ./temp/backups/$1/$fecha
	
	#Copiamos el tar.gz a backup
	sudo mv ./temp/backups/$1/$fecha ./backup/$1
	
	#Borramos la carpeta temporal creada
	sudo rm -R ./temp

	echo "Creada copia de seguridad $1"
	echo_pausa
}
