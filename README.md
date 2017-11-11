# CodeCodeRevolution
Trabajo práctico de TLA

#Para correrlo
flex -o grammar.lex.c -l grammar.l
vim grammar.lex.c    <- Agregar #include grammar.tab.h
yacc -o grammar.tab.c -vd parser.y
gcc -o compiler grammar.lex.c grammar.tab.c -lm -ll

