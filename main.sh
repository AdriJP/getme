#!/bin/bash

#GETME CLI MULTITASK COMMAND VERSION 0.1
# Comando creado por AdriJP

uname=$(whoami); # CHAR[] NOMBRE DE USUARIO
red="\033[1;31m"; # CHAR[] TEXTO ROJO
green="\033[1;32m"; # CHAR[] TEXTO VERDE
cyan="\033[1;36m"; # CHAR[] TEXTO CYAN

# FUNCION -wi CONSULTA EL DIRECTORIO EN EL QUE SE ENCUENTRA EL USUARIO
if [ "$1" = "-wi" ] # CONDICIONAL DE LA FUNCION -wi
then
	dir=$(pwd); # CHAR[] DIRECTORIO ACTUAL

	if [ "$dir" = "/" ] # CONDICIONAL PARA RESPUESTA PERSONALIZADA /
	then
		printf "Te encuentras en el directorio raiz\n";
		printf "$dir\n";

		exit 0;
	fi

	if [ "$dir" = "/home/$uname" ] # CONDICIONAL PARA RESPUESTA PERSONALIZADA /home/user
	then
		printf "Te encuentras en tu directorio personal\n";
		printf "$dir\n";

		exit 0;
	fi

	printf "Ruta del directorio actual:\n";
	printf "$dir\n";

	exit 0;
fi

# FUNCION -dl PARA LISTAR LOS ELEMENTOS DE UN DIRECTORIO
if [ "$1" = "-dl" ] # CONDICIONAL DE LA FUNCION -dl
then
	if [ "$2" = "" ] # SI NO EXISTE 2º ARGUMENTO EL COMANDO MUESTRA UN ERROR
	then
		printf "${red}ERROR, -dl necesita que le pases un directorio!!\n";

		exit 1;
	fi

	if [ -d $2 ] # AL PASARLE UN DIRECTORIO LA FUNCION SE EJECUTA
	then
		dlist=$(ls $2); # CHAR[] LISTA DE ELEMENTOS
		clist=$(echo $dlist | wc -w); # INT CANTIDAD DE ELEMENTOS

		printf "Total de elementos: $clist\n";
		printf "Elementos del directorio $2:\n";
		printf "${green}$dlist\n";

		exit 0;
	else # SI EL 2º ARGUMENTO NO ES UN DIRECTORIO EL COMANDO MUESTRA UN ERROR
		printf "${red}ERROR, -dl necesita que le pases un directorio!!\n";

		exit 1;
	fi
fi

#FUNCION -sc PARA COPIAS DE SEGURIDAD DE ARCHIVOS
if [ "$1" = "-sc" ] # CONDICIONAL DE LA FUNCION -sc
then
	bbdd="/home/$uname/getme/bbdd/"; # CHAR[] DIRECTORIO DE LA BASE DE DATOS
	if [ -e "$2" ] # SI EL ARCHIVO EXISTE PROCEDE A COPIARLO
	then
		if [ -d $bbdd ]
		then
			cp $2 $bbdd;

			printf "${green}Archivo $2 copiado en el siguiente directorio:\n";
			printf "$bbdd\n";

			exit 0;
		else # SI LA BASE DE DATOS NO EXISTE, ES CREADA POR EL COMANDO
			mkdir $bbdd;

			cp $2 $bbdd;

			printf "${green}Archivo $2 copiado en el siguiente directorio:\n";
			printf "$bbdd\n";

			exit 0;
		fi
	else # SI EL 2º ARGUMENTO NO ES UN ARCHIVO EL COMANDO MUESTRA UN ERROR
		printf "${red}ERROR, -sc neesita que le pases un archivo!!\n";

		exit 1;
	fi
fi

# SI NO EXISTEN ARGUMENTOS EL COMANDO IMPRIMIE EL SIGUIENTE MENSAJE
if [ "$1" = "" ]
then
	printf "${cyan}GETME CLI MULTITASK COMMAND VERSION O.1\n";
	printf "${cyan}Este comando necesita argumentos para operar\n";
	printf "${cyan}Introduce -h para ver una lista con las opciones del comando\n";

	exit 0;
fi
