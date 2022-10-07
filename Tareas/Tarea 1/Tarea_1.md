
## Tarea 1
#### Sebastián Murillo García 191838
24 de agosto, 2021

**Nota**:para cada una de las preguntas, los comandos ejecutados en la terminal están representados en la línea `C:`, mientras que las salidas de los mismos se representan con `S:`

1. Bajar con `curl` o `wget` el archivo `first_5k.csv.zip` de la URL: https://www.dropbox.com/s/zlb4zr3xwcwkyn7/first_5k.csv.zip?dl=0
```
C: curl -# -L https://www.dropbox.com/s/zlb4zr3xwcwkyn7/first_5k.csv.zip?dl=0 > first_5k.csv.zip
```

2. Con el comando `unzip` extrae el contenido del `zip y contesta las siguientes preguntas:
```
C: unzip first_5k.csv.zip
```

3. ¿Cuántas líneas tiene el archivo?
```
C: wc -l first_5k.csv
S: 5432123 
```

4. ¿Cuántos registros tienen la palabra `soriana`?
```
C: grep -Eic soriana first_5k.csv
S: 968297
```

5. ¿Cuántos registros tienen la palabra `tortilla`?
Si tomamos en cuenta una búsqueda de la palabra `tortilla` incluyendo su plural `tortillas`, el comando y la salida queda de la siguiente manera
```
C: grep -Eic tortilla first_5k.csv
S: 69881
```
    + **Extra**: Si consideramos **solamente** la búsqueda de los registros que tienen la palabra `tortilla` ***en singular***, lo solicitado quedaría de esta manera:  
```
C: grep -Eic tortilla[^s] first_5k.csv
S: 56436
```
Para el resto de los ejercicios, se tomará en cuenta la búsqueda de la palabra `tortilla` incluyendo su plural 

6. De los registros que tienen la palabra `tortilla`, ¿de qué estado de la república es el 13vo último elemento y cuál es el precio?
```
C: grep -Ei tortilla first_5k.csv | tail -13 | head -1
S: "TORTILLA DE MAIZ","1 KG. GRANEL","S/M","TORTILLAS Y DERIVADOS DEL MAIZ","BASICOS",12.5,"2011-11-28 00:00:00.000","TORTILLERIAS TRADICIONALES","TORTILLERIA","TORTILLERIA SANTA RITA SUCURSAL SANTA RITA","AV. BENIGNO VALENZUELA S/N, ENTRE RUBEN JARAMILLO Y 10","SINALOA","GUASAVE",25.555519,-108.454705

Respuesta: Sinaloa, 12.5 pesos
```

7. ¿Cuántos registros tienes que sean de la categoría `juguetes` del estado `quintana roo` y que sean `hot wheels`?
```
C: grep -Ei juguete first_5k.csv | grep -Ei "quintana roo" | grep -Eic "hot wheels"
S: 116
```

8. ¿Cuántos registros de tiendas de autoservicio tienes?
```
C: grep -Eic "tienda de autoservicio" first_5k.csv
S: 4547966
```

9. ¿Cuántos registros de papelerías tienes?
Para esta pregunta consideramos la posibilidad de que la palabra `papelería` pueda o no tener acento
```
C: grep -Eic "papeler[í|i]a" first_5k.csv
S: 154667
```

10. ¿Cuántos registros de tortillería tienes?
Al igual que la pregunta pasada, se consideró la opción de que la palabra `tortillería` pueda tener acento o no
```
C: grep -Eic "tortiller[í|i]a" first_5k.csv
S: 33038
```
