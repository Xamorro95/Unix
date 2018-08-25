#!/bin/bash
# Declaro valor de variable $bucle para generar un bucle con control
bucle=1

while [[ $bucle == 1 ]];
do	
	echo "--------------MENU PRINCIPAL-----------"
	echo "1. Crear proyecto"
	echo "0. Exit"
	read -p "Que deseas hacer: " opcion
	if [[ $opcion == 1 ]];
	then	
		source crearproyecto.sh
		elif [[ $opcion == 0 ]];
		then
			bucle=0
	else
		echo "Ese parametro no esta contemplado"
	fi
done
