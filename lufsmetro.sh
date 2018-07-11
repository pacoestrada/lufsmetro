#!/bin/bash

#Analizador de archivos .wav de Compilando Podcast by Paco Estrada
# Pedimos al usuario que seleccione los archivos a analizar

zenity --question --width=300 --height=200 --title "Analizador LUFS Compilando Podcast" --ok-label="Entendido" \
 --text "Analizador en fase alpha. Sólo se admiten aún archivos .wav estreo y con nombres sin espacios" ; echo $


archivos=$(zenity --file-selection --multiple --filename=/home --title="Selecciona archivos .wav para analizar")
 
case $? in
         0)
		# Esta opción se ejecuta cuando se han seleccionado ficheros                
		zenity --info --text "El audio $archivos ha sido seleccionado"
 
		;;
         1)
                zenity --error --text "No has seleccionado ningún archivo"
		exit
		;;
        -1)
                echo "Ha ocurrido un error inesperado."
		exit				
;;
esac
 
# Si se han seleccionado varios archivos tenemos que reemplazar | por un espacio
archivos=${archivos//|/ }
 
# Ahora pedimos al usuario que indique el nombre del fichero comprimido
nombre_fichero=$(zenity --file-selection --save --title="Nombre del fichero con la info de tu audio")
 
case $? in
         0)
                # Comprimimos los archivos
                
		cd /usr/bin && ./ffmpeg -i  $archivos     -af loudnorm=I=-16:dual_mono:TP=-1.5:LRA=11:print_format=summary     -f null - 2> $nombre_fichero.txt | zenity --info --text="Consulta el archivo de texto:$nombre_fichero.txt con el informe completo de tu audio.
		
		En la sección INPUT tines los valores LUFS.
		
		En la sección OUTPUT los optimos usando el normarlizador ffmpeg
		
		Gracias por usar el Lufsmetro de Compilando Podcast en fase Alfha. Reportes a redaccion@compilando.audio"
		
		;;
         1)
                zenity --error --text "No has seleccionado ningún directorio"
		exit
		;;
        -1)
                echo "Ha ocurrido un error inesperado."
		exit				
;;
esac
