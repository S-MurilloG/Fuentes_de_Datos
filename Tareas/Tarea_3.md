
## Tarea 3
#### Sebastián Murillo García 191838
19 de septiembre, 2021

**Nota**: para las preguntas, los comandos ejecutados en la terminal están representados en la línea `C:`, mientras que las salidas de los mismos se representan con `S:`

1. Baja con `wget` o `curl` los datos de covid nacional en la siguiente URL: https://archivo.datos.cdmx.gob.mx/casos_nacionales_covid-19.csv
```
C: curl -# -L https://archivo.datos.cdmx.gob.mx/casos_nacionales_covid-19.csv > casos_covid_tarea.csv
```

    + **Nota**: El número de registros de los datos descargados para el día 20 de septiembre a las 5:50 pm fue de `4014896 registros`.

2. Modifica los acentos por la misma letra sin acento utilizando `gsub()` de `awk`.
Comando para modificar los acentos:
```
awk -F, '{gsub(/Á/,"A"); gsub(/É/,"E"); gsub(/Í/,"I"); gsub(/Ó/,"O"); gsub(/Ú/,"U")}1' casos_covid_tarea.csv > casos_sin_acentos.csv
```

Comando para cambiar el nombre:
```
mv casos_sin_acentos.csv casos_covid_tarea.csv
```

3. Modifica a que todas las columnas estén en minúsculas ocupando `tolower()`.
Comando para modificar a minúsculas:
```
C: awk -F, '{print tolower($0)}' casos_covid_tarea.csv > casos_lower.csv
```

Comando para cambiar el nombre:
```
mv casos_lower.csv casos_covid_tarea.csv
```

Los campos con los que trabajaremos y sus respectivos números de columnas son los siguientes: `fecha_def` {$14}, `fecha_actualizacion` {$2}, `entidad_res` {$9}, `edad` {$17}, `embarazo` {$19}, `diabetes` {$22} y `sector` {$5}.

Para tener estos campos de manera "aislada" y poder analizar su contenido, se ocupó el comando:
```
C: awk -F, '{OFS=","}; {print $14, $2, $9, $17, $19, $22, $5}' casos_covid_tarea.csv > casos_aux.csv
```

4. ¿Cuántas personas fallecieron menores de 20 años? [0-19 años]
```
C: 
awk -F, '{
if(NR > 1 && length($14) != 2 && $17 < 20)
sum+=1
}
END{
print(sum)
}' casos_covid_tarea.csv

S: 497
```

5. ¿Cuántas personas embarazadas fallecieron entre julio y diciembre del 2020?
```
C: 
awk -F, '{
if(NR > 1 && $14 ~ /2020/ && $14 !~ /2020-0[1-6]/ && $19 == "\"si\"")
sum+=1
}
END{
print(sum)
}' casos_covid_tarea.csv

S: 9
```

6. ¿De las personas entre 30 y 50 [30-50] años que fallecieron, ¿cuántas tenían diabetes?
```
C:
awk -F, '{
if(NR > 1 && length($14) != 2 && $17 >= 30 && $17 <= 50 && $22 == "\"si\"")
sum+=1
}
END{
print(sum)
}' casos_covid_tarea.csv

S: 2676
```

7. De las personas que encontraste en la pregunta 6, ¿cuántas no residen en la "MICHOACÁN"?
```
C:
awk -F, '{
if(NR > 1 && length($14) != 2 && $17 >= 30 && $17 <= 50 && $22 == "\"si\"" && length($9) != 2 && $9 !~ /michoacan/)
sum+=1
}
END{
print(sum)
}' casos_covid_tarea.csv

S: 
698 sin contar las NA
```
**Nota**: No tomamos en cuenta los registros que no tienen asociada una entidad de residencia, puesto que no podemos asegurar que dichos registros no residen en Michoacán.

