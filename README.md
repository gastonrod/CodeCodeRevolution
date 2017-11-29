# Code Code Revolution

Trabajo práctico de Automatas, Teoria de Lenguajes y Compiladores.

# Correr el proyecto

Clona el repositorio

Si no le pasas argumento al make.sh toma por default prueba_gramatica.txt como board a armar y prueba_codigo.txt como el codigo a ejecutar.

Si le pasas 1 argumento asume que es el board a armar. 

Si le pasas dos argumentos el 1ero es el board el 2ndo es el codigo.

Si le pasas tres argumentos, lo mismo de arriba y el 3ero es el nombre del ejecutable que se genera con ese board y ese tablero.
```
./make.sh [archivo con el tablero definido]
```
Esto va a dejar un
```
code_compiler.out
cboard_compiler.out

final_compiler.c
code_container.c
```

Para usar el board_compiler.out esta el script compile_board.sh, al cual le pasas por argumento el tablero que quieras compilar.

Lo mismo con el code_compiler.out y compile_code.sh.

Esto ya lo hizo automaticamente el make.sh con lo que le hayas pasado. Pero en caso de querer usar un codigo para mas de un tablero, o un tablero para varios codigos.

En caso de querer haber compilado otro codigo u otro tablero y no queres hacer el make.sh denuevo, podes hacer 
```
./compile_ccr.sh [ nombre que queres para el ejecutable ]
```

Que te genera un ejecutable a partir del ultimo tablero que hayas compilado y el ultimo codigo que hayas compilado ( final_compiler.c y code_container.c )


Y voila!

# Instrucciones disponibles
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

# Forma del codigo

//    Comentario hasta el \n, todo lo que esté entre esto y el \n se borra

U    Moverse un casillero hacia arriba

D    Moverse un casillero hacia abajo

L    Moverse un casillero hacia la izquierda

R    Moverse un casillero hacia la derecha

{num}        Define un tag para hacer gotos.

{gotonum}    Es donde se ejecuta el go to después de un ifz.

[num]:       Define una función que se va a guardar en el bucket de funciones número num.

# Gramatica del lenguaje

## Tablero
**Size** ->N,N\nRule

**Rule**->N,N Op\nRule|λ

**Op**   ->add Tipo|sub Tipo|mul Tipo|div Tipo|ipb|dpb|ipf|dpf|rdc|ptc|ply|ifz

**Tipo**->N|bN,bN|bN


### Ejemplo
```
2,3
1,1 add 1
1,2 ifz
1,3 ptc
2,1 ipb
2,2 dpb
2,3 rdc

```

## Codigo
**S** ->u|r|d|l|j|uS|rS|dS|lS|jS|TS|T’S|CS|FS| S|\tS|\nS|λ

**T** ->{N}

**T’**->{gotoN}

**N** ->[1-9][0-9]*

C ->//[a-zA-Z0-9 \t]*(\n|EOF)

F ->[N]:

### Ejemplo
```
LDLJDJRJUUJRDLUJRURUJJJJUUDRJJLDLLJJJ // Inicializacion (?)
LDRJDLRJJJJU{1}LDJRJDRLRDJLDRJLRDJLUDLURUDRULRJ{goto1} // Loop para imprimir caracteres
```
