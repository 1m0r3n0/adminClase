#!/bin/bash

#####################################################################################
#############################  PRESENTACION DE SCRIPT  ##############################
#####################################################################################
clear
figlet -c "/!\ ADVERTENCIA /!\ "
echo
echo "		     PARA MEJOR EXPERIENCIA INSTALE FIGLET    "
echo
echo "                         $ sudo apt-get install figlet        "
sleep 3

clear
echo
figlet -c Administracion de Clase
echo
sleep 2
clear
#####################################################################################
#####################################################################################
#####################################################################################

function _menu() #MUESTRA MENU PRINCIPAL
{
	echo
	figlet -c MENU
	echo
	echo "      [A]ltas"
	echo "      [B]ajas"
	echo "      [M]odificacion Nota Alumno"
	echo "      [C]onsulta Notas Alumno"
	echo "      [N]ota Media Alumno"
	echo "      [P]romedio de la Clase"
	echo
	echo "      [S]alir"
	echo
	echo -n "      Seleccione una opcion --> "
}

function _altas() #FUNCION PARA AÑADIR ALUMNO
{
	clear
	echo
	figlet -c ALTAS
	sleep 1

		echo
		echo -n " Nombre -> " 
			read nombre
		echo -n " Apellido -> "
			read apellido
		echo -n " Aula -> "
			read aula
		echo -n " Nota 1ª evaluacion -> "
			read ev1
		echo -n " Nota 2ª evaluacion -> "
			read ev2
		echo -n " Nota 3ª evaluacion -> "
			read ev3
 
		echo -\n $nombre:$apellido:$aula:$ev1:$ev2:$ev3 >> alumnoDB 
		# GENERA UN FICHERO CON LOS DATOS GUARDADOS EN LAS VARIABLES

		echo
		echo " Se acaba de dar de alta un alumno"

	sleep 2
	clear
}

function _bajas() #FUNCION PARA ELIMINAR UN ALUMNO
{
	clear
	echo
	figlet -c BAJAS
	sleep 1

		echo -n " Nombre -> "
			read del_nombre
		echo -n " Apellido -> "
			read del_apellido

		grep -v $del_nombre:$del_apellido alumnoDB > temp 
		# GENERA UN FICHERO TEMPORAL CON TODOS LOS DATOS EXCEPTO LA LINEA DONDE COINCIDA CON LOS DATOS DADOS EN AMBAS VARIABLES
		
		mv temp alumnoDB
		# RENOMBRA EL FICHERO TEMPORAL AL NOMBRE DEL FICHERO DONDE SE GUARDAN LOS DATOS

		echo
		echo " Se acaba de dar de baja un alumno"

	sleep 2
	clear
}

