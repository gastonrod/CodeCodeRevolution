files="board_runner.c code_container.c"
make clean
for file in $files;do
  if [ -f "$file" ];then
    rm $file
  else
    echo "$file not found."
  fi
done
