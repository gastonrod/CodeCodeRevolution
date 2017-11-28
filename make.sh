echo Compilando
echo Flexeando el board lexer
flex -o grammar.lex.c -l board_lexer.l
echo Flexeando el code lexer
flex -o code.lex.c -l code_lexer.l
echo yacc
yacc -o grammar.tab.c -vd parser.y
echo Compilando el compilador de codigo 
gcc -o code_compiler.out code.lex.c
echo Compilando el compilador del tablero
gcc -o board_compiler.out grammar.lex.c grammar.tab.c list.c utilities.c board.c parser_utilities.c -lm -ll
if [ $# == 0 ];then
  ./board_compiler.out > final_compiler.c < prueba_gramatica.txt
else
  ./board_compiler.out > final_compiler.c < $1
fi
if [ $? == 0 ];then
  rm a.c
fi
if [ $# == 1 ] || [ $# == 0 ];then
  ./code_compiler.out > code_container.c < prueba_codigo.txt
else
  ./code_compiler.out > code_container.c < $2
fi

