if [ -f "board_compiler.out" ];then
  if [ $# -ne 1 ];then
    echo Tenes que pasar un argumento con el nombre del archivo que contiene el tablero.
  else
    ./board_compiler.out > board_runner.c < $1
    if [ $? -eq 0 ];then
      echo Hubo un error al compilar el tablero que pasaste.
      rm board_runner.c
    fi
  fi
else
  echo board_compiler.out no fue encontrado, no tiene sentido seguir.
fi
