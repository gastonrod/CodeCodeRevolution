# Argumentos:
# 1: nombre del archivo con la definición del tablero en CCR  ('' por defecto)
# 2: nombre del archivo con los movimientos en CCR ('' por defecto)
# 3: nombre del programa final ('a.out' por defecto)
if [ $# -gt 3 ];then
  echo "Uso: $0 [ <board> [ <moves> [ <target> ] ] ]"
  exit 1
fi
make
if [ $? -ne 0 ];then
	exit 1
fi

BOARD_CCR="prueba_gramatica.txt"
MOVES_CCR="prueba_codigo.txt"
TARGET="a.out"
if [ $# -ge 1 ];then
	BOARD_CCR="$1"
fi
if [ $# -ge 2 ];then
	MOVES_CCR="$2"
fi
if [ $# -ge 3 ];then
	TARGET="$3"
fi

./board_compiler.out < $BOARD_CCR > board_runner.c
./code_compiler.out < $MOVES_CCR > code_container.c
gcc board_runner.c code_container.c -L. -lccr -o $TARGET
