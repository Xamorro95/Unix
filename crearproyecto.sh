#!/bin/bash
#si me han pasado un nombre de proyecto lo cargo en la variable
nombre=$1


# Comprobamos si nos han pasado nombre de proyecto
if [[ -z $nombre ]];
	then

#Comprobamos si el fichero existe y tenemos permiso
	if [[ -r proyecto.properties ]];
	then
		source proyecto.properties
		nombre=$proyecto
	fi
fi	

#Si continuamos sin nombre de proyecto lo solicitamos
if [[ -z $nombre ]];
	then
		read -p "Introduce un nombre de proyecto: " nombre
fi

#compruebo si el nombre de proyecto existe con bucle mediante $comprobante
while [[ $comprobante != 1 ]]
do
	if [[ -e $nombre ]];
		then
			echo "El proyecto ya existe"
			read -p "Introduce un nuevo nombre: " nombre
	else
		comprobante=1
	fi
done
#Creo directorio con nombre de proyecto en directorio actual
mkdir $nombre

#Creo el resto de directorios en la carpeta anterior
#Dar permisos de ejecucion a la carpeta bin
mkdir $nombre/bin

mkdir $nombre/src
#Miro si existe un usuario de backup en la maquina creada, si no existe lo creo
#Creo la carpeta backup con el usuario backup y para cualquier otro usuario solo tienen permisos de lectura
mkdir $nombre/backup

mkdir $nombre/data

#Crear fichero de configuracion del proyecto