function _modificacion() #FUNCION PARA MODIFICAR LAS NOTAS DEL ALUMNO
{

	clear
	echo
	figlet -c MODIFICACION DE NOTAS
	sleep 1

		echo -n " Nombre -> "
			read mod_nombre
		echo -n " Apellido -> "
			read mod_apellido

		DATOS=(
			`grep $mod_nombre:$mod_apellido alumnoDB | cut -d: -f 1` 
			`grep $mod_nombre:$mod_apellido alumnoDB | cut -d: -f 2` 
			`grep $mod_nombre:$mod_apellido alumnoDB | cut -d: -f 3` 
			`grep $mod_nombre:$mod_apellido alumnoDB | cut -d: -f 4` 
			`grep $mod_nombre:$mod_apellido alumnoDB | cut -d: -f 5` 
			`grep $mod_nombre:$mod_apellido alumnoDB | cut -d: -f 6`)
		# ARRAY DONDE SE GUARDAN TODOS LOS DATOS CUYA COINCIDENCIA SEA IGUAL A LOS DATOS AÑADIDOS 
		# EN LAS VARIABLES mod_nombre Y mod_apellido
		
		OPCION2=""

		while test "&OPCION2" != 0;
		do
			echo
			echo " ¿Que desea hacer?"
			echo
			echo " [1] Modificar nota 1º Evaluacion"
			echo " [2] Modificar nota 2º Evaluacion"
			echo " [3] Modificar nota 3º Evaluacion"
			echo " [0] Salir"
			echo
			echo -n " Escoja una opcion -> "
				read OPCION2

				case $OPCION2 in
					1) echo
					   echo -n " ¿Que nota quiere poner? -> "
						  read N1
							grep -v $mod_nombre:$mod_apellido alumnoDB > temp
							echo ${DATOS[0]}:${DATOS[1]}:${DATOS[2]}:$N1:${DATOS[4]}:${DATOS[5]} >> temp
							mv temp alumnoDB
					   echo
					   echo " Nota modificada de ${DATOS[3]} a $N1"
					   sleep 2
					   clear
					   break;;

					2) echo
					   echo -n " ¿Que nota quiere poner? -> "
						  read N2
							grep -v $mod_nombre:$mod_apellido alumnoDB > temp
							echo ${DATOS[0]}:${DATOS[1]}:${DATOS[2]}:${DATOS[3]}:$N2:${DATOS[5]} >> temp
							mv temp alumnoDB
					   echo
					   echo " Nota modificada de ${DATOS[3]} a $N2"
					   sleep 2
					   clear
					   break;;

					3) echo
					   echo -n " ¿Que nota quiere poner? -> "
					      read N3
							grep -v $mod_nombre:$mod_apellido alumnoDB > temp
							echo ${DATOS[0]}:${DATOS[1]}:${DATOS[2]}:${DATOS[3]}:${DATOS[4]}:$N3 >> temp
							mv temp alumnoDB
					   echo
					   echo " Nota modificada de ${DATOS[3]} a $N3"
					   sleep 2
					   clear
					   break;;

					# LA OPERACION ES PARECIDA A LA DE BAJA CON EL AÑADIDO DE QUE SE AÑADE UNA LINEA CON LOS DATOS GUARDADOS 
					# EXCEPTO LA NOTA A CAMBIAR QUE EN VEZ DE USAR EL ARRAY USAREMOS LA VARIABLE QUE RECOJE LA NUEVA NOTA
					

					0) clear
					   break;;

					*) clear;;

				esac
		done
}


function _consulta() #FUNCION PARA CONSULTAR NOTAS DEL ALUMNO
{
	clear
	echo
	figlet -c CONSULTAS DE NOTAS
	sleep 1

		echo -n " Nombre -> "
			read con_nombre
		echo -n " Apellido -> "
			read con_apellido

			NT1=`grep $con_nombre:$con_apellido alumnoDB | cut -d: -f 4`
			NT2=`grep $con_nombre:$con_apellido alumnoDB | cut -d: -f 5`
			NT3=`grep $con_nombre:$con_apellido alumnoDB | cut -d: -f 6`
			# GUARDAMOS LAS NOTAS EN 3 VARIABLES

		OPCION3=""

		while test "&OPCION3" != 0;
		do
			echo
			echo " ¿Que desea hacer?"
			echo
			echo " [1] Consultar nota 1º Evaluacion"
			echo " [2] Consultar nota 2º Evaluacion"
			echo " [3] Consultar nota 3º Evaluacion"
			echo " [0] Salir"
			echo
			echo -n " Escoja una opcion -> "
				read OPCION3

				case $OPCION3 in
					1) echo
					   echo -n " [*] La nota de la 1º Evaluacion es: $NT1"
					   sleep 5
					   clear
					   break;;

					2) echo
					   echo -n " [*] La nota de la 2º Evaluacion es: $NT2"
					   sleep 5
					   clear
					   break;;

					3) echo
					   echo -n " [*] La nota de la 3º Evaluacion es: $NT3"
					   sleep 5
					   clear
					   break;;
					   # MOSTRARA LA NOTA CORRESPONDIENTE A EL CONTENIDO DE LA VARIABLE

					0) clear
					   break;;

					*) clear;;
				esac
		done
}

