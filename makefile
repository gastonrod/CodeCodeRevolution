.DEFAULT_GOAL := all
LA=flex
SA=yacc
CC=gcc
CFLAGS=-g
#CFLAGS = -g --std=c99 -D_GNU_SOURCE -pedantic -pedantic-errors -Wall -Wextra  -Werror -Wno-unused-parameter -Wno-unused-function -Wno-unused-variable
BOARD_OBJECTS=board.lex.o
CODE_OBJECTS=code.lex.o
LIB_OBJECTS=grammar.tab.o list.o utilities.o board.o parser_utilities.o
LIBRARY=libccr.a
LIB_FLAGS=-L. -lccr

grammar.tab.c: parser.y
	$(SA) -o grammar.tab.c -d parser.y -v

code.lex.c: code_lexer.l grammar.tab.c
	$(LA) -o code.lex.c -l code_lexer.l

board.lex.c: board_lexer.l grammar.tab.c
	$(LA) -o board.lex.c -l board_lexer.l

%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(LIBRARY): $(LIB_OBJECTS)
	ar rcs $(LIBRARY) $(LIB_OBJECTS)

link: $(BOARD_OBJECTS) $(CODE_OBJECTS) $(LIBRARY)
	$(CC) -static $(BOARD_OBJECTS) -o board_compiler.out $(LIB_FLAGS)
	$(CC) $(CODE_OBJECTS) -o code_compiler.out

all: link

.PHONY:	all link clean

clean:
	rm -f grammar.tab.c
	rm -f grammar.tab.h
	rm -f board.lex.c
	rm -f code.lex.c
	rm -f *.o*
	rm -f *.a
