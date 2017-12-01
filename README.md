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

### Mapa del proyecto

* *parser.y*: especificación de la gramaica del lenguaje en BNF
* *board_lexer.l*: especificación de lexemas para la definición del tablero
* *code_lexer.l*: especificación de lexemas para la definición de los movimientos
* *makefile*: *makefile* para generar los compiladores
* *make.sh*: script utilitario para generar los compiladores y compilar un programa
* *clean.sh*: script utilitario para limpiar el directorio de los archivo generados
* *README.md*: este documento
* *list.c*: implementa una lista enlazada con iterador
* *utilities* y *parser_utilities*: diversas funciones utilitarias
* *board*: funciones para operar sobre un tablero
* *code_executor*: funciones que ejecutan las instrucciones del lenguaje CCR
* *ejemplo.board.ccr*: tablero de ejemplo (en CCR)
* *ejemplo.moves.ccr*: movimientos de ejmplo (en CCR)
* *types.h*: definiciones de tipos de datos comunes a varios fuentes
* *codigos*: carpeta con códigos de ejmplo

## Lenguaje

### Instrucciones disponibles
*pb* refiere al puntero de buckets
*pf* refiere al puntero a función

#### Opreaciones matemáticas

* **add**	Suma

* **sub**	Resta

* **mul**	Multiplicación

* **div**	División entera

Todas éstas tienen tres formas posibles según los parámetros

* **num**	aplica la operación con el bucket actual como primer operando y el literal numérico natural (num) como segundo operando
* **bucket**	aplica la operación con el bucket actual como primer operando y el bucket de parámetro como segundo operando
* **bucket,bucket**	aplica la operación con entre los buckets

Todas guardan el resultado de la operación en el bucket actual (apuntado por *pb*)

#### Otras operaciones

* **ipb**	Incrementa el *pb*. Si ya se encuentra en el último bucket, el comportamiento es indefinido. 

* **dpb**	Decrementa el *pb*. Si ya se encuentra en el primer bucket, el comportamiento es indefinido.

* **ipf**	Incrementa el *pf*. Si ya se encuentra en el último bucket, el comportamiento es indefinido.

* **dpf**	Decrementa el *pf*. Si ya se encuentra en el primer bucket, el comportamiento es indefinido.

* **rdc**	Lee un caracter de la entrada estándar y lo guarda en el bucket que está siendo apuntado por el *pb*; en caso de error o de fin de archivo, deja un -1

* **ptc**	Escribe a la salida estándar el caracter contenido en el bucket apuntado por *pb* putchar()

* **ply**	Ejecuta la función a la que está apuntando el *pf*. Si el bucket no contiene ninguna función, el comportamiento es indefinido.

* **ifz**	Si la variable que está siendo apuntada por el *pb* no es cero, se mueve el *“instruction pointer”* hacia el tag de *goto* inmediatamente después de la J que ejecutó la instrucción el ifz. Caso contrario, se sigue con la próxima instrucción de movimiento. Si no se encuentra un *goto* inmediatamente después de dicha J o si el *goto* refiere a una etiqueta que no fue definida, el programa aborta.

### Forma del código

* **//**	 Comentario hasta el \n, todo lo que esté entre esto y el \n se borra

* **U**		Moverse un casillero hacia arriba

* **D**		Moverse un casillero hacia abajo

* **L**		Moverse un casillero hacia la izquierda

* **R**		Moverse un casillero hacia la derecha

* **J**		Ejecutar la instrucción del casillero actual

* **{num}**	Define una etiqueta (para hacer *goto*).

* **{gotonum}** Declara la potencial etiqueta a la que saltar después de un *ifz*

* **[num]**	Define una función que se va a guardar en el bucket de funciones número *num*.

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
