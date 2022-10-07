
## Tarea 2
#### Sebastián Murillo García 191838
5 de septiembre, 2021

**Nota**: para las preguntas, los comandos ejecutados en la terminal están representados en la línea `C:`, mientras que las salidas de los mismos se representan con `S:`

1. Con `wget` o `curl` baja el archivo de nombres desde 1880 hasta 2014 de censos de Estados Unidos de la siguiente URL: https://www.dropbox.com/s/ezrp0t7uwyg7vgi/NationalNames.zip?dl=0
```
C: curl -# -L https://www.dropbox.com/s/ezrp0t7uwyg7vgi/NationalNames.zip?dl=0 > national_names.zip
```

2. Descomprime el archivo con `unzip`
```
C: unzip national_names.zip
```

3. Cambia el nombre del archivo a `census_names.csv`
```
C: mv NationalNames.csv census_names.csv
```

Utilizando `sed` y/o `grep` responde las siguientes preguntas:
    + Las modificaciones se realizan en el archivo original

4. Modifica los nombres de las columnas para que estén todas en minúsculas.
```
C: gsed -i '1s/\([A-Z]\)/\L&/g' census_names.csv

Las columnas quedaron como: id,name,year,gender,count
```

5. `Anna` o `Ana`
    + a. ¿Cuántos registros hay que tenga el nombre `Anna` o `Ana`?
```
C: grep -Ec An+a, census_names.csv
S: 447
```

    + b. Modifica los registros que tengan `Anna` o `Ana` por el que aparezca más veces (imputación).

Para Anna: `grep -Ec Anna, census_names.csv`; con `267` registros
Para Ana: `grep -Ec Ana, census_names.csv`; con `180` registros

Podemos confirmar que `267 + 180 = 447`, siendo `Anna` el registro que aparece más veces.

Comando para imputación:
```
C: gsed -i -r 's/Ana,/Anna,/g' census_names.csv
```

    + c. Verifica que tienes el mismo número de registros para ahora todas las `Anna` o `Ana` 

Para Anna: `grep -Ec Anna, census_names.csv`; con `447` registros
Para Ana: `grep -Ec Ana, census_names.csv`; con `0` registros

Podemos comprobar que tenemos el mismo número de registros y que todas las `Ana` cambiaron a `Anna`

6. `Emma` o `Ema`
    + a. ¿Cuántos registros hay que tenga el nombre `Emma` o `Ema`?
```
C: grep -Ec Em+a, census_names.csv
S: 364
```

    + b. Modifica los registros que tengan `Emma` o `Ema` por el que aparezca más veces (imputación).

Para Emma: `grep -Ec Emma, census_names.csv`; con `246` registros
Para Ema: `grep -Ec Ema, census_names.csv`; con `118` registros

Podemos confirmar que `246 + 118 = 364`, siendo `Emma` el registro que aparece más veces.

Comando para imputación:
```
C: gsed -i -r 's/Ema,/Emma,/g' census_names.csv
```

    + c. Verifica que tienes el mismo número de registros para ahora todas las `Emma` o `Ema`

Para Emma: `grep -Ec Emma, census_names.csv`; con `364` registros
Para Ema: `grep -Ec Ema, census_names.csv`; con `0` registros

Podemos comprobar que tenemos el mismo número de registros y que todas las `Ema` cambiaron a `Emma`

