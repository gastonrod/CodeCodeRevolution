echo Compilando
echo Flex
flex -o grammar.lex.c -l board_lexer.l
echo yacc
yacc -o grammar.tab.c -vd parser.y
echo gcc
gcc -o compiler grammar.lex.c grammar.tab.c list.c utilities.c board.c parser_utilities.c -lm -ll

./compiler > a.c < $1

gcc board.c list.c utilities.c a.c -o a.brd
