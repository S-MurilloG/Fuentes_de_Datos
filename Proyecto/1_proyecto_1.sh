#!/bin/bash

# Verifica si el archivo estaciones.xml existe. Si no es así, lo descarga
# y lo renombra.

if [[ ! -e estaciones.xml ]]
then
printf "\nEl archivo estaciones.xml no existe\n\n"
wget https://bit.ly/2V1Z3sm
mv 2V1Z3sm estaciones.xml
printf "*********************** Descarga del archivo estaciones.xml exitosa\n"
fi


# Verifica si el archivo precios.xml existe. Si no es así, lo descarga
# y lo renombra.

if [[ ! -e precios.xml ]]
then
printf "\nEl archivo precios.xml no existe\n\n"
wget https://bit.ly/2JNcTha
mv 2JNcTha  precios.xml
printf "*********************** Descarga del archivo precios.xml exitosa\n"
fi


# Ejecución del script proyecto_1_transform_1.sh recibiendo 
# como parámetro externo el archivo precios.xml
bash proyecto_1_transform_1.sh precios.xml


# Ejecución del script proyecto_1_transform_2.sh recibiendo
# como parámetro externo el archivo de estaciones.xml
bash proyecto_1_transform_2.sh estaciones.xml


# Ejecución del script proyecto_1_load.sh para carga de datos
bash proyecto_1_load.sh

