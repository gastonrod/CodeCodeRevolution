files="grammar.lex.c code.lex.c grammar.tab.c grammar.tab.h code_compiler.out board_compiler.out final_compiler.c code_container.c"

for file in $files;do
  if [ -f "$file" ];then
    rm $file
  else
    echo "$file not found."
  fi
done
