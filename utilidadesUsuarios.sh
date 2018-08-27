#!/bin/bash
#
# Funciones para trabajar con usuarios y grupos
# Autor: Miguel Chamorro
#

# 
# Constantes utilizadas en las funciones
#

# Ejecutar los ejemplos. Si este fichero se ha importado en otro donde se ha definido esta variable, el valor del otro prevalece.
if [[ -z $EJECUTAR_EJEMPLOS_USUARIOS ]]; then 
	EJECUTAR_EJEMPLOS_USUARIOS=true													
fi


function CrearUsuario(){
	#Llama a la funcion CrearGrupo enviando el tercer parametro recibido
	CrearGrupo $3
	
	#Comprueba si existe el usuario, si no existe le crea
	count=$( grep -c '^$1:' /etc/passwd )
	if [[ $count != 1 ]];
	then
		echo "Creacion del usuario $1"
		sudo useradd $1 -g $3 -p $2  &> /dev/null
	fi
}

function CrearGrupo(){
	echo "Creacion del grupo $1"
	#Crea el grupo recibido como parametro
	sudo groupadd -f $1  &> /dev/null
}

function BorrarUsuario(){
		echo "Borrado de usuario $1"
		#Borra al usuario recibido como parametro
		sudo userdel -r $1  &> /dev/null
}

function BorrarGrupo(){
	echo "Borrado del grupo $1"
	#Borra el grupo recibido como parametro
	sudo groupdel -f $1  &> /dev/null
}

#
# Ejemplos de uso
#
if [[ $EJECUTAR_EJEMPLOS_USUARIOS == true ]]; then
	CrearUsuario copia_de_seguridad c0p1a_d3_s3gur1dad copia_de_seguridad
	BorrarUsuario backupP
	BorrarGrupo copia_de_seguridad
fi
