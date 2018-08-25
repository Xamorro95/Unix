#!/bin/bash
#Declaro ficheros
source filtrar.sh

echo proyecto=$1 > proyecto.properties
read -p "Su poyecto usa base de datos (si/no)" usabbdd

#evito error de falta de respuesta o respuesta incorrecta con un maximo de 3 intentos mediante un bucle
# while [[ $usabbdd != "si" ]] && [[ $usabbdd != "no" ]]
contador=1
while true;
do
	if [[ $usabbdd == "si" ]];
	then
		echo basededatos=true >> proyecto.properties
		read -p "Introduce el tipo de base de datos: " nombre_base_datos
		echo nombre_base_datos=$nombre_base_datos >> proyecto.properties

#Compruebo si el proceso se esta ejecutando
		comprobarProceso $nombre_base_datos
		break
	elif [[ $usabbdd == "no" ]];
	then
		echo basededatos=false >> proyecto.properties
		break
	fi

#Compruebo el estado del contador, si lo supera, finalizo programa
	if [[ $contador < 3 ]];
	then
		echo "Error al registrar base de datos"
		read -p "Su poyecto usa base de datos (si/no)" usabbdd
		contador=$(($contador + 1))
	else
		echo "Has consumido el limite"
		exit
	fi
	
done