8. ¿Cuántas personas menores de 19 años [0-18] fallecieron en agosto del 2021?
```
C:
awk -F, '{
if(NR > 1 && $17 < 19 && $14 ~ /2021-08/)
sum+=1
}
END{
print(sum)
}' casos_covid_tarea.csv

S: 33
```

9. Verifica si la columna de fecha de defunción tiene una longitud de 10 caracteres.En caso de que no sea verifica si tiene números, de no ser así, imprime el siguiente mensaje `El renglón <NR> no tiene asociada una fecha <$fecha_def>`; si contiene números verifica que inicien con `2020` e imprime `El renglón <NR> no tiene el formato adecuado de fecha <$fecha_def>`.
```
C:
awk -F, '{
if(NR > 1 && length($14) != 10){
if($14 ~ /2020/)
print "El renglón ", NR, " no tiene el formato adecuado de fecha ", $14
else
print "El renglón ", NR, " no tiene asociada una fecha ", $14
}
}' casos_covid_tarea.csv

```

10. Cuenta cuántos registros de fallecidos tenemos de cada entidad de residencia.
Comando:
```
awk -F, '{
if(NR > 1 && length($14) != 2){
if($9 == "na")
sum+=1
else
arr[$9]+=1
}
}
END{
print "El número de registros que no tienen entidad de residencias: ", sum
for (element in arr)
print "Entidad de residencia: ", element, "; registros: ", arr[element]
}' casos_covid_tarea.csv
```

Salida:
```
El número de registros que no tienen entidad de residencias:  50551
Entidad de residencia:  "tabasco" ; registros:  4
Entidad de residencia:  "oaxaca" ; registros:  79
Entidad de residencia:  "queretaro" ; registros:  50
Entidad de residencia:  "zacatecas" ; registros:  5
Entidad de residencia:  "tamaulipas" ; registros:  18
Entidad de residencia:  "mexico" ; registros:  15571
Entidad de residencia:  "yucatan" ; registros:  5
Entidad de residencia:  "veracruz de ignacio de la llave" ; registros:  106
Entidad de residencia:  "morelos" ; registros:  157
Entidad de residencia:  "jalisco" ; registros:  11
Entidad de residencia:  "tlaxcala" ; registros:  69
Entidad de residencia:  "sonora" ; registros:  6
Entidad de residencia:  "hidalgo" ; registros:  486
Entidad de residencia:  "san luis potosi" ; registros:  20
Entidad de residencia:  "guanajuato" ; registros:  58
Entidad de residencia:  "michoacan de ocampo" ; registros:  75
Entidad de residencia:  "nayarit" ; registros:  2
Entidad de residencia:  "sinaloa" ; registros:  6
Entidad de residencia:  "guerrero" ; registros:  171
Entidad de residencia:  "puebla" ; registros:  271
Entidad de residencia:  "nuevo leon" ; registros:  11
Entidad de residencia:  "quintana roo" ; registros:  12
```

11. Cuenta cuántos registros tenemos de cada sector diferente.
Comando:
```
awk -F, '{
if(NR > 1){
if($5 == "na")
sum+=1
else
arr[$5]+=1
}
}
END{
print "El número de registros que no tienen sector: ", sum
for (element in arr)
print "Sector: ", element, "; registros: ", arr[element]
}' casos_covid_tarea.csv
```Salida:
```
El número de registros que no tienen sector:  36
Sector:  "sedena" ; registros:  13628
Sector:  "cruz roja" ; registros:  643
Sector:  "dif" ; registros:  3
Sector:  "municipal" ; registros:  1
Sector:  "estatal" ; registros:  1466
Sector:  "semar" ; registros:  6244
Sector:  "imss-bienestar" ; registros:  65
Sector:  "imss" ; registros:  480338
Sector:  "issste" ; registros:  40586
Sector:  "privada" ; registros:  139594
Sector:  "universitario" ; registros:  23
Sector:  "ssa" ; registros:  3317826
Sector:  "pemex" ; registros:  14442```
