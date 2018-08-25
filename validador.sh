#!/bin/bash
#Llamadas a script externos
source formato.sh

#
#Valida si se han introducido los parametros, si no muestro error
#Argumento1: $variable a comprobar
#Argumento2: texto de error a mostrar
#
function validar_argumento(){
	if [[ -z $2 ]];
	then
		echo_error "$1"
		exit 1		
	fi	
}


#
#Comprueba si tiene argumentos, si no devuelve otro que recibe como segundo argumento
#Argumento1: Numero por defecto de errores; 3
#Argumento2: $errores, a comprobar si esta vacia
#
function asegurar_valor(){
	if [[ -z "$2" ]];
	then
		echo "$1"
	else
		echo "$2"
	fi
}

#
#Recibe un parametro a regular y se valida contra una expresion regular que recibe por un segundo parametro, si falla cierra el programa
#Argumento1: Variable a regular
#Argumento2: Expresion regular con la que contrastamos argumento1
#Argumento3: Texto a mostrar en error
#
function comprobar_argumento(){
	if [[ $1 =~ $2 ]];
	then	
		:
	else
		echo_error "$3"
		exit 2
	fi
}


#Mando los parametros introducidos a funcion vaidar_argumento() para comprobar si los han introducido
function pedir_valor(){
	variable=$1
	pregunta=$2
	errores=$3
	validacion="$4"

	validar_argumento "No se ha introducido una variable inicial" $variable 
	validar_argumento "No se ha realizado ninguna pregunta" $pregunta
	
	errores=$(asegurar_valor 3 $errores) 
	validacion=$(asegurar_valor "*" "$validacion")		
	
	exp_errores=$(comprobar_argumento $variable "$validacion" "Error de validacion de variable")	
	comprobar_argumento $errores "^[0-9]+$" "Error de validacion de numero"
}

pedir_valor hola hola 3 



#!/bin/bash
#Llamadas a script externos
source formato.sh


#
#Valida si se han introducido los parametros, si no muestro error
#Argumento1: $variable a comprobar
#Argumento2: texto de error a mostrar
#
function validar_argumento(){
	if [[ -z $2 ]];
	then
		echo_error "$1"
		exit 1		
	fi	
}


#
#Comprueba si tiene argumentos, si no devuelve otro que recibe como segundo argumento
#Argumento1: Numero por defecto de errores; 3
#Argumento2: $errores, a comprobar si esta vacia
#
function asegurar_valor(){
	if [[ -z "$2" ]];
	then
		echo "$1"
	else
		echo "$2"
	fi
}


#
#Recibe un parametro a regular y se valida contra una expresion regular que recibe por un segundo parametro, si falla cierra el programa
#Argumento1: Variable a regular
#Argumento2: Expresion regular con la que contrastamos argumento1
#Argumento3: Texto a mostrar en error
#
function comprobar_argumento(){
	if [[ $1 =~ $2 ]];
	then	
		:
	else
		echo_error "$3"
		exit 2
	fi
}


#
#Al ejecutar la funcion recibe cuatro parametros, una variable, una pregunta, un numero maximo de errores y una expresion regular para validar.
#Comprobamos que la hayamos recibido una variable, si no es asi sale del programa.
#Comprobamos que la hayamos recibido una pregunta, si no es asi, sale del programa.
#Comprobamos si lo hemos recibido el numero de errores, si no es asi, asignamos 3 como valor por defecto. 
#Comprobamos que el numero de errores introducido sea un numero.
#Comprobamos si la hemos recibido la validacion, si no es asi, establecemos por defecto "*"
#Generamos un bucle con el maximo numero de errores posibles, si supera el total vdevuelve un false al validador.
#Mediante un validador, comprobamos si se ha producido el numero maximo de erroes o no, si es asi, vuelve al menu principal
#
function pedir_valor(){
	local variable=$1
	local pregunta=$2
	local errores=$3
	local validacion="$4"

	validar_argumento "No se ha introducido una variable inicial" $variable 
	eval $variable=""
	validar_argumento "No se ha realizado ninguna pregunta" $pregunta
	
	errores=$(asegurar_valor 3 $errores) 
	validacion=$(asegurar_valor "*" "$validacion")		
	
	comprobar_argumento $errores "^[0-9]+$" "Error de validacion de numero"

	valido=false
	while [[ $errores > 0 ]];
	do	
		read -p "$pregunta" respuesta
		if [[ $respuesta =~ $validacion ]];
		then
			valido=true
			eval $variable="$respuesta"
			break
		else
			echo_error "Error al introducir la respuesta"
		fi
		errores=$(($errores - 1))
	done	
	
	if [[ $valido == false ]];
	then
		echo_error "Demasiados intentos fallidos"
		return 3
	fi
}

pedir_valor Oracle "Vas a usar base de datos:" 3 "^[sn]$"