7. Kateleen` o `Katilynn` o `Katelynn` o `Kateline` o `Katelin` o `Katelynne` o `Katelyne` o `Katelynd` o `Katelinn` o `Katelen` o `Katelyn` o inclusive con `C`
    + a. ¿Qué implicación consideras relevante en hacer estos cambios en los nombres? Considera que estamos tratando con datos de un censo
```
Si bien parece ser que un cambio de los nombres de las personas puede ser insignificante, hay que considerar que estos identifican y diferencian a las personas en la sociedad. Puede ser que esta modificación haga que sea más sencillo manejar los datos, pero eso no justifica el hecho de que estamos modificando un aspecto esencial de las personas: sus nombres. Esto puede llegar a escalar a otros niveles de importancia si es que se empiezan a tomar decisiones que puedan afectar a la sociedad. También considero que no es una falta tan grave. Creo yo que la respuesta a favor o en contra depende de la utilización de los datos
```

    + b. ¿Cuántos registros hay que tengan todas las combinaciones de `Katelyn`?
```
C: grep -Ec '[K|C]at[e|i]l[e|y|i]+n+e?d?,' census_names.csv
S: 487
```

    + c. Modifica los registros que tengan el nombre de `Katelyn` con todas su variantes por el que aparezca más veces (imputación).

Para Kateleen: `grep -Ec Kateleen, census_names.csv`; con `17` registros
Para Katilynn: `grep -Ec Katilynn, census_names.csv`; con `26` registros
Para Katelynn: `grep -Ec Katelynn, census_names.csv`; con `38` registros
Para Katelin: `grep -Ec Katelin, census_names.csv`; con `38` registros
Para Kateline: `grep -Ec Kateline, census_names.csv`; con `15` registros
Para Katelynne: `grep -Ec Katelynne, census_names.csv`; con `31` registros
Para Katelyne: `grep -Ec Katelyne, census_names.csv`; con `27` registros
Para Katelynd: `grep -Ec Katelynd, census_names.csv`; con `20` registros
Para Katelinn: `grep -Ec Katelinn, census_names.csv`; con `20` registros
Para Katelen: `grep -Ec Katelen, census_names.csv`; con `23` registros
Para Katelyn: `grep -Ec Katelyn, census_names.csv`; con `63` registros
Para Katilyn: `grep -Ec Katilyn, census_names.csv`; con `34` registros
Para Katilin: `grep -Ec Katilin, census_names.csv`; con `16` registros
Para Katelind: `grep -Ec Katelind, census_names.csv`; con `10` registros

Para Catilyn: `grep -Ec Catilyn, census_names.csv`; con `13` registros
Para Catelyn: `grep -Ec Catelyn, census_names.csv`; con `30` registros
Para Catelynn: `grep -Ec Catelynn, census_names.csv`; con `27` registros
Para Catelin: `grep -Ec Catelin, census_names.csv`; con `29` registros
Para Catilin: `grep -Ec Catilin, census_names.csv`; con `9` registros
Para Catelynne: `grep -Ec Catelynne, census_names.csv`; con `1` registros

Podemos confirmar que la suma: 
```
17 + 26 + 2(38) + 15 + 31 + 27 + 2(20) + 23 + 63 + 34 + 16 + 10 + 13 + 30 + 27 + 29 + 9 + 1 = 487
```
Siendo `Katelyn` el registro que aparece más veces.

Comando para imputación:
```
C: gsed -i -r 's/[K|C]at[e|i]l[e|y|i]+n+e?d?,/Katelyn,/g' census_names.csv
```

    + d. Verifica que tienes el mismo número de registros una vez que hiciste la modificación.

Para Katelyn (el nombre más registrado): `grep -Ec Katelyn, census_names.csv`; con `487` registros

Por lo tanto, para cualquier otra variante ahora tenemos `0` registros, así que podemos confirmar que todas cambiaron a `Katelyn`


8. `Jennie` o `Jenni` o `Jeni` o `Yenni` o `Yeni` o `Yennie`
    + a. ¿Cuántos registros hay que tengan todas las combinaciones de Jennie`?
```
C: grep -Ec '[Y|J]en+ie?,' census_names.csv
S: 419
```

    + b. Modifica los registros que tengan el nombre de `Jennie` con todas su variantes por el que aparezca más veces (imputación).

Para Jennie: `grep -Ec Jennie, census_names.csv`; con `195` registros
Para Jenni: `grep -Ec Jenni, census_names.csv`; con `70` registros
Para Jeni: `grep -Ec Jeni, census_names.csv`; con `69` registros
Para Yenni: `grep -Ec Yenni, census_names.csv`; con `11` registros
Para Yeni: `grep -Ec Yeni, census_names.csv`; con `37` registros
Para Yennie: `grep -Ec Yennie, census_names.csv`; con `1` registros
Para Jenie: `grep -Ec Jenie, census_names.csv`; con `36` registros

Podemos confirmar que la suma: 
```
195 + 70 + 69 + 11 + 37 + 1 + 36 = 419
```
Siendo `Jennie` el registro que aparece más veces.

Comando para imputación:
```
C: gsed -i -r 's/[Y|J]en+ie?,/Jennie,/g' census_names.csv
```

    + c. Verifica que tienes el mismo número de registros una vez que hiciste la modificación.

Para Jennie (el nombre más registrado): `grep -Ec Jennie, census_names.csv`; con `419` registros

Por lo tanto, para cualquier otra variante tenemos `0` registros, así que podemos confirmar que todas cambiaron a `Jennie`
