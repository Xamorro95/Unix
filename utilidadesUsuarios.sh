#!/bin/bash
#
# Funciones para trabajar con usuarios y grupos
# Autor: Iván Osuna
#

# 
# Constantes utilizadas en las funciones
#
if [[ -z $EJECUTAR_EJEMPLOS_USUARIOS ]]; then
	EJECUTAR_EJEMPLOS_USUARIOS=true				# Ejecutar los ejemplos. 
																									# Si este fichero se ha importado en otro
																									# donde se ha definido esta variable, 
																									# el valor del otro prevalece.
fi


function CrearUsuario(){
	CrearGrupo $3

	count=$( grep -c '^$1:' /etc/passwd )
	if [[ $count != 1 ]];
	then
		echo "Creación del usuario $1"
		sudo useradd $1 -g $3 -p $2  &> /dev/null
	fi
}

function CrearGrupo(){
	echo "Creación del grupo $1"
	sudo groupadd -f $1  &> /dev/null
}

function BorrarUsuario(){
		echo "Borrado de usuario $1"
		sudo userdel -r $1  &> /dev/null
}

function BorrarGrupo(){
	echo "Borrado del grupo $1"
	sudo groupdel -f $1  &> /dev/null
}

#
# Ejemplos de uso
#
if [[ $EJECUTAR_EJEMPLOS_USUARIOS == true ]]; then
	CrearUsuario copia_de_seguridad c0p1a_d3_s3gur1dad copia_de_seguridad
	BorrarUsuario copia_de_seguridad
	BorrarGrupo copia_de_seguridad
fi
