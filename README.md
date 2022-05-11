# Ayuda administrativa

## Scrips

Un conjunto de scripts y manuales que ayudan a la administración de la
materia.

### siu2nice

`siu2nice` recibe como parámetro una lista de archivos de resumen de cursada en
formato `xls` y escribe a salida estándar un archivo separado por `TAB`s
(`.tsv`). Las columnas del resultado son: el número de legajo en seis dígitos
completado con ceros (necesario para el `eyegrade`), el nombre completo con
solo las primeras letras de cada palabra en mayúscula (el _siu_ lo tiene todo
en mayúsculas), y el legajo completo.

Uso:

    ./siu2nice resumen1.xml [resumen2.xml]... [resumenN.xml] > alumnos.tsv

Lamentablemente el script se tiene casi cada año por que el _siu_ cambia el
formato de los resúmenes cuando se le da la gana.


### record_screen.sh

`record_screen.sh` permite seleccionar un área de la pantalla para que sea
grabada como una cámara web virtual.

Para que funcione necesita que este cargado el modulo `v4l2loopback`. Si el
sistema ya tiene una cámara web, es posible que se deba modificar
`/dev/video0` por otro dispositivo virtual.

Al ejecutar el script se abrirán dos ventanas. Mover la ventana que dice
"Mover" hasta el área de la pantalla que se quiere grabar. Cuando la ventana
este ubicada en el lugar correcto, presionar "Listo" en la otra ventana.

    sudo modprobe v4l2loopback
    ./record_screen.sh

Basado en [este código](https://gist.github.com/anonymous/3927068).

### listaFinal

`listaFinal` crea un resumen de las notas de los parciales (no de las
promociones). Los archivos son `.tsv`. La primer columna es el número de
legajo en seis dígitos completado con cero, y la segunda el nombre completo
del alumno. En los archivos `res*` la tercera columna es la nota del parcial o
recuperatorio correspondiente.
    
    ./listaFinal listaAlumnos res1p res1r res2p res2r >resultado.tsv

# Eyegrade

**TODO**
