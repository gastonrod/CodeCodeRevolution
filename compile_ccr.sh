needed_files="code_container.c final_container.c"
for file in $files;do
  if [ -f "$file" ];then
    rm $file
  else
    echo "Te falta $file. No podes compilar hasta que lo tengas"
  fi
done

if [ $# == 0 ];then
  echo No pasaste ningun argumento, nombrando al archivo por default "a.out"
  gcc final_compiler.c code_container.c board.c utilities.c 
else
  gcc final_compiler.c code_container.c board.c utilities.c -o $1
fi