function _media() #FUNCION PARA CALCULAR LA MEDIA DE UN ALUMNO
{
	clear
	echo
	figlet -c NOTA MEDIA
	sleep 1

		echo -n " Nombre -> "
			read med_nombre
		echo -n " Apellido -> "
			read med_apellido

			NOTA1=`grep $med_nombre:$med_apellido alumnoDB | cut -d: -f 4`
			NOTA2=`grep $med_nombre:$med_apellido alumnoDB | cut -d: -f 5`
			NOTA3=`grep $med_nombre:$med_apellido alumnoDB | cut -d: -f 6`
			# MISMAS VARIABLES QUE EN LA FUNCION CONSULTA PERO CON DISTINTO NOMBRE

			SUMA=$((`echo $NOTA1`+`echo $NOTA2`+`echo $NOTA3`)) 
			#HACEMOS LA SUMA DE LAS 3 VARIABLES

			MEDIA=$((`echo $SUMA`/`echo 3`))
			#DIVIDIMOS LA VARIABLE SUMA ENTRE 3

		echo
		echo " Su nota media es: $MEDIA"
		sleep 5
		clear
}

function _promedio() #FUNCION QUE CALCULA EL PROMEDIO DE LA CLASE
{
	clear
	echo
	figlet -c PROMEDIO DE LA CLASE
	sleep 1

	limiteBucle=$((`cut -d":" -f4 alumnoDB | grep -v nota | wc -l`-1))
	#LIMITE DEL BUCLE

	contadorLinea=`cut -d":" -f4 alumnoDB | grep -v nota | wc -l`
	#CUENTA EL NUMERO DE LINEAS QUE TIENE EL FICHERO QUE GUARDA LOS DATOS

	for i in $(seq 0 $limiteBucle);
    do
	    contador=$((1 + $i))
	    #SUMA 1 VUELTA AL BUCLE

	    L1=`sed -n "$contador"p alumnoDB | cut -d: -f4`
	    L2=`sed -n "$contador"p alumnoDB | cut -d: -f5`
	    L3=`sed -n "$contador"p alumnoDB | cut -d: -f6`
	    #ESTAS 3 VARIABLES GUARDAN LAS NOTAS: L1=1EV, L2=2eV, L3=3ev

	    a=$(($a+$L1))
	    b=$(($b+$L2))
	    c=$(($c+$L3))
	    #ESTAS 3 VARIABLES ACUMULAN EL TOTAL DEL ACUMULADO DE CADA EVALUACION
    done

    sumaNota=$(($a+$b+$c))
	mediaLinea=$(($sumaNota/$contadorLinea))
	promedio=$(($mediaLinea/3))
	#CALCULOS PARA OBTENER EL PROMEDIO DE LA CLASE

	echo 
    echo "  PROMEDIO DE LA CLASE --> $promedio"
	echo 
	
	sleep 5
	clear

}

function _salir() # FUNCION PARA SALIR DEL SCRIPT
{
	clear
	echo
	figlet -c "GRACIAS POR SU USO."
	figlet -c "HASTA LA VISTA"
	echo
	figlet -c "; )"
	sleep 3
	clear
	exit
}

# ESTA PARTE DEL COGIDO SIRVE PARA QUE EN CASO DE DAR A LAS OPCIONES INDICADAS 
# ESTE REDIRIJA A LA FUNCION DETERMINADA
OPCION="¨"

	while test "&OPCION" != "S" || "&OPCION" != "s";
	do
		case $OPCION in
			a|A)
				_altas
				_menu
				;;
			b|B)
				_bajas
				_menu
				;;
			m|M)
				_modificacion
				_menu
				;;
			c|C)
				_consulta
				_menu
				;;
			n|N)
				_media
				_menu
				;;
			p|P)
				_promedio
				_menu
				;;
			s|S)
				_salir
				;;
			¨)
				_menu
				;;	
			*)	
				clear
				figlet " : ("
				echo
				echo " OPCION INCORRECTA "
				echo
				sleep 1
				clear
				_menu
				;;

		esac
		read OPCION
	done

#FIN PROGRAMA
