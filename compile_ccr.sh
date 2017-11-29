needed_files="code_container.c board_runner.c"
for file in $files;do
  if [ -f "$file" ];then
    rm $file
  else
    echo "Te falta $file. No podes compilar hasta que lo tengas"
  fi
done

if [ $# -eq 0 ];then
  echo No pasaste ningun argumento, nombrando al archivo por default "a.out"
  gcc board_runner.c code_container.c board.c utilities.c 
else
  gcc board_runner.c code_container.c board.c utilities.c -o $1
fi
