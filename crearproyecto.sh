#!/bin/bash
#
# Funciones para la creacion de un proyecto nuevo
# Autor: Miguel Chamorro
#

#Evita que se comprueben los ejemplos de utilidades
EJECUTAR_EJEMPLOS_UTILIDADES=false
EJECUTAR_EJEMPLOS_USUARIOS=false

# Utilidades para preguntar por consola al usuario preguntas
source utilidades.sh
source utilidadesUsuarios.sh

# 
# Constantes utilizadas en las funciones
#
if [[ -z $EJECUTAR_EJEMPLOS_CREACION_PROYECTO ]]; then
	EJECUTAR_EJEMPLOS_CREACION_PROYECTO=true	# Ejecutar los ejemplos. Si este fichero se ha importado en otro
							# donde se ha definido esta variable, el valor del otro prevalece.
fi

function CrearProyecto(){
	#Mantiene bucle hasta que se recibe un nombre de proyecto valido o se agotan los intentos maximos
	while [[ true ]];
	do
		#Preguntar el nombre del proyecto y validarlo mediante expresion regular
		PreguntarValor nombre_proyecto "Como se llama el proyecto" "^[a-z]+[0-9]*$"
		#Comprueba que se ha recibido un nombre de base de datos correcto, si no detiene la ejecucion	
		AsegurarValor "Nombre de proyecto no valido. No se puede continuar creando el proyecto" $nombre_proyecto
		[[ $? == 1 ]] && return 1
		#Si existe un directorio con ese nombre, muestra error y pide un nuevo nombre"
		if [[ -d $nombre_proyecto ]];
		then
			echo "El proyecto ya existe. Nombre invalido"
		else
			break
		fi
	done
	

	#Preguntar si se usa base de datos limitado a tres intentos
	PreguntarValor usa_base_datos "Usa usted una base de datos (s/n)" "^[sn]$" 3 "s"
	AsegurarValor "No se ha recibido una respuesta valida. No se puede continuar creando el proyecto" $usa_base_datos
	[[ $? == 1 ]] && return 1

	#En caso de usar base de datos preguntar el nombre de la misma y validamos si recibimos un nombre valido, si no se detiene la ejecucion
	if [[ $usa_base_datos == "s" ]]; then
		PreguntarValor nombre_base_datos "como se llama la base de datos" "^[a-z]+[0-9]*$"
		AsegurarValor "No se ha recibido un nombre de base de datos valido. No se puede continuar creando el proyecto" $nombre_base_datos
		[[ $? == 1 ]] && return 1
	fi
	
	#Una vez validado los datos creamos la ruta de carpetas correspondientes con el nombre del proyecto introducido
	echo_bold "Creando proyecto $nombre_proyecto ..."
	mkdir ./$nombre_proyecto
	mkdir ./$nombre_proyecto/src
	mkdir ./$nombre_proyecto/bin
	mkdir ./$nombre_proyecto/data
	mkdir ./$nombre_proyecto/log

	#Comprobamos si existe el usuario, si no lo crea.
	CrearUsuario backupP c0p1a_d3_segur1dad backupP

	#Creamos la carpeta backup en la nadie puede ejecutar, "backup", tiene la propiedad, puede leer y escribir, el usuario no puede hacwer nada y el grupo 
	#puede leer
	mkdir ./$nombre_proyecto/backup
	chmod 604 ./$nombre_proyecto/backup
	sudo chown backupP  ./$nombre_proyecto/backup
	
	#Creamos fichero de configuracion proyecto.properties con los datos del proyecto
	{
		echo PROYECTO=$nombre_proyecto
		[[ $usa_base_datos == "s" ]] && echo BASE_DATOS=$nombre_base_datos
	} > ./$nombre_proyecto/proyecto.properties
	
	echo_bold "Proyecto creado $nombre_proyecto"		
}

#
# Ejemplos de uso
#
if [[ $EJECUTAR_EJEMPLOS_CREACION_PROYECTO == true ]]; then
	
	CrearProyecto

fi
