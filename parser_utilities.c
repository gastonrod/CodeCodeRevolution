#include "types.h"
#include <stdio.h>
extern char* operation_type_string[];
extern char* subtype_string[];
extern struct point board_size;
extern struct point pos;
extern struct point double_b;
extern int single_b;
extern int single_n;
extern char type[3];


void print_add_instruction(operation_type ot, subtype_enum st, struct point pos){
  printf("  double_b.a = %d;\n"
         "  double_b.b = %d;\n"
	 "  single_b   = %d;\n"
	 "  single_n   = %d;\n"
	 "  pos.a      = %d;\n"
	 "  pos.b      = %d;\n"
	 "  add_instruction_to_board(board, pos.a-1, pos.b-1, *get_instruction(pos, %s, %s, double_b, single_b, single_n));\n", double_b.a, double_b.b, single_b, single_n, pos.a, pos.b, operation_type_string[ot], subtype_string[st]);
}

void print_add_composite_instruction(subtype_enum st, struct point pos){
  if     (type[0] == 'a')
    print_add_instruction(add, st, pos);
  else if(type[0] == 's')
    print_add_instruction(sub, st, pos);
  else if(type[0] == 'm')
    print_add_instruction(mul, st, pos);
  else if(type[0] == 'd')
    print_add_instruction(diV, st, pos);
}

void print_includes(){
  printf("#include \"libccr.h\"\n"
	 "#include <stdio.h>\n"
	 "#include <stdlib.h>\n"
	 "\n\n"
	 "#define BUFFER_SIZE 1024\n"
	 "\n\n"
	 "void hacer_adds();\n"
	 "void set_size();\n"
         "void yylex();\n"
	 "\n\n"
         "extern char* operation_type_string[];\n"
         "extern char* subtype_string[];\n"
	 "extern char* code;\n"
         "struct point board_size;\n"
         "struct point pos;\n"
         "struct point double_b;\n"
         "int single_b;\n"
         "int single_n;\n"
         "char type[3];\n"
         "Board board;\n"
	 "\n\n"
);
}

void print_main(){
  printf("int main(){\n"
	 "  set_size();\n"
	 "  board = malloc((sizeof *board) * board_size.a);\n"
	 "  for(int i = 0; i < board_size.a; i++)\n"
	 "    board[i] = malloc((sizeof **board) * board_size.b);\n"
     "  hacer_adds();\n"
	 "  print_board(board);\n"
	 "  run_code();\n"
	 "  return 0;\n"
         "}\n\n"
	 
	 "void hacer_adds(){\n");

}

void print_set_size(){
  printf("}\n"
         "\n\n"
         "void set_size(){\n"
	 "  board_size.a = %d;\n"
	 "  board_size.b = %d;\n"
	 "}\n", board_size.a, board_size.b);
}
