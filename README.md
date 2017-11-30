# Code Code Revolution

Trabajo práctico de Autómatas, Teoría de Lenguajes y Compiladores.

## Proyecto

### Construir el proyecto

En el *root* del proyecto se encuentra el *makefile* para crear generar el proyecto.
De la ejecución del *make* interesan cuatro archivos:
* *board_compiler.out*: el compilador del tablero; recibe por entrada estándar el tablero en CCR y devuelve por salida estándar el tablero compilado en C
* *code_compiler.out*: el compilador de los movimientos; recibe por entrada estándar los movimientos en CCR y devuelve por salida estándar los movimientos compilads en C
* *libccr.a*: librería estática de utilidades; es necesaria para la compilación de los archivos generados por el *board_compiler.out*
* *libccr.h*: archivo de cabecera para la librería estática

### Uso de los compiladores

Para poder compilar un programa en CCR se necesita de dos archivos, uno con el tablero (ej: *ejemplo.board.ccr*) y otro con los movimientos (ej: *ejemplo.moves.ccr*).
La compilación se puede realizar de la siguiente forma:
```
board_compiler.out < ejemplo.board.ccr > board_runner.c
code_compiler.out < ejemplo.moves.ccr > code_container.c
gcc board_runner.c code_container.c -L. -lccr -o target.out
```

Esto genera el ejecutable *target.out*, que es el resultado de la compilación de CCR a binario de la plataforma en la que se corre.

### Script utilitario

Para facilitar la construcción y ejecución del proyecto, se provee un script BASH *make.sh*.
Éste genera el proyecto y luego compila el programa solicitado.
Para ello, recibe hasta tres argumentos: el código del tablero en CCR, el código de los movimientos en CCR y el nombre del archivo de salida, siendo todos optativos.
Para ver los defaults, véase las primeras líneas del script.
Ejemplo de uso:
```
make.sh ejemplo.board.ccr ejemplo.moves.ccr target.out
```

## Lenguaje

### Instrucciones disponibles
**pb**: puntero de buckets

**pf**: puntero a función


**add**    |

**sub**    |

**mul**    | -> (número|bucket,(bucket|número))

**div**    |
```
        add b1,b2     // Guarda en el lugar al que esté apuntando el pb la suma entre                     b1 y b2
        div b1,5     // Lo mismo pero b1/5
        add 5        // Le suma 5 al bucket apuntado por el pb
```

Increase y decrease punteros.

**ipb**    incrementa el pb 

**dpb**    decrementa el pb

**ipf**    incrementa el pf

**dpf**    decrementa el pf


**rdc**    lee un char y lo guarda en el bucket que está siendo apuntado por el pb (readchar())


**ptc**    escribe lo que sea que esté siendo apuntado por el pb (un char) (putchar())

**ply**    Ejecuta la función a la que está apuntando el pf

**ifz**    Si la variable que está siendo apuntada por el pb es cero, entonces se mueve el “instruction pointer” hacia el tag definido inmediatamente después de la J que lo hizo saltar sobre el ifz. 

### Forma del código

**//**    Comentario hasta el \n, todo lo que esté entre esto y el \n se borra

**U**    Moverse un casillero hacia arriba

**D**    Moverse un casillero hacia abajo

**L**    Moverse un casillero hacia la izquierda

**R**    Moverse un casillero hacia la derecha

**J**    Ejecutar la instrucción del casillero actual

{num}        Define un tag para hacer gotos.

{gotonum}    Es donde se ejecuta el go to después de un ifz.

[num]:       Define una función que se va a guardar en el bucket de funciones número num.

### Gramática del lenguaje

#### Tablero
**Size** ->N,N\nRule

**Rule**->N,N Op\nRule|λ

**Op**   ->add Tipo|sub Tipo|mul Tipo|div Tipo|ipb|dpb|ipf|dpf|rdc|ptc|ply|ifz

**Tipo**->N|bN,bN|bN


##### Ejemplo
```
2,3
1,1 add 1
1,2 ifz
1,3 ptc
2,1 ipb
2,2 dpb
2,3 rdc

```

### Código
**S** ->u|r|d|l|j|uS|rS|dS|lS|jS|TS|T’S|CS|FS| S|\tS|\nS|λ

**T** ->{N}

**T’**->{gotoN}

**N** ->[1-9][0-9]*

C ->//[a-zA-Z0-9 \t]*(\n|EOF)

F ->[N]:

#### Ejemplo
```
LDLJDJRJUUJRDLUJRURUJJJJUUDRJJLDLLJJJ // Inicialización (?)
LDRJDLRJJJJU{1}LDJRJDRLRDJLDRJLRDJLUDLURUDRULRJ{goto1} // Loop para imprimir caracteres
```
