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

### buscar

`buscar` es un script que permite buscar rapidamente las notas de los alumnos
para cargarlos en las actas de cursado, utilizando la terminologia del _siu_.

### totalNotas

`totalNotas` resume la cantidad de aprobados, desaprobados y ausentes. Se le
debe proveer el archivo de resultados generado por `listaFinal`.

```
$ ./totalNotas resultado.tsv
-       Aprobados: 235 (47%)
-       Desaprobados: 140 (28%)
-       Ausentes: 118 (23%)
-       Aus+Des: 258 (52%)
-       Total: 493
```


# Eyegrade

## Instalación

Ante problemas, consultar la documentación oficial de [eyegrade][eye_inst].
Para `Debian` ejecutar los siguientes comandos:

    sudo apt update
    sudo apt dist-upgrade
    sudo apt install v4l2loopback-utils ffmpeg \
        python3 python3-pip python3-venv \
        texlive texlive-latex-recommended \
        texlive-latex-extra texlive-extra-utils \
        zathura
    export PATH="$PATH:$HOME/.local/bin"
    sudo apt install pipx
    pipx install eyegrade # Si no anda, cerrar el bash y volverlo a abrir

Idealmente la linea `export PATH="$PATH:$HOME/.local/bin"` debería agregarse
al `.profile`, ya que ahí es donde se instalan los ejecutables del `eyegrade`,
y esa linea en particular se va a tener que repetir con frecuencia.

[eye_inst]: https://www.eyegrade.org/doc/user-manual/#installation-on-gnu-linux

## Creación de los exámenes

Para crear los exámenes se deben crear dos archivos:

-   `exam-questions.xml`: donde se especifican las preguntas y respuestas
    correctas. Ver archivo de [ejemplo][eye_xml].

-   `template.tex`: Este es un archivo de `LaTex` donde se especifica la
    caratula y estructura del examen. Se agregan marcas especiales
    (especificadas en [este documento][eye_template]) para indicar donde se
    debe insertar la tabla de respuestas y la lista de preguntas.

[eye_xml]: https://www.eyegrade.org/doc/user-manual/#editing-the-questions-of-the-exam
[eye_template]: https://www.eyegrade.org/doc/user-manual/#editing-the-latex-template

Para crear 3 modelos de examen (modelo *A*, *B* y *C*), y un modelo *0* que
mantiene todas las preguntas y respuestas en el orden que aparecen en
`exam-questions.xml`, debo moverme hasta la carpeta que contiene los archivos
`exam-questions.xml` y `template.tex`, luego ejecutar:

    export PATH="$PATH:$HOME/.local/bin"
    eyegrade-create -e exam-questions.xml -m 0ABC template.tex -o exam

### Impresión

Al imprimir un gran número de páginas se debe tener en cuenta que la memoria
de trabajo de la impresora es reducida. Es suficiente como para mantener una
sola hoja (ambas caras) a la vez, por lo que entre hoja y hoja, abra un
retardo extra. Se recomienda imprimir todas las copias de una hoja (ambas
caras) juntas, es decir, imprimir 80 copias de la primera hoja y luego 80 de
la segunda hoja.

Ademas, se recomienda probar con la impresión de un par de exámenes. Recordar
chequear que sea visible el modelo en todas las hojas y que se este
imprimiendo a doble faz. En nuestras pruebas, `okular` fallaba en esto último,
recomiendo usar `zathura` (presionar `CRTL+p` para imprimir).

## Evaluación

**WIP**
