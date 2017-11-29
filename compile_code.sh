echo $1
if [ -f "code_compiler.out" ];then
  if [ $# != 1 ];then
    echo Tenes que pasar un argumento con el nombre del archivo que contiene el codigo.
  else
    ./code_compiler.out < $1 > code_container.c
    if [ $? == 0 ];then
      echo Hubo un error al compilar el codigo que pasaste.
      rm code_container.c
    fi
  fi
else
  echo code_compiler.out no fue encontrado
fi   
