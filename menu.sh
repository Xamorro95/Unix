#!/bin/bash
#
# Genera un menu con diferentes opciones para la creacion y gestion de un proyecto
# Autor: Miguel Chamorro
#

#Evita que se comprueben los ejemplos de otros scripts
EJECUTAR_EJEMPLOS_UTILIDADES=false
EJECUTAR_EJEMPLOS_USUARIOS=false
EJECUTAR_EJEMPLOS_CREACION_PROYECTO=false

# 
# Constantes utilizadas en las funciones
#
source formato.sh
source utilidades.sh
source crearproyecto.sh
source copiaseguridad.sh


#
#Compruebo si estoy  dentro de un proyecto comprobando si existe el fichero proyecto.propierties
#Si estoy dentro de un proyecto deshabilito opcion de crear proyecto
#Si no estoy dentro de un proyecto, solo muestro la opcion de crear proyecto
#
while [[ true ]];
do
	clear
	echo_titulo "MENU PRINCIPAL"
	if [[ -e proyecto.properties ]]; then
		echo " 1. Compilar"
		echo " 2. Probar"
		echo " 3. Backup src"
		echo " 4. Backup bin"
		echo " 5. Borrar bin"
	else
		echo " 6. Crear proyecto"
	fi
	echo
	echo " 0. Salir"
	echo
	PreguntarValor opcion_seleccionada "Que quieres hacer?"
	echo 

	case $opcion_seleccionada in
		0)
			break
			;; 
		3)	
			if [[ -e proyecto.properties ]]; then
				CopiaSeguridad	
			else
				echo_error "Por favor, pulsa una opcion valida!"
				read -p "Pulsa cualquier tecla para continuar..." -N 1 
			fi
			;;
		6) 
			if [[ -e proyecto.properties ]]; then			
				echo_error "Por favor, pulsa una opcion valida!"
				read -p "Pulsa cualquier tecla para continuar..." -N 1 
			else
				CrearProyecto
			fi
			;;
		*)
			echo_error "Por favor, pulsa una opcion valida!"
			read -p "Pulsa cualquier tecla para continuar..." -N 1 
			;;
	esac
			
done

clear
