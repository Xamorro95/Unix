#!/bin/bash

underline=$(tput sgr 0 1)
bold=$(tput bold)
rojo=$(tput setaf 1)
verde=$(tput setaf 2)
amarillo=$(tput setaf 3)
azul=$(tput setaf 4)
morado=$(tput setaf 5)
resetFormato=$(tput sgr0)

function echo_rojo(){
   echo "${rojo}$1${resetFormato}"	
}

function echo_verde(){
   echo "${verde}$1${resetFormato}"	
}

function echo_amarillo(){
   echo "${amarillo}$1${resetFormato}"	
}

function echo_azul(){
   echo "${azul}$1${resetFormato}"	
}

function echo_morado(){
   echo "${morado}$1${resetFormato}"	
}

function echo_bold(){
   echo "${bold}$1${resetFormato}"	
}

function echo_underline(){
   echo "${underline}$1${resetFormato}"	
}

function echo_pausa(){
		echo
		read -p "${verde}Pulsa cualquier tecla para continuar...${resetFormato}" -N 1 
}

function echo_titulo(){
		echo
   echo "${bold}${verde}$1${resetFormato}"	
		echo
}

function echo_error(){
   echo "${rojo}$1${resetFormato}"	
}

function echo_inline_error(){
   echo -n "${rojo}$1${resetFormato}"	
}

function echo_fatal_error(){
   echo "${bold}${rojo}$1${resetFormato}"	
}
