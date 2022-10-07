#!/bin/bash

# INICIO: parte 1 de transformación del archivo precios.xml a precios.csv 
#	  Se crea un archivo parte_1.csv auxiliar
# ------------------------------------------------------------------------------------

gawk '{ RS="</place>"; FS="\n"

# Se extrae el valor de place_id de la gasolinera
i = match($2, /([0-9]+)/,idd)
id = idd[1]

# Se extraen los valores de gas_price en diferentes casos de 'acomodo'
# de los datos en el archivo original

# Caso: regular,premium,diesel
if ( (match($3, /"regular">([0-9]+.?[0-9]*)/, reg) != 0) && (match($4, /"premium">([0-9]+.?[0-9]*)/, prem) != 0) && (match($5, /"diesel">([0-9]+.?[0-9]*)/, die) != 0) ){
	regular = reg[1]
	premium = prem[1]
	diesel = die[1]
}

# Caso: regular,premium
else if ( (match($3, /"regular">([0-9]+.?[0-9]*)/, reg) != 0) && (match($4, /"premium">([0-9]+.?[0-9]*)/, prem) != 0) ){
	regular = reg[1]
	premium = prem[1]
	diesel = ""
}

# Caso: regular,diesel
else if ( (match($3, /"regular">([0-9]+.?[0-9]*)/, reg) != 0) && (match($4, /"diesel">([0-9]+.?[0-9]*)/, die) != 0) ){
	regular = reg[1]
	premium = ""
	diesel = die[1]
}

# Caso: regular
else if( match($3, /"regular">([0-9]+.?[0-9]*)/, reg) != 0 ){
	regular = reg[1]
	premium = ""
	diesel = ""
}
			
# Caso: premium,diesel
else if ( (match($3, /"premium">([0-9]+.?[0-9]*)/, prem) != 0) && (match($4, /"diesel">([0-9]+.?[0-9]*)/, die) != 0) ){
	regular = ""
	premium = prem[1]
	diesel = die[1]
}

# Caso: premium
else if ( (match($3, /"premium">([0-9]+.?[0-9]*)/, prem) != 0) ){
	regular = ""
	premium = prem[1]
	diesel = ""
}

# Caso: diesel
else if ( (match($3, /"diesel">([0-9]+.?[0-9]*)/, die) != 0) ){
	regular = ""
	premium = ""
	diesel = die[1]
}

# Se imprime la línea correspondiente del registro obtenido
print id "," regular "," premium "," diesel

}' $1 > parte_1.csv

# ------------------------------------------------------------------------------------
# FIN: parte 1 de transformación de archivo precios.xml a precios.csv 

# Creación del header para archivo precios.csv
echo "estacion_servicio,regular,premium,diesel" > precios.csv

# Eliminación de líneas sobrantes del archivo auxiliar (primera y última línea)
# y eliminación de caracter sobrante '<'
sed '1d' parte_1.csv | sed '20710d' | sed 's/<//g' >> precios.csv

# Eliminación de archivo auxiliar parte_1.csv
rm parte_1.csv

# ------------------------------------------------------------------------------------
# FIN: de la transformación de archivo precios.xml a precios.csv 

echo ""

# Número de gasolineras que sirven gasolina regular
r=$(grep -Ec '^\d+,\d+' precios.csv)
echo "Gasolineras que sirven gasolina regular: " $r

# Número de gasolineras que sirven gasolina premium
p=$(grep -Ec '^\d+,\d*\.?\d*,\d+' precios.csv)
echo "Gasolineras que sirven gasolina premium: " $p

# Número de gasolineras que sirven gasolina diesel
d=$(grep -Ec '^\d+,\d*\.?\d*,\d*\.?\d*,\d+' precios.csv)
echo "Gasolineras que sirven gasolina diesel: " $d

echo ""

# Número de gasolineras diferentes

awk -F, '{
if(NR > 1)
arr[$1]++
}
END{
for(e in arr)
sum++
print "Gasolineras diferentes: " sum
}' precios.csv


# INICIO: creación de archivo con precios colapsados
# 	  Se crea un archivo p_aux.csv auxiliar
# ------------------------------------------------------------------------------------

awk -F, '{
if(NR > 1){

id_gas[$1]=$1

if($2 != "")
reg[$1]=$2

if($3 != "")
prem[$1]=$3

if($4 != "")
die[$1]=$4
}
}
END{
print "estacion_servicio,regular,premium,diesel"
for (id in id_gas)
print id "," reg[id] "," prem[id] "," die[id]
}' precios.csv > p_aux.csv

# Cambio de nombre de archivo auxiliar
mv p_aux.csv precios.csv

# ------------------------------------------------------------------------------------
# FIN: creación de archivo con precios colapsados

# Número de observaciones de precios
# Con el tail no contamos el header como observación
obs=$(tail -12654 precios.csv | wc -l)
echo "Observaciones de precios: " $obs
