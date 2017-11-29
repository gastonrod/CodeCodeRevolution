if [ $# > 2 ];then
  echo Pasaste demasiados argumentos
fi
echo Flexeando el board lexer
flex -o grammar.lex.c -l board_lexer.l
echo Flexeando el code lexer
flex -o code.lex.c -l code_lexer.l
echo yacc
yacc -o grammar.tab.c -vd parser.y
echo Compilando el compilador de codigo 
gcc -o code_compiler.out code.lex.c
echo Compilando el compilador del tablero
gcc -o board_compiler.out grammar.lex.c grammar.tab.c list.c utilities.c board.c parser_utilities.c

if [ $# == 0 ];then
  ./compile_board.sh prueba_gramatica.txt
else
  ./compile_board.sh $1
fi
if [ $# == 1 ] || [ $# == 0 ];then
  ./compile_code.sh prueba_codigo.txt
else
  ./compile_code.sh $2
fi

if [ $# == 3 ];then
  ./compile_ccr.sh $3
else
  ./compile_ccr.sh 
fi
