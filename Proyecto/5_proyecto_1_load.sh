#!/bin/bash

# Ejecución del script upload.sql
psql -f upload.sql service=fuentes_de_datos

# Comando para poblar la tabla raw.precios
psql -c '\copy raw.precios from precios.csv with csv header;' service=fuentes_de_datos 

# Comando para poblar la tabla raw.estaciones
psql -c '\copy raw.estaciones from estaciones.csv with csv header;' service=fuentes_de_datos 

