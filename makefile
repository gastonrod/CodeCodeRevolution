.DEFAULT_GOAL := all
LA=flex
SA=yacc
CC=gcc
CFLAGS = -g --std=c99 -D_GNU_SOURCE -pedantic -pedantic-errors -Wall -Wextra  -Werror -Wno-unused-parameter -Wno-unused-function -Wno-unused-variable
BOARD_OBJECTS=board.lex.o grammar.tab.o
CODE_OBJECTS=code.lex.o
LIB_OBJECTS=list.o utilities.o board.o parser_utilities.o code_executor.o
LIBRARY=libccr.a
LIBRARY_HEADER=libccr.h
LIB_FLAGS=-L. -lccr

grammar.tab.c: parser.y
	$(SA) -o grammar.tab.c -d parser.y -v

code.lex.c: code_lexer.l grammar.tab.c
	$(LA) -o code.lex.c -l code_lexer.l

board.lex.c: board_lexer.l grammar.tab.c
	$(LA) -o board.lex.c -l board_lexer.l

grammar.tab.o: grammar.tab.c
	$(CC) -c $< -o $@

code.lex.o: code.lex.c
	$(CC) -c $< -o $@

board.lex.o: board.lex.c
	$(CC) -c $< -o $@

%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(LIBRARY): $(LIB_OBJECTS)
	ar rcs $(LIBRARY) $(LIB_OBJECTS)
	TEMP_HEADER="temp_header.h";	\
	touch $$TEMP_HEADER;	\
	FILES="$(LIB_OBJECTS)";	\
	for FILE in $$FILES;do	\
		HEADER=$$(echo "$$FILE" | sed "s/\.o$$/\.h/g");	\
		echo "#include \""$$HEADER"\"" >> $$TEMP_HEADER;	\
		echo >> $$TEMP_HEADER;	\
	done;	\
	gcc -E -P $$TEMP_HEADER -o $(LIBRARY_HEADER);	\
	rm -f $$TEMP_HEADER

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
	rm -f libccr.h
