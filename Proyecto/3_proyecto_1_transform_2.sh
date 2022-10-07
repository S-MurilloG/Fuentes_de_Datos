#!/bin/bash

# INICIO: paso 1 de transformación del archivo estaciones.xml a estaciones.csv 
#	  Se crea un archivo paso_1.csv auxiliar
#	  NOTA: El delimitador del archivo auxiliar es el caracter '~'
# ------------------------------------------------------------------------------------

gawk '{ RS="</place>"; FS="\n"

# Se extrae el valor de place_id de la gasolinera
i = match($2, /place_id="([0-9]+)"/, idd)
id = idd[1]

# Se extrae el valor de name de la gasolinera
n = match($3, /<name>(.+)</, na)
name = na[1]

# Se extraen los valores de geolocalización en diferentes casos de 'acomodo'
# de los datos en el archivo original

# Caso x,y
lo = match($6, /<x>(-?[0-9]+.?[0-9]*)/, long)
if( lo != 0){
	longitud = long[1]
	la = match($7, /<y>(-?[0-9]+.?[0-9]*)/, lat)
	if( la != 0)
		latitud = lat[1]

	# Caso x,nada
	else
		latitud = ""
}

# Caso nada,y
else{
	longitud = ""
	la = match($6, /<y>(-?[0-9]+.?[0-9]*)/, lat)
	if( la != 0)
		latitud = lat[1]
	
	# Caso nada,nada
	else
		latitud = ""
}

# Se imprime la línea correspondiente del registro obtenido con separador '~'
print id "~" name "~" latitud "~" longitud
}' $1 > paso_1.csv

# ------------------------------------------------------------------------------------
# FIN: paso 1 de transformación de archivo estaciones.xml a estaciones.csv 


# Creación del header para archivo estaciones.csv con separador '~'
echo "id_estacion~nombre~latitud~longitud" > estaciones.csv

# Eliminación de líneas sobrantes del archivo auxiliar (primera y última línea)
# y eliminación de caracter sobrante '<'
sed '1d' paso_1.csv | sed '12896d' | sed 's/<//g' >> estaciones.csv

# Eliminación de archivo auxiliar parte_1.csv
rm paso_1.csv

# ------------------------------------------------------------------------------------
# FIN: de la transformación de archivo estaciones.xml a estaciones.csv 


# Eliminación de los acentos del atributo name
gsed -i 'y/ÁÉÍÓÚáéíóú/AEIOUaeiou/' estaciones.csv

# Cambio de mayúsculas a minúsculas del atributo name
gsed -i 's/\([A-Z]\)/\L&/g' estaciones.csv

# Cambio del caracter 'Ñ' a 'ñ' (caso especial)
gsed -i 's/Ñ/\ñ/g' estaciones.csv


# Eliminación de los signos de puntuación del atributo name:

# Signos: , ; : /
gsed -i 's/[,|;|:|\/]//g' estaciones.csv

# Signos: ( )
gsed -i -r 's/\(\s?//g' estaciones.csv
gsed -i -r 's/\)//g' estaciones.csv

# Signo: .
gsed -i 's/\.\([a-z]\)/\1/g' estaciones.csv
gsed -i 's/\.\(\s\)/\1/g' estaciones.csv
gsed -i -r 's/\.\.?(~)/\1/g' estaciones.csv
gsed -i 's/30\.3 /30 3 /g' estaciones.csv

# Signo: -
gsed -i -r 's/-\s?([a-z])/\1/g' estaciones.csv
gsed -i 's/-\(~\)/\1/g' estaciones.csv 
gsed -i 's/20-20/20 20/g' estaciones.csv

# Caso especial: registro no. 11792
gsed -i '11792d' estaciones.csv

# Cambiamos el delimitador '~' por comas ','
gsed -i 's/~/,/g' estaciones.csv


# Número de estaciones diferentes

awk -F, '{
if(NR > 1 && (length($3) != 0) && ($3 != "0") && (length($4) != 0) && ($4 != "0"))
arr[$1]+=1
}
END{
for (e in arr)
sum+=1
print "Estaciones diferentes: " sum
}' estaciones.csv

echo ""

