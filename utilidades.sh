#!/bin/bash
#
# Funciones para capturar la entrada por consola de valores suministrados por un usuario 
# Autor: Miguel Chamorro
#

# Utilidades para formatear gr├íficamente los mensajes que aparecen por consola
source formato.sh

# 
# Constantes utilizadas en las funciones
#
if [[ -z $EJECUTAR_EJEMPLOS_UTILIDADES ]]; then
	EJECUTAR_EJEMPLOS_UTILIDADES=true				# Ejecutar los ejemplos. Si este fichero se ha importado en otro
							# donde se ha definido esta variable, el valor del otro prevalece.
fi

MAXIMO_PREGUNTAS=3 					# Numero de veces por defecto que un usuario 
							# se puede equivocar al introducir un valor

REG_EXP_NUMERO="^[1-9][0-9]*$"				# Expresi├│n regular para validar si una variable 
							# contiene un numero

# 
# PreguntarValor 
#
# Muestra un mensaje al usuario solicitando la introduccion de un valor y lo valida.
# En caso de resultar incorrecto sigue preguntandoselo un numero determinado de veces.
#
# Uso: PreguntarValor nombre_variable pregunta [regexp_validacion] [intentos_maximos] [valor_por_defecto]
# 
# Argumentos: 
# 	nombre_variable 			Variable donde se almacenara el valor introducido por el usuario
# 	pregunta 							Pregunta que se mostrara al usuario pidiendole el valor
# 	[regexp_validacion] 	Expresion regular para validar el valor introducido por el usuario
# 	[intentos_maximos] 		Numero maximo de veces que se preguntara al usuario por el valor
#													en caso de que el introducido no sea valido. Si no se especifica 
#													se le preguntara como mucho el valor indicado por la constante MAXIMO_PREGUNTAS
# 	[valor_por_defecto]		Valor que se devolver├í si el usuario no escribe ningun valor
#
function PreguntarValor(){

	local __variable=$1			# Variable donde se almacenara el valor
	local __pregunta=$2			# Pregunta a mostrar al usuario
	local __validacion="$3"	# Validacion a aplicar al valor introducido por el usuario
	local __intentos=$4			# Numero de intentos permitidos
	local __defecto=$5			# Valor por defecto si el usuario no escribe nada
	local __valor=""				# Valor que escribe el usuario por pantalla

	# Se comprueban si los argumentos suministrados a la funcion son correctos
	ComprobarValorArgumento "Nombre de variable no especificado" $__variable
	ComprobarValorArgumento "Pregunta no especificada" $__pregunta
	
	# Se inicializa la variable que se debe rellenar con el valor escrito por el usuario a vacio 
	eval $__variable=""

	# Se asignan los valores por defecto a aquellos argumentos que no se hayan suministrado
	__intentos=$(AsegurarValorArgumento $MAXIMO_PREGUNTAS $__intentos)
	ValidarValorArgumento $__intentos "$REG_EXP_NUMERO" "N├║mero m├íximo de intentos invalido"
	__validacion=$(AsegurarValorArgumento ".*" "$__validacion")

	while [[ true ]]; # Bucle para preguntar al usuario hasta que se cumpla una de las siguientes:
										# 	- que el valor introducido sea bueno
										# 	- que se le hayan dado demasiados intentos
	do
		# Preparamos la pregunta al usuario
		__msg=$(echo_verde "$__pregunta")
		if [ -n "$__defecto" ]; then			# Se muestra el valor por defect que se asignaria si no escribe nada
			local __msg2=$(echo_azul "[$__defecto]")
			__msg="$__msg $__msg2"
		fi
	
		read -p "$__msg "  __valor	# Se pregunta al usuario y se captura el valor
		
		if [ -z $__valor ]; then			# No se ha suministrado valor. Se asigna el valor por defecto
			__valor=$__defecto
		fi
		
		if [[ $__valor =~ $__validacion ]]; then
			eval $__variable="$__valor" # El valor es bueno. Se guarda en la variable indicada y se acaba
			return 0	
	  fi		

		# Si se llega a este punto es que el valor no es bueno
		let --__intentos 									# Le queda un intento menos
		if [[ $__intentos == 0 ]]; then		# Si ya no le quedan intentos se muestra un error y se sale
			echo
			echo_fatal_error "Lo siento. No se ha podido obtener un valor valido"
			echo
			return 1;
		else
			echo_inline_error "Valor invalido. " 		# Se avisa al usuario que el valor no es bueno
	  fi		

	done
}

# 
# ComprobarValorArgumento 
#
# Se asegura que se haya suministrado un valor para un argumento.
# Si no se ha suministrado se da un error al desarrollador y se corta el programa
#
# Uso: ComprobarValorArgumento error_a_mostrar argumento_a_comprobar
# 
# Argumentos: 
# 	error_a_mostrar 				Mensaje a mostrar al desarrollador si no se ha pasado el argumento
# 	argumento_a_comprobar 	Valor del argumento a comprobar
#
function ComprobarValorArgumento(){
	if [ -z $2 ]; then			# El valor no es correcto. Se muetra error y se corta la ejecucion
		echo
			echo_fatal_error "FATAL ERROR: $1"
		echo
		exit 1	
	fi
}

# 
# ValidarValorArgumento 
#
# Se asegura que se haya suministrado un valor para un argumento segun una expresi├│n regular.
# Si no se valida la expresion regular se da un error al desarrollador y se corta el programa
#
# Uso: ValidarValorArgumento valor_suministrado expresion_regular error_a_mostrar
# 
# Argumentos: 
#		valor_suministrado			Valor suministrado como argumento
# 	expresion_regular 			Expresion regular que debe validar el valor suministrado
# 	error_a_mostrar 				Mensaje a mostrar al desarrollador si no se ha pasado el argumento
#
function ValidarValorArgumento(){
	if [[ $1 =~ $2 ]]; then		# Todo bien. No se hace nada
		return 0
	else											# El valor no es correcto. Se muetra error y se corta la ejecucion
		echo
		echo_fatal_error "FATAL ERROR: $3"
		echo
		exit 1	
	fi
}

# 
# AsegurarValorArgumento 
#
# Se asegura que se haya suministrado un valor para un argumento si mo se da un valor por defecto.
#
# Uso: AsegurarValorArgumento valor_por defecto valor_suministrado
# 
# Argumentos: 
# 	valor_por_defecto 			Valor por defecto si el suministrado esta vacio
#		valor_suministrado			Valor suministrado como argumento
#
function AsegurarValorArgumento(){
	if [ -z "$2" ]; then		# Esta vacio. Se devuelve el valor por defecto
		echo "$1"
	else										# Se ha suministrado un valor, que es el que se devuelve
		echo "$2"
	fi
}

#
function AsegurarValor(){
	if [[ -z $2 ]]; then #Si el valor no es correcto. Se muestra error y se corta la ejecucion
		echo
		echo_fatal_error "$1"
		echo
		echo_pausa
		return 1	
	fi
}


#
# Ejemplos de uso
#
if [[ $EJECUTAR_EJEMPLOS_UTILIDADES == true ]]; then
	
	PreguntarValor usa_base_datos "Usa usted una base de datos (s/n)?" "^[sn]$" 2 "s"
	echo   Ha contestado: $usa_base_datos
	
	PreguntarValor nombre_base_datos "Como se llama la base de datos?" ".+"
	[[ $? == 1 ]] && echo_rojo "No ha contestado" || echo "Ha contestado: $nombre_base_datos"

fi
