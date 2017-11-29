if [ $# -gt 3 ];then
  echo Pasaste demasiados argumentos
fi
make
if [ $# -eq 0 ];then
  ./compile_board.sh prueba_gramatica.txt
else
  ./compile_board.sh $1
fi
if [ $# -eq 1 ] || [ $# -eq 0 ];then
  ./compile_code.sh prueba_codigo.txt
else
  ./compile_code.sh $2
fi

if [ $# -eq 3 ];then
  ./compile_ccr.sh $3
else
  ./compile_ccr.sh 
fi
